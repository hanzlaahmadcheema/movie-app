param (
    [Parameter(Position=0, Mandatory=$false)]
    [string]$Version,
    
    [Parameter(Position=1, Mandatory=$false)]
    [string]$Title
)

# Exit immediately if a command exits with a non-zero status
$ErrorActionPreference = 'Stop'

function Write-Info($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-Success($msg) { Write-Host "[SUCCESS] $msg" -ForegroundColor Green }
function Write-Warning($msg) { Write-Host "[WARNING] $msg" -ForegroundColor Yellow }
function Write-ErrorMsg($msg) { Write-Host "[ERROR] $msg" -ForegroundColor Red }
function Fatal($msg) { Write-Host "[FATAL] $msg" -ForegroundColor Red; exit 1 }

# ==========================================
# 1. Validate arguments
# ==========================================
if ([string]::IsNullOrWhiteSpace($Version) -or [string]::IsNullOrWhiteSpace($Title)) {
    Write-ErrorMsg "Usage: .\scripts\release.ps1 <version> <title>"
    Write-ErrorMsg 'Example: .\scripts\release.ps1 v1.8.0 "Android TV Phase 1"'
    exit 1
}

if ($Version -notmatch '^v\d+\.\d+\.\d+$') {
    Fatal "Invalid version format: $Version. Accepted format: v1.0.0"
}

$StartTime = Get-Date
Write-Info "Starting release process for $Version - $Title"

# ==========================================
# 2. Verify Git repository
# ==========================================
$gitStatus = git status --porcelain
if (![string]::IsNullOrWhiteSpace($gitStatus)) {
    Fatal "Working tree is not clean.`nCommit or stash changes first."
}

# ==========================================
# 3. Verify required tools
# ==========================================
foreach ($tool in @("git", "flutter", "dart")) {
    if ((Get-Command $tool -ErrorAction SilentlyContinue) -eq $null) {
        Fatal "$tool is required but not installed."
    }
}

$GH_AVAILABLE = $false
if ((Get-Command gh -ErrorAction SilentlyContinue) -ne $null) {
    $GH_AVAILABLE = $true
    Write-Info "GitHub CLI (gh) found. GitHub Release will be created."
} else {
    Write-Warning "GitHub CLI (gh) not found. Skipping GitHub Release creation."
}

# ==========================================
# 4. Run quality checks
# ==========================================
Write-Info "Running quality checks..."
try {
    Write-Info "Running flutter pub get..."
    flutter pub get; if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed" }
    
    Write-Info "Running flutter analyze..."
    flutter analyze; if ($LASTEXITCODE -ne 0) { throw "flutter analyze failed" }
    
    Write-Info "Running flutter test..."
    flutter test; if ($LASTEXITCODE -ne 0) { throw "flutter test failed" }
    
    Write-Info "Building APK..."
    flutter build apk --release; if ($LASTEXITCODE -ne 0) { throw "flutter build apk failed" }
    
    Write-Info "Building AppBundle..."
    flutter build appbundle; if ($LASTEXITCODE -ne 0) { throw "flutter build appbundle failed" }
    
    Write-Success "Quality checks and builds passed."
} catch {
    Fatal $_
}

# ==========================================
# 5. Collect release artifacts
# ==========================================
$APK_PATH = "build/app/outputs/flutter-apk/app-release.apk"
$AAB_PATH = "build/app/outputs/bundle/release/app-release.aab"

if (-not (Test-Path $APK_PATH)) { Fatal "APK not found at $APK_PATH" }
if (-not (Test-Path $AAB_PATH)) { Fatal "AAB not found at $AAB_PATH" }

# ==========================================
# 6. Generate release notes
# ==========================================
Write-Info "Generating release notes..."
$prevTag = git describe --tags --abbrev=0 2>$null
$releaseNotes = "RELEASE_NOTES.md"

"# $Version`nDate: $(Get-Date -Format 'yyyy-MM-dd')`nTitle: $Title`n`n## Commits`n" | Out-File -FilePath $releaseNotes -Encoding utf8

if (![string]::IsNullOrWhiteSpace($prevTag)) {
    git log "$prevTag..HEAD" --oneline | Out-File -FilePath $releaseNotes -Encoding utf8 -Append
} else {
    git log --oneline | Out-File -FilePath $releaseNotes -Encoding utf8 -Append
}
Write-Success "Generated RELEASE_NOTES.md"

# ==========================================
# 7. Commit
# ==========================================
Write-Info "Committing release notes..."
git add .
$gitStatus = git status --porcelain
if (![string]::IsNullOrWhiteSpace($gitStatus)) {
    git commit -m "release: $Version - $Title"
    Write-Success "Changes committed."
} else {
    Write-Info "No changes to commit. Skipping commit gracefully."
}

# ==========================================
# 8. Create annotated tag
# ==========================================
Write-Info "Creating annotated tag..."
$tagExists = git rev-parse $Version 2>$null
if (![string]::IsNullOrWhiteSpace($tagExists)) {
    Fatal "Tag $Version already exists."
}

git tag -a $Version -m "Version $Version`n`n$Title"
Write-Success "Tag $Version created."

# ==========================================
# 9. Push
# ==========================================
Write-Info "Pushing to remote..."
$branch = git rev-parse --abbrev-ref HEAD
git push origin $branch
if ($LASTEXITCODE -ne 0) { Fatal "Failed to push branch" }

git push origin $Version
if ($LASTEXITCODE -ne 0) { Fatal "Failed to push tag" }
Write-Success "Pushed to origin."

# ==========================================
# 10. GitHub Release
# ==========================================
$GH_RELEASE_STATUS = "Skipped"
if ($GH_AVAILABLE) {
    Write-Info "Creating GitHub Release..."
    gh release create $Version $APK_PATH $AAB_PATH --title $Version --notes-file $releaseNotes
    if ($LASTEXITCODE -eq 0) {
        Write-Success "GitHub Release created."
        $GH_RELEASE_STATUS = "Created"
    } else {
        Write-Warning "Failed to create GitHub Release."
        $GH_RELEASE_STATUS = "Failed"
    }
}

# ==========================================
# 11. Archive artifacts
# ==========================================
Write-Info "Archiving artifacts..."
$releaseDir = "releases/$Version"
New-Item -ItemType Directory -Force -Path $releaseDir | Out-Null
Copy-Item $APK_PATH -Destination $releaseDir
Copy-Item $AAB_PATH -Destination $releaseDir
Copy-Item $releaseNotes -Destination $releaseDir
Write-Success "Artifacts archived in $releaseDir"

# ==========================================
# 12 & 13. Final summary
# ==========================================
$EndTime = Get-Date
$Elapsed = $EndTime - $StartTime

Write-Host "========================================" -ForegroundColor Green
Write-Host "Release Complete" -ForegroundColor Green
Write-Host ""
Write-Host "Version:        $Version"
Write-Host "APK:            releases/$Version/app-release.apk"
Write-Host "AAB:            releases/$Version/app-release.aab"
Write-Host "Tag:            $Version"
Write-Host "GitHub Release: $GH_RELEASE_STATUS"
Write-Host "Elapsed Time:   $($Elapsed.Minutes)m $($Elapsed.Seconds)s"
Write-Host "========================================" -ForegroundColor Green
