#!/usr/bin/env python
"""Aligner les prochaines étapes sur la navigation MkDocs (--write pour corriger)."""

import argparse
import os
import re
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parent.parent
SECTION = re.compile(
    r"^## (?:Prochaine étape|Prochaines étapes|Où aller ensuite \?|À lire ensuite|Suite)\s*\n.*?(?=^## |\Z)",
    re.MULTILINE | re.DOTALL,
)


def flatten(items, parent=""):
    for item in items:
        for title, value in item.items():
            if isinstance(value, list):
                yield from flatten(value, title)
            else:
                if parent and title in {"Accueil", "Introduction", "Présentation", "Tutoriel", "Référence", "Comparaison"}:
                    title = f"{parent} — {title}"
                yield title, value


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--write", action="store_true")
    args = parser.parse_args()
    # Lire seulement nav : le reste du YAML contient des tags Python MkDocs.
    config = (ROOT / "mkdocs.yml").read_text(encoding="utf-8")
    nav = yaml.safe_load("nav:\n" + config.split("\nnav:\n", 1)[1])["nav"]
    pages = list(flatten(nav))
    paths = [path for _, path in pages]
    if len(paths) != len(set(paths)):
        raise SystemExit("Une page figure plusieurs fois dans le menu.")
    if list(nav[-1]) != ["Annexe"]:
        raise SystemExit("Annexe doit être la dernière section du menu.")
    appendix = {path for _, path in flatten(nav[-1]["Annexe"])}
    reference_sections = [i for i, item in enumerate(nav) if "Références Claude" in item]
    if reference_sections and reference_sections != [len(nav) - 2]:
        raise SystemExit("Références Claude doit précéder immédiatement Annexe.")
    errors = []
    for i, (_, current) in enumerate(pages):
        page = ROOT / "docs" / current
        text = page.read_text(encoding="utf-8")
        heading = text.splitlines()[0]
        if current in appendix and "Claude" in heading and "Copilot" not in heading:
            raise SystemExit(f"La page Claude doit être hors Annexe : {current}")
        dedicated = (
            "Copilot" in heading and "Claude" not in heading
        ) or Path(current).name in {
            "comparaison-copilot-claude.md", "migration-pas-a-pas.md", "migration-30-60-90.md"
        }
        if dedicated and current not in appendix:
            raise SystemExit(f"La page Copilot doit figurer dans Annexe : {current}")
        if i + 1 < len(pages):
            title, target = pages[i + 1]
            relative = os.path.relpath(target, Path(current).parent).replace("\\", "/")
            body = f"Poursuivez avec **[{title}]({relative})**, la page suivante dans le menu."
        else:
            relative = os.path.relpath("index.md", Path(current).parent).replace("\\", "/")
            body = f"Vous avez atteint la fin de l'annexe. Retrouvez les parcours recommandés dans **[Accueil]({relative})**."
        section = f"## Prochaine étape\n\n{body}\n\n"
        matches = list(SECTION.finditer(text))
        if len(matches) > 1:
            raise SystemExit(f"Plusieurs sections de progression : {current}")
        if matches:
            updated = SECTION.sub(lambda _: section, text, count=1)
        else:
            source = re.search(r"^## Sources\b", text, re.MULTILINE)
            if source:
                updated = text[:source.start()].rstrip() + "\n\n---\n\n" + section + text[source.start():]
            else:
                updated = text.rstrip() + "\n\n---\n\n" + section
        updated = updated.rstrip() + "\n"
        if updated != text:
            errors.append(current)
            if args.write:
                page.write_text(updated, encoding="utf-8")
    print(f"{len(pages)} pages vérifiées ; {len(errors)} progression(s) " + ("corrigée(s)." if args.write else "à corriger."))
    if errors and not args.write:
        for path in errors:
            print(f"  {path}")
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
