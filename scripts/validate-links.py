#!/usr/bin/env python
"""Validate internal links and anchors in a generated MkDocs site.

The validator understands the path prefix configured by ``site_url`` (for
example ``/doc-utilisation-ia/`` on GitHub Pages), so absolute links generated
by Material are resolved against the local ``site/`` directory correctly.
It also validates URL fragments against generated HTML ``id``/``name`` anchors.
"""

import re
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit


class AnchorCollector(HTMLParser):
    """Collect browser-addressable anchors from one generated HTML document."""

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.anchors = set()

    def handle_starttag(self, tag, attrs):
        attributes = dict(attrs)
        element_id = attributes.get("id")
        if element_id:
            self.anchors.add(element_id)

        # ``name`` is legacy HTML, but browsers still support named <a> anchors.
        if tag == "a" and attributes.get("name"):
            self.anchors.add(attributes["name"])


class LinkValidator:
    def __init__(self, site_dir: str = "site", config_file: str = "mkdocs.yml"):
        self.site_dir = Path(site_dir).resolve()
        self.config_file = Path(config_file)
        self.base_path = self._load_base_path()
        self.broken_links = []
        self.valid_links = []
        self.external_links = []
        self.html_files = []
        self._anchor_cache = {}

    def _load_base_path(self) -> str:
        """Return the URL path prefix from MkDocs ``site_url`` if configured.

        Do not parse the whole MkDocs YAML file: Material uses Python-specific
        YAML tags (for example ``!!python/name:...``) that PyYAML SafeLoader is
        intentionally unable to construct. We only need the top-level
        ``site_url`` scalar, so reading that line directly is safer and keeps
        this validator independent from MkDocs' custom YAML loader.
        """
        if not self.config_file.exists():
            return ""

        text = self.config_file.read_text(encoding="utf-8")
        match = re.search(r"(?m)^site_url:\s*['\"]?([^'\"\s]+)['\"]?\s*$", text)
        if not match:
            return ""

        return urlsplit(match.group(1)).path.rstrip("/")

    def validate(self):
        """Run complete validation and return True when no broken links remain."""
        print(f"📋 Link Validation Report — {self.site_dir}")
        print(f"🌐 MkDocs base path — {self.base_path or '/'}")
        print("=" * 60)

        self.find_html_files()
        print(f"\n✅ Found {len(self.html_files)} HTML files")

        self.validate_all_links()
        return self.print_report()

    def find_html_files(self):
        """Find all .html files in site directory."""
        self.html_files = list(self.site_dir.glob("**/*.html"))

    def validate_all_links(self):
        """Validate links in all HTML files."""
        for html_file in self.html_files:
            self.validate_file(html_file)

    def validate_file(self, html_file: Path):
        """Validate links in a single HTML file."""
        try:
            content = html_file.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            print(f"⚠️  Encoding error: {html_file}")
            return

        links = re.findall(r'href=["\'](.*?)["\']', content)
        for link in links:
            self.validate_link(link, html_file)

    def _resolve_target(self, link_path: str, source_file: Path) -> Path:
        """Resolve a URL path to a generated file-system target."""
        if not link_path:
            return source_file

        if link_path.startswith("/"):
            # Material emits root-relative URLs using MkDocs' site_url path.
            if self.base_path and link_path == self.base_path:
                link_path = "/"
            elif self.base_path and link_path.startswith(f"{self.base_path}/"):
                link_path = link_path[len(self.base_path) :]
            return (self.site_dir / link_path.lstrip("/")).resolve()

        return (source_file.parent / link_path).resolve()

    @staticmethod
    def _html_target(target: Path) -> Path:
        """Return the HTML document represented by a valid generated target."""
        if target.is_dir():
            return target / "index.html"
        return target

    def _anchors_for(self, html_file: Path):
        """Return cached anchors for a generated HTML file."""
        html_file = html_file.resolve()
        if html_file in self._anchor_cache:
            return self._anchor_cache[html_file]

        if not html_file.is_file() or html_file.suffix.lower() != ".html":
            anchors = set()
        else:
            try:
                content = html_file.read_text(encoding="utf-8")
            except UnicodeDecodeError:
                anchors = set()
            else:
                collector = AnchorCollector()
                collector.feed(content)
                anchors = collector.anchors

        self._anchor_cache[html_file] = anchors
        return anchors

    def validate_link(self, link: str, source_file: Path):
        """Validate one href against the generated site tree and HTML anchors."""
        parsed = urlsplit(link)

        # Network URLs and non-document protocols are outside this validator.
        if parsed.scheme or parsed.netloc or link.startswith(("mailto:", "tel:", "javascript:", "data:")):
            self.external_links.append(link)
            return

        link_path = unquote(parsed.path)
        fragment = unquote(parsed.fragment)
        target = self._resolve_target(link_path, source_file)

        # With use_directory_urls, a directory is a valid target because its
        # generated index.html is what the web server serves.
        if not target.exists():
            self.broken_links.append(
                {
                    "kind": "path",
                    "link": link,
                    "source": str(source_file.relative_to(self.site_dir)),
                    "target": str(target),
                }
            )
            return

        if fragment:
            html_target = self._html_target(target)
            anchors = self._anchors_for(html_target)
            if fragment not in anchors:
                self.broken_links.append(
                    {
                        "kind": "anchor",
                        "link": link,
                        "source": str(source_file.relative_to(self.site_dir)),
                        "target": f"{html_target}#{fragment}",
                    }
                )
                return

        self.valid_links.append(link)

    def print_report(self):
        """Print the report and return True when validation succeeded."""
        print("\n" + "=" * 60)
        print(f"✅ Valid Internal Links: {len(self.valid_links)}")
        print(f"🔗 External Links: {len(set(self.external_links))}")
        print(f"❌ Broken Links/Anchors: {len(self.broken_links)}")

        if self.broken_links:
            print("\n🔴 BROKEN INTERNAL LINKS/ANCHORS FOUND:")
            print("-" * 60)
            for broken in self.broken_links:
                print(f"\n  Kind: {broken['kind']}")
                print(f"  Source: {broken['source']}")
                print(f"  Link: {broken['link']}")
                print(f"  Target: {broken['target']}")
        else:
            print("\n✅ NO BROKEN INTERNAL LINKS OR ANCHORS FOUND!")

        print("\n" + "=" * 60)
        return not self.broken_links


if __name__ == "__main__":
    validator = LinkValidator("site")
    success = validator.validate()
    raise SystemExit(0 if success else 1)
