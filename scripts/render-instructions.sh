#!/usr/bin/env bash
set -euo pipefail

source_dir=${1:?usage: render-instructions SOURCE OUTPUT}
output_dir=${2:?usage: render-instructions SOURCE OUTPUT}

mkdir -p "$output_dir"
cp -R "$source_dir"/. "$output_dir"/
chmod -R u+w "$output_dir"
rm -f "$output_dir/index.md"

# Removes the catalog (OKF) frontmatter keys and keeps every other line byte-for-byte. A file whose
# frontmatter starts with `type:` had none of its own, so the whole block goes. Native keys, including a
# `description` that also serves OKF, stay as written.
while IFS= read -r -d '' markdown_file; do
  awk '
    BEGIN {
      n = split("type title resource tags timestamp status consumers render source_history", keys, " ")
      for (i = 1; i <= n; i++) okf[keys[i]] = 1
      state = "start"
    }
    state == "start" {
      if ($0 != "---") { state = "body"; print; next }
      state = "frontmatter"; count = 0; next
    }
    state == "frontmatter" {
      if ($0 == "---") {
        state = "body"
        if (fm[1] !~ /^type:/) {
          print "---"
          drop = 0
          for (i = 1; i <= count; i++) {
            if (fm[i] ~ /^[A-Za-z_][A-Za-z0-9_-]*:/) {
              key = fm[i]; sub(/:.*/, "", key); drop = (key in okf)
            }
            if (!drop) print fm[i]
          }
          print "---"
        }
        next
      }
      fm[++count] = $0; next
    }
    { print }
  ' "$markdown_file" >"$markdown_file.tmp"
  mv "$markdown_file.tmp" "$markdown_file"
done < <(find "$output_dir" -type f -name '*.md' -print0)
