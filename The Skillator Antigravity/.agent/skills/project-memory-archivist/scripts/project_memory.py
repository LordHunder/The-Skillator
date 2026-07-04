from __future__ import annotations

import argparse
import re
from datetime import date
from pathlib import Path


SECTIONS = {
    "plan": ("Plans", "plans"),
    "walkthrough": ("Walkthroughs", "walkthroughs"),
    "decision": ("Decisions", "decisions"),
    "research": ("Research", "research"),
    "session": ("Sessions", "sessions"),
}

INDEX_TEMPLATE = """# Project Memory Index

Keep durable project knowledge here. Prefer short, well-linked notes over long,
duplicated summaries.

## Plans

## Walkthroughs

## Decisions

## Research

## Sessions
"""


def slugify(text: str) -> str:
    slug = re.sub(r"[^a-z0-9]+", "-", text.lower()).strip("-")
    return slug or "untitled"


def ensure_layout(root: Path, memory_dir: str) -> Path:
    memory_root = root / memory_dir
    memory_root.mkdir(parents=True, exist_ok=True)

    for _, folder in SECTIONS.values():
        (memory_root / folder).mkdir(parents=True, exist_ok=True)

    (memory_root / "assets").mkdir(parents=True, exist_ok=True)

    index_path = memory_root / "INDEX.md"
    if not index_path.exists():
        index_path.write_text(INDEX_TEMPLATE, encoding="utf-8")

    return memory_root


def next_adr_number(decisions_dir: Path) -> int:
    highest = 0
    for path in decisions_dir.glob("ADR-*.md"):
        match = re.match(r"ADR-(\d{4})-", path.name)
        if match:
            highest = max(highest, int(match.group(1)))
    return highest + 1


def unique_path(path: Path) -> Path:
    if not path.exists():
        return path

    counter = 2
    while True:
        candidate = path.with_name(f"{path.stem}-{counter}{path.suffix}")
        if not candidate.exists():
            return candidate
        counter += 1


def build_template(kind: str, title: str, created_on: str, file_stem: str) -> str:
    if kind == "plan":
        body = f"""# {title}

- Created: {created_on}
- Type: plan
- Status: draft

## Goal

## Scope

## Assumptions

## Steps

1. 
2. 
3. 

## Risks

## Validation

## Related Files

- Assets: [assets/{file_stem}/](../assets/{file_stem}/)
"""
    elif kind == "walkthrough":
        body = f"""# {title}

- Created: {created_on}
- Type: walkthrough
- Status: draft

## Purpose

## Preconditions

## Steps

1. 
2. 
3. 

## Expected Result

## Pitfalls

## Verification

## Related Files

- Assets: [assets/{file_stem}/](../assets/{file_stem}/)
"""
    elif kind == "decision":
        decision_id = file_stem.split("-", 2)[0] + "-" + file_stem.split("-", 2)[1]
        body = f"""# {title}

- Decision ID: {decision_id}
- Date: {created_on}
- Type: decision
- Status: proposed

## Context

## Options Considered

## Decision

## Consequences

## Related Files

- Assets: [assets/{file_stem}/](../assets/{file_stem}/)
"""
    elif kind == "research":
        body = f"""# {title}

- Created: {created_on}
- Type: research
- Status: draft

## Question

## Sources

- Add each source with an absolute date or access date.

## Findings

## Recommendation

## Open Questions

## Related Files

- Assets: [assets/{file_stem}/](../assets/{file_stem}/)
"""
    else:
        body = f"""# {title}

- Created: {created_on}
- Type: session
- Status: draft

## Context

## Completed

## Next Steps

## Blockers

## Commands and Files

## Handoff

## Related Files

- Assets: [assets/{file_stem}/](../assets/{file_stem}/)
"""

    return body.rstrip() + "\n"


def add_index_entry(index_path: Path, heading: str, line: str) -> None:
    text = index_path.read_text(encoding="utf-8")
    if line in text:
        return

    lines = text.splitlines()
    try:
        start = lines.index(f"## {heading}") + 1
    except ValueError:
        lines.extend(["", f"## {heading}", "", line])
        index_path.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")
        return

    end = len(lines)
    for idx in range(start, len(lines)):
        if idx > start and lines[idx].startswith("## "):
            end = idx
            break

    while end > start and lines[end - 1].strip() == "":
        end -= 1

    lines.insert(end, line)
    index_path.write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")


def cmd_init(args: argparse.Namespace) -> int:
    root = Path(args.root).resolve()
    memory_root = ensure_layout(root, args.memory_dir)
    print(f"Initialized project memory at: {memory_root}")
    return 0


def cmd_new(args: argparse.Namespace) -> int:
    root = Path(args.root).resolve()
    memory_root = ensure_layout(root, args.memory_dir)
    heading, folder = SECTIONS[args.kind]
    created_on = date.today().isoformat()
    slug = slugify(args.title)

    if args.kind == "decision":
        adr_number = next_adr_number(memory_root / folder)
        base_stem = f"ADR-{adr_number:04d}-{slug}"
        display_date = created_on
    else:
        base_stem = f"{created_on}-{slug}"
        display_date = created_on

    note_path = unique_path(memory_root / folder / f"{base_stem}.md")
    file_stem = note_path.stem
    asset_dir = memory_root / "assets" / file_stem
    asset_dir.mkdir(parents=True, exist_ok=True)

    content = build_template(args.kind, args.title, display_date, file_stem)
    note_path.write_text(content, encoding="utf-8")

    relative_note = note_path.relative_to(memory_root).as_posix()
    index_line = f"- {display_date} [{args.title}]({relative_note})"
    add_index_entry(memory_root / "INDEX.md", heading, index_line)

    print(f"Created note: {note_path}")
    print(f"Created asset dir: {asset_dir}")
    print(f"Updated index: {memory_root / 'INDEX.md'}")
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Initialize and maintain a structured project memory archive."
    )
    subparsers = parser.add_subparsers(dest="command", required=True)

    init_parser = subparsers.add_parser(
        "init", help="Create the project memory folder layout and index."
    )
    init_parser.add_argument("--root", default=".", help="Project root directory.")
    init_parser.add_argument(
        "--memory-dir",
        default="Plans.e.Walkthrough",
        help="Project memory folder name relative to the project root.",
    )
    init_parser.set_defaults(func=cmd_init)

    new_parser = subparsers.add_parser(
        "new", help="Create a new project memory entry and update the index."
    )
    new_parser.add_argument(
        "--kind",
        required=True,
        choices=sorted(SECTIONS.keys()),
        help="Entry type to create.",
    )
    new_parser.add_argument("--title", required=True, help="Human-readable entry title.")
    new_parser.add_argument("--root", default=".", help="Project root directory.")
    new_parser.add_argument(
        "--memory-dir",
        default="Plans.e.Walkthrough",
        help="Project memory folder name relative to the project root.",
    )
    new_parser.set_defaults(func=cmd_new)

    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    return args.func(args)


if __name__ == "__main__":
    raise SystemExit(main())
