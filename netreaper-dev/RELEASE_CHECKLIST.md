# NETREAPER Release Checklist

Run this EVERY time before pushing a new version.

---

## Pre-Release Checklist

### 1. Version Update
```bash
cd ~/NETREAPER

# Update version in all files
NEW_VERSION="5.3.3"  # Change this

# VERSION file
echo "$NEW_VERSION" > VERSION

# netreaper script
sed -i "s/VERSION=\"[^\"]*\"/VERSION=\"$NEW_VERSION\"/" netreaper

# netreaper-install (installer version follows: 2.x.x)
INSTALL_VERSION="2.3.3"  # Match minor/patch
sed -i "s/VERSION=\"[^\"]*\"/VERSION=\"$INSTALL_VERSION\"/" netreaper-install

# Verify
echo "VERSION file: $(cat VERSION)"
echo "netreaper: $(grep 'VERSION=' netreaper | head -1)"
echo "installer: $(grep 'VERSION=' netreaper-install | head -1)"
```

### 2. Update README
```bash
# Update version badge if using static badge
sed -i "s/version-[0-9]\+\.[0-9]\+\.[0-9]\+/version-$NEW_VERSION/" README.md

# Verify badge
grep -o "version-[0-9.]*" README.md | head -1
```

### 3. Update CHANGELOG
Add entry at TOP of CHANGELOG.md:
```markdown
## [5.3.3] - 2025-12-XX

### Added
- 

### Fixed
- 

### Changed
- 
```

### 4. Generate Checksums
```bash
# Create checksums file
sha256sum netreaper netreaper-install > checksums.sha256

# View
cat checksums.sha256

# Optional: Add to release notes
```

### 5. Syntax Check
```bash
bash -n netreaper && echo "✓ netreaper OK"
bash -n netreaper-install && echo "✓ installer OK"
```

### 6. Commit
```bash
git add .
git status

# Use consistent commit format
git commit -m "v$NEW_VERSION: Brief description

- Change 1
- Change 2
- Change 3"
```

### 7. Tag Release
```bash
git tag "v$NEW_VERSION"
```

### 8. Push
```bash
git push origin main
git push origin "v$NEW_VERSION"
```

### 9. Create GitHub Release
1. Go to: https://github.com/Nerds489/NETREAPER/releases/new
2. Select tag: `v5.3.3`
3. Title: `v5.3.3 - Brief Title`
4. Description:
```markdown
## What's New

- Feature 1
- Feature 2

## Fixes

- Fix 1
- Fix 2

## Checksums

```
sha256: abc123... netreaper
sha256: def456... netreaper-install
```

## Install

```bash
git clone https://github.com/Nerds489/NETREAPER.git
cd NETREAPER
sudo bash ./netreaper-install
```
```
5. Click "Publish release"

---

## Quick Version (Copy/Paste)

```bash
cd ~/NETREAPER
NEW_VERSION="5.3.3"

# Update versions
echo "$NEW_VERSION" > VERSION
sed -i "s/VERSION=\"[^\"]*\"/VERSION=\"$NEW_VERSION\"/" netreaper

# Checksums
sha256sum netreaper netreaper-install > checksums.sha256

# Verify
bash -n netreaper && bash -n netreaper-install && echo "✓ Syntax OK"

# Commit & push
git add .
git commit -m "v$NEW_VERSION: Description"
git tag "v$NEW_VERSION"
git push origin main
git push origin "v$NEW_VERSION"

# Then create release on GitHub
echo "Create release: https://github.com/Nerds489/NETREAPER/releases/new"
```

---

## Files to Always Check

| File | What to Update |
|------|----------------|
| `VERSION` | Version number |
| `netreaper` | VERSION variable |
| `netreaper-install` | VERSION variable |
| `README.md` | Version badge (if static) |
| `CHANGELOG.md` | New version entry at top |
| `checksums.sha256` | Regenerate |

---

## Version Numbering

```
MAJOR.MINOR.PATCH

5.3.2 → 5.3.3  (patch: bug fixes)
5.3.3 → 5.4.0  (minor: new features)
5.4.0 → 6.0.0  (major: breaking changes)
```

Installer follows: `2.MINOR.PATCH` (matches netreaper minor/patch)
