#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Script: create-patch.sh
# Purpose:
#   Compare the current Git branch against the default branch (usually main),
#   create a patch of changes not in main, and optionally create a new branch
#   from the latest main with that patch applied.
#
# Steps:
#   1. Detect default branch (usually 'main')
#   2. Detect current branch
#   3. Fetch latest default branch from origin
#   4. Generate patch (current branch vs. latest main)
#   5. Prompt to create a new branch
#   6. If confirmed:
#        - Create new branch from latest main
#        - Apply patch
#        - Delete patch file after success
# ------------------------------------------------------------------------------

set -e  # Exit on error

# ------------------------------------------------------------------------------
# Step 1: Detect the default branch (from origin)
# ------------------------------------------------------------------------------
get_default_branch() {
  git remote show origin | awk '/HEAD branch/ {print $NF}'
}

# ------------------------------------------------------------------------------
# Step 2: Detect the current branch
# ------------------------------------------------------------------------------
get_current_branch() {
  git rev-parse --abbrev-ref HEAD
}

# ------------------------------------------------------------------------------
# Step 3: Fetch latest version of the default branch from remote
# ------------------------------------------------------------------------------
fetch_latest_main() {
  local main_branch="$1"
  echo "📥 Fetching latest changes from origin/$main_branch..."
  git fetch origin "$main_branch"
}

# ------------------------------------------------------------------------------
# Step 4: Create patch comparing current branch vs latest main
# ------------------------------------------------------------------------------
create_patch() {
  local main_branch="$1"
  local current_branch="$2"

  local safe_branch_name
  safe_branch_name=$(echo "$current_branch" | sed 's/\//-/g')
  local patch_file="changes_${safe_branch_name}_vs_${main_branch}_$(date +%Y%m%d_%H%M%S).patch"

  echo "🧩 Creating patch file: $patch_file"
  git diff "origin/$main_branch"...HEAD > "$patch_file"

  if [ ! -s "$patch_file" ]; then
    echo "✅ No differences found between $current_branch and $main_branch."
    rm "$patch_file"
    exit 0
  fi

  echo "✅ Patch created successfully: $patch_file"
  echo "$patch_file"
}

# ------------------------------------------------------------------------------
# Step 5: Ask user if they want to create a new branch
# ------------------------------------------------------------------------------
ask_create_branch() {
  read -p "Do you want to create a new branch with an updated name and apply the patch? (y/n): " response
  [[ "$response" =~ ^[Yy]$ ]]
}

# ------------------------------------------------------------------------------
# Step 6: Create new branch from latest main and apply patch
# ------------------------------------------------------------------------------
apply_patch_to_new_branch() {
  local main_branch="$1"
  local current_branch="$2"
  local patch_file="$3"

  local unique_id
  unique_id=$(date +%s)
  local new_branch="${current_branch}_updated_${unique_id}"

  echo "🌿 Creating new branch from ${main_branch}: $new_branch"
  git checkout -b "$new_branch" "origin/$main_branch"

  echo "📦 Applying patch..."
  if git apply "$patch_file"; then
    echo "✅ Patch applied successfully to $new_branch."
    echo "🧹 Deleting patch file..."
    rm "$patch_file"
    echo "✨ Cleanup done. You are now on branch: $new_branch"
  else
    echo "❌ Failed to apply patch. Reverting branch creation."
    git checkout "$current_branch"
    git branch -D "$new_branch"
    exit 1
  fi
}

# ------------------------------------------------------------------------------
# Main Execution Flow
# ------------------------------------------------------------------------------
main() {
  local default_branch current_branch patch_file

  echo "🔍 Detecting branches..."
  default_branch=$(get_default_branch)
  current_branch=$(get_current_branch)

  echo "Current branch: $current_branch"
  echo "Default branch (from origin): $default_branch"

  if [ "$current_branch" = "$default_branch" ]; then
    echo "⚠️ You are on the default branch ($default_branch). Nothing to compare."
    exit 1
  fi

  fetch_latest_main "$default_branch"

  patch_file=$(create_patch "$default_branch" "$current_branch")

  if ask_create_branch; then
    apply_patch_to_new_branch "$default_branch" "$current_branch" "$patch_file"
  else
    echo "🚫 No new branch created. Patch file remains: $patch_file"
  fi
}

# Run the script
main
