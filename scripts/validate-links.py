#!/usr/bin/env python
"""Validate internal links in a generated MkDocs site.

The validator understands the path prefix configured by ``site_url`` (for
example ``/doc-utilisation-ia/`` on GitHub Pages), so absolute links generated
by Material are resolved against the local ``site/`` directory correctly.
"""

import os
import re
from pathlib import Path
from urllib.parse import unquote, urlsplit

import yaml


class LinkValidator:
    def __init__(self, site_dir: str = "site", config_file: str = "mkdocs.yml"):
        self.site_dir = Path(site_dir)
        self.config_file = Path(config_file)
        self.base_path = self._load_base_path()
        self.broken_links = []
        self.valid_links = []
        self.external_links = []
        self.html_files = []

    def _load_base_path(self) -> str:
        """Return the URL path prefix from MkDocs ``site_url`` if configured."""
        if not self.config_file.exists():
            return ""

        with self.config_file.open("r", encoding="utf-8") as stream:
            config = yaml.safe_load(stream) or {}

        site_url = config.get("site_url") or ""
        return urlsplit(site_url).path.rstrip("/")

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
            with html_file.open("r", encoding="utf-8") as stream:
                content = stream.read()
        except UnicodeDecodeError:
            print(f"⚠️  Encoding error: {html_file}")
            return

        links = re.findall(r'href=["\'](.*?)["\']', content)
        for link in links:
            self.validate_link(link, html_file)

    def validate_link(self, link: str, source_file: Path):
        """Validate one href against the generated site tree."""
        if link.startswith(("http://", "https://", "mailto:", "tel:", "#")):
            self.external_links.append(link)
            return

        parsed = urlsplit(link)
        link_path = unquote(parsed.path)

        if link_path.startswith("/"):
            # Material emits root-relative URLs using MkDocs' site_url path.
            if self.base_path and link_path == self.base_path:
                link_path = "/"
            elif self.base_path and link_path.startswith(f"{self.base_path}/"):
                link_path = link_path[len(self.base_path) :]
            target = self.site_dir / link_path.lstrip("/")
        else:
            target = (source_file.parent / link_path).resolve()

        # A directory produced by use_directory_urls is a valid target because
        # MkDocs serves its index.html automatically.
        if target.exists() or (target.is_dir() and (target / "index.html").exists()):
            self.valid_links.append(link)
            return

        self.broken_links.append(
            {
                "link": link,
                "source": str(source_file.relative_to(self.site_dir)),
                "target": str(target),
            }
        )

    def print_report(self):
        """Print the report and return True when validation succeeded."""
        print("\n" + "=" * 60)
        print(f"✅ Valid Internal Links: {len(self.valid_links)}")
        print(f"🔗 External Links: {len(set(self.external_links))}")
        print(f"❌ Broken Links: {len(self.broken_links)}")

        if self.broken_links:
            print("\n🔴 BROKEN LINKS FOUND:")
            print("-" * 60)
            for broken in self.broken_links:
                print(f"\n  Source: {broken['source']}")
                print(f"  Link: {broken['link']}")
                print(f"  Target: {broken['target']}")
        else:
            print("\n✅ NO BROKEN LINKS FOUND!")

        print("\n" + "=" * 60)
        return not self.broken_links


if __name__ == "__main__":
    validator = LinkValidator("site")
    success = validator.validate()
    raise SystemExit(0 if success else 1)
