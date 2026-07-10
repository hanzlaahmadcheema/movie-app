#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# ==========================================
# Terminal Colors
# ==========================================
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

info() { echo -e "${BLUE}[INFO] $1${NC}"; }
success() { echo -e "${GREEN}[SUCCESS] $1${NC}"; }
warning() { echo -e "${YELLOW}[WARNING] $1${NC}"; }
error() { echo -e "${RED}[ERROR] $1${NC}"; }
fatal() { echo -e "${RED}[FATAL] $1${NC}"; exit 1; }

# ==========================================
# 1. Validate arguments
# ==========================================
if [ "$#" -ne 2 ]; then
  error "Usage: ./scripts/release.sh <version> <title>"
  error "Example: ./scripts/release.sh v1.8.0 \"Android TV Phase 1\""
  exit 1
fi

VERSION=$1
TITLE=$2

if [[ ! "$VERSION" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  fatal "Invalid version format: $VERSION. Accepted format: v1.0.0"
fi

START_TIME=$(date +%s)
info "Starting release process for $VERSION - $TITLE"

# ==========================================
# 2. Verify Git repository
# ==========================================
if [ -n "$(git status --porcelain)" ]; then
  fatal "Working tree is not clean.\nCommit or stash changes first."
fi

# ==========================================
# 3. Verify required tools exist
# ==========================================
for tool in git flutter dart; do
  if ! command -v $tool &> /dev/null; then
    fatal "$tool is required but not installed."
  fi
done

GH_AVAILABLE=false
if command -v gh &> /dev/null; then
  GH_AVAILABLE=true
  info "GitHub CLI (gh) found. GitHub Release will be created."
else
  warning "GitHub CLI (gh) not found. Skipping GitHub Release creation."
fi

# ==========================================
# 4. Run quality checks
# ==========================================
info "Running quality checks (flutter pub get, analyze, test)..."
flutter pub get || fatal "flutter pub get failed"
flutter analyze || fatal "flutter analyze failed"
flutter test || fatal "flutter test failed"

info "Building APK (--release)..."
flutter build apk --release || fatal "flutter build apk failed"

info "Building AppBundle..."
flutter build appbundle || fatal "flutter build appbundle failed"
success "Quality checks and builds passed."

# ==========================================
# 5. Collect release artifacts
# ==========================================
APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
AAB_PATH="build/app/outputs/bundle/release/app-release.aab"

if [ ! -f "$APK_PATH" ]; then fatal "APK not found at $APK_PATH"; fi
if [ ! -f "$AAB_PATH" ]; then fatal "AAB not found at $AAB_PATH"; fi

# ==========================================
# 6. Generate release notes
# ==========================================
info "Generating release notes..."
PREV_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "")

echo "# $VERSION" > RELEASE_NOTES.md
echo "Date: $(date +'%Y-%m-%d')" >> RELEASE_NOTES.md
echo "Title: $TITLE" >> RELEASE_NOTES.md
echo "" >> RELEASE_NOTES.md
echo "## Commits" >> RELEASE_NOTES.md

if [ -n "$PREV_TAG" ]; then
  git log ${PREV_TAG}..HEAD --oneline >> RELEASE_NOTES.md
else
  git log --oneline >> RELEASE_NOTES.md
fi
success "Generated RELEASE_NOTES.md"

# ==========================================
# 7. Commit
# ==========================================
info "Committing release changes..."
git add .
if [ -n "$(git status --porcelain)" ]; then
  git commit -m "release: $VERSION - $TITLE"
  success "Changes committed."
else
  info "No changes to commit. Skipping commit gracefully."
fi

# ==========================================
# 8. Create annotated tag
# ==========================================
info "Creating annotated tag..."
if git rev-parse "$VERSION" >/dev/null 2>&1; then
  fatal "Tag $VERSION already exists."
fi

git tag -a "$VERSION" -m "Version $VERSION

$TITLE"
success "Tag $VERSION created."

# ==========================================
# 9. Push
# ==========================================
info "Pushing to remote repository..."
BRANCH=$(git rev-parse --abbrev-ref HEAD)
git push origin "$BRANCH" || fatal "Failed to push branch $BRANCH"
git push origin "$VERSION" || fatal "Failed to push tag $VERSION"
success "Pushed to origin."

# ==========================================
# 10. GitHub Release
# ==========================================
GH_RELEASE_STATUS="Skipped"
if [ "$GH_AVAILABLE" = true ]; then
  info "Creating GitHub Release..."
  if gh release create "$VERSION" "$APK_PATH" "$AAB_PATH" --title "$VERSION" --notes-file RELEASE_NOTES.md; then
    success "GitHub Release created successfully."
    GH_RELEASE_STATUS="Created"
  else
    warning "Failed to create GitHub Release."
    GH_RELEASE_STATUS="Failed"
  fi
fi

# ==========================================
# 11. Archive artifacts
# ==========================================
info "Archiving artifacts locally..."
mkdir -p "releases/$VERSION"
cp "$APK_PATH" "releases/$VERSION/"
cp "$AAB_PATH" "releases/$VERSION/"
cp RELEASE_NOTES.md "releases/$VERSION/"
success "Artifacts archived in releases/$VERSION/"

# ==========================================
# 12 & 13. Final summary
# ==========================================
END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))
MINS=$((ELAPSED / 60))
SECS=$((ELAPSED % 60))

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Release Complete${NC}"
echo ""
echo -e "Version:        $VERSION"
echo -e "APK:            releases/$VERSION/app-release.apk"
echo -e "AAB:            releases/$VERSION/app-release.aab"
echo -e "Tag:            $VERSION"
echo -e "GitHub Release: $GH_RELEASE_STATUS"
echo -e "Elapsed Time:   ${MINS}m ${SECS}s"
echo -e "${GREEN}========================================${NC}"
