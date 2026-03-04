# Publishing Guide

This guide explains how to publish the repository to GitHub and create releases.

## Initial Setup (One-time)

The repository has been initialized and is ready to push:

```bash
# Repository is already initialized with:
# - Git repository created
# - Remote 'origin' configured: git@github.com:JoshuaSeidel/hass-roborock.git
# - Initial commit created
# - Tag v1.0.0 created
```

## Push to GitHub

### 1. Push the Repository

```bash
# Push the main branch
git push -u origin main

# Push the tags
git push origin --tags
```

### 2. Create GitHub Release

After pushing, create a release on GitHub:

1. Go to https://github.com/JoshuaSeidel/hass-roborock/releases
2. Click "Create a new release"
3. Select tag: `v1.0.0`
4. Release title: `v1.0.0 - Initial Release with B01 Q10 Support`
5. Copy the description from `RELEASE_NOTES.md`
6. Click "Publish release"

The GitHub Actions workflow will automatically:
- Validate the integration
- Create a ZIP file
- Upload it as a release asset

### 3. Set Up Repository Settings

1. **Repository Description:**
   ```
   Extended Roborock integration for Home Assistant with B01 Q10 protocol support
   ```

2. **Topics/Tags:**
   - `home-assistant`
   - `hacs`
   - `roborock`
   - `vacuum`
   - `custom-integration`
   - `smart-home`

3. **Enable Discussions** (optional but recommended)

4. **Set Default Branch:** Already set to `main`

## Future Releases

### Creating a New Release

1. **Update version in manifest.json:**
   ```bash
   # Edit custom_components/roborock/manifest.json
   # Change "version": "1.0.0" to "version": "1.1.0" (or appropriate version)
   ```

2. **Commit changes:**
   ```bash
   git add custom_components/roborock/manifest.json
   git commit -m "Bump version to 1.1.0"
   ```

3. **Add other changes:**
   ```bash
   git add <files>
   git commit -m "Description of changes"
   ```

4. **Create and push tag:**
   ```bash
   git tag -a v1.1.0 -m "Release v1.1.0: Description"
   git push origin main
   git push origin v1.1.0
   ```

5. **Create GitHub Release:**
   - Go to GitHub releases page
   - Click "Draft a new release"
   - Select the new tag
   - Add release notes
   - Publish

### Version Numbering

Follow semantic versioning (MAJOR.MINOR.PATCH):

- **MAJOR**: Breaking changes (e.g., 2.0.0)
- **MINOR**: New features, backwards compatible (e.g., 1.1.0)
- **PATCH**: Bug fixes, backwards compatible (e.g., 1.0.1)

## Adding to HACS

### For Users

Users can add this as a custom repository:

1. Open HACS
2. Click the 3 dots in the top right
3. Select "Custom repositories"
4. Add: `https://github.com/JoshuaSeidel/hass-roborock`
5. Category: Integration
6. Click "Add"

### For HACS Default Repository (Optional)

To get this into the HACS default repository:

1. Ensure all HACS requirements are met
2. Submit a PR to: https://github.com/hacs/default
3. Add entry to `integration` list

## Validation

Before each release, validate:

```bash
# Python syntax check
python3 -m py_compile custom_components/roborock/*.py

# Check manifest version matches tag
VERSION=$(jq -r '.version' custom_components/roborock/manifest.json)
echo "Manifest version: $VERSION"
git tag -l | grep "v$VERSION"
```

## GitHub Actions

Two workflows are configured:

1. **validate.yml** - Runs on every push/PR
   - HACS validation
   - Hassfest validation

2. **release.yml** - Runs on release publish
   - Validates version matching
   - Creates ZIP file
   - Uploads release asset

## Repository Structure

```
hass-roborock/
├── .github/
│   └── workflows/
│       ├── validate.yml        # Validation workflow
│       └── release.yml         # Release workflow
├── custom_components/
│   └── roborock/               # Integration files
├── hacs.json                   # HACS configuration
├── info.md                     # HACS store info
├── README.md                   # Main documentation
├── CHANGES.md                  # Technical changes
├── RELEASE_NOTES.md            # User-facing release notes
├── LICENSE                     # Apache 2.0
└── .gitignore                  # Git ignore rules
```

## Support After Release

- Monitor GitHub issues
- Respond to discussions
- Review pull requests
- Update dependencies as needed
- Test with new Home Assistant releases

## Checklist for First Push

- [ ] Verify SSH keys are set up for GitHub
- [ ] Push main branch: `git push -u origin main`
- [ ] Push tags: `git push origin --tags`
- [ ] Create GitHub release from v1.0.0 tag
- [ ] Add repository description and topics
- [ ] Enable issues and discussions
- [ ] Share repository URL with users
