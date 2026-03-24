#!/usr/bin/env python
"""
Link Validation Script for MkDocs Documentation

Validates all internal links in the generated site directory.
Reports broken links, missing files, and redirects.
"""

import os
import re
from pathlib import Path
from typing import Set, Tuple, List

class LinkValidator:
    def __init__(self, site_dir: str = "site"):
        self.site_dir = Path(site_dir)
        self.broken_links = []
        self.valid_links = []
        self.external_links = []
        self.html_files = []
        
    def validate(self):
        """Run complete validation"""
        print(f"📋 Link Validation Report — {self.site_dir}")
        print("=" * 60)
        
        # Find all HTML files
        self.find_html_files()
        print(f"\n✅ Found {len(self.html_files)} HTML files")
        
        # Extract and validate links
        self.validate_all_links()
        
        # Print results
        self.print_report()
        
    def find_html_files(self):
        """Find all .html files in site directory"""
        self.html_files = list(self.site_dir.glob("**/*.html"))
        
    def validate_all_links(self):
        """Validate links in all HTML files"""
        for html_file in self.html_files:
            self.validate_file(html_file)
            
    def validate_file(self, html_file: Path):
        """Validate links in a single HTML file"""
        try:
            with open(html_file, 'r', encoding='utf-8') as f:
                content = f.read()
        except UnicodeDecodeError:
            print(f"⚠️  Encoding error: {html_file}")
            return
            
        # Find all href links
        pattern = r'href=["\'](.*?)["\']'
        links = re.findall(pattern, content)
        
        for link in links:
            self.validate_link(link, html_file)
            
    def validate_link(self, link: str, source_file: Path):
        """Validate a single link"""
        # Skip external links, anchors-only, and special protocols
        if link.startswith(('http://', 'https://', 'mailto:', 'tel:', '#')):
            self.external_links.append(link)
            return
            
        # Handle relative paths
        if link.startswith('/'):
            # Absolute path from site root
            target = self.site_dir / link.lstrip('/')
        else:
            # Relative path
            target = (source_file.parent / link).resolve()
            
        # Remove fragment if present
        target_path = str(target).split('#')[0]
        
        # Check if file exists
        if os.path.exists(target_path):
            self.valid_links.append(link)
        else:
            self.broken_links.append({
                'link': link,
                'source': str(source_file.relative_to(self.site_dir)),
                'target': target_path
            })
            
    def print_report(self):
        """Print validation report"""
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
        return len(self.broken_links) == 0


if __name__ == "__main__":
    validator = LinkValidator("site")
    success = validator.validate()
    exit(0 if success else 1)
