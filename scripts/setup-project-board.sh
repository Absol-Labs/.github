#!/usr/bin/env bash
# Create the cross-repo "StreamProof Roadmap" project and add every open issue
# across the five repos.
#
# One-time setup (the project scope is interactive, so run it yourself):
#   gh auth refresh -s project,read:project
#   bash scripts/setup-project-board.sh
#
# Re-running creates a NEW project — run once.
set -euo pipefail

OWNER="Absol-Labs"
TITLE="StreamProof Roadmap"
REPOS=(streamproof-protocol streamproof-contracts streamproof-oracle streamproof-sdk streamproof-agent)

echo "Creating project '$TITLE' under $OWNER ..."
NUM="$(gh project create --owner "$OWNER" --title "$TITLE" --format json | jq -r '.number')"
echo "Created project #$NUM"

for repo in "${REPOS[@]}"; do
  echo "Adding open issues from $repo ..."
  gh issue list --repo "$OWNER/$repo" --state open --limit 200 --json url --jq '.[].url' \
    | while read -r url; do
        gh project item-add "$NUM" --owner "$OWNER" --url "$url" >/dev/null && echo "  + $url"
      done
done

echo "Done. View: https://github.com/orgs/$OWNER/projects/$NUM"
echo "Tip: add a 'Status' (Todo/In-progress/Done) and a 'Phase' (P0-P3) field in the UI,"
echo "     and group by repo or phase for a cross-repo burndown."
