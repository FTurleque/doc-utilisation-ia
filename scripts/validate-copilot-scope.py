#!/usr/bin/env python
"""Vérifier que le parcours principal ne conserve que des liens Copilot vers Annexe."""
import posixpath
import re
from pathlib import Path
from urllib.parse import unquote

import yaml

from importlib.util import module_from_spec, spec_from_file_location

ROOT = Path(__file__).resolve().parent.parent
spec = spec_from_file_location("navigation", ROOT / "scripts/sync-navigation.py")
navigation = module_from_spec(spec)
spec.loader.exec_module(navigation)
config = (ROOT / "mkdocs.yml").read_text(encoding="utf-8")
nav = yaml.safe_load("nav:\n" + config.split("\nnav:\n", 1)[1])["nav"]
annex = {path for _, path in navigation.flatten(nav[-1]["Annexe"])}
pattern = re.compile(r"copilot|applyTo|\.agent\.md|\.prompt\.md|\.instructions\.md|\.github[/\\](?:instructions|agents|prompts|skills|hooks)|AI Credits|premium requests", re.I)
errors = []
pages = list(navigation.flatten(nav[:-1]))
for _, path in pages:
    text = (ROOT / "docs" / path).read_text(encoding="utf-8")
    def link(match):
        label, target = match.groups()
        dest = posixpath.normpath(posixpath.join(posixpath.dirname(path), unquote(target.split("#")[0])))
        return "" if dest in annex else label
    # Les destinations ne sont pas du texte éditorial : certains anciens
    # répertoires Claude contiennent « copilot » pour préserver leurs URL.
    visible = re.sub(r"\[([^\]]*)\]\(([^\s)]+)\)", link, text)
    for number, line in enumerate(visible.splitlines(), 1):
        if pattern.search(line):
            errors.append(f"{path}:{number}: {line.strip()}")
print(f"{len(pages)} pages principales vérifiées ; {len(errors)} passage(s) hors annexe.")
for error in errors:
    print(error)
raise SystemExit(bool(errors))
