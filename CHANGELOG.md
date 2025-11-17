# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.01] - 2025-11-17

### Changed

- Updated to video version 1.00.00
- Removed old video versions (v-0-02-00 and v-0-02-01)
- Updated German subtitle files (SRT and VTT formats)
- Cleaned up obsolete video project files and media assets

### Technical

- Uploaded 103 LFS objects (~78 MB) for new video version
- Removed 377 files from previous versions
- Updated video project structure to v-1-00-00

## [1.0.00] - 2025-11-17 [YANKED]

**Note: This release has been yanked/withdrawn.**

### Release

- **First stable release** of the German translation project
- All documentation updated and finalized
- Updated table of contents in README and documentation files
- Repository is production-ready

### Documentation

- Fixed broken paths in README.md
- Updated docs/text-material.md
- Updated src/subtitles/subtitles_de.md
- All documentation reviewed and finalized

## [0.2.00] - 2025-06-27

### Features Added

- New scene `c05-s03` providing detailed domain explanation
- Complete synthetic audio files for both German and English versions
- Enhanced subtitle files in multiple formats (MD, SRT, VTT)
- Updated video project files with latest configurations
- Comprehensive documentation updates including shotlist and text materials

### Changes Made

- Extended various scenes based on user feedback from previous version
- Updated character positioning in scene `c05-s04` for better visual flow
- Refined video timing and chapter synchronization
- Enhanced overall video quality and production standards

### Added
- Integrated **Git LFS (Large File Storage)** for handling large files.
- Automated management of video and audio files via Git LFS.
- Extended release pipeline to support Git LFS.
- **New ZIP packages available in releases:**
  - `tutorial-complete.zip` – Full project including all large files (recommended).
  - `tutorial-assets.zip` – Source assets and project files.
  - `tutorial-videos.zip` – All video files managed via LFS.
  - `tutorial-docs.zip` – Documentation only.
- **Important:** Use `tutorial-complete.zip` instead of "Source code" to ensure all required files are included.

### Changed
- Updated release workflow (`.github/workflows/release.yml`) to include LFS support.
- Configured `.gitattributes` for seamless Git LFS integration.
- Improved ZIP generation using `git archive` to include LFS-managed files.

### Features
- Added new scene `c05-s03` with a detailed domain explanation.
- Generated full synthetic audio tracks in both German and English.
- Enhanced subtitle availability: now provided in Markdown (MD), SRT, and VTT formats.
- Updated video project files with the latest configurations.
- Expanded and refined documentation, including a comprehensive shotlist and text materials.

### Improved
- Extended several scenes based on user feedback from the previous release.
- Adjusted character positions in scene `c05-s04` for improved visual composition.
- Fine-tuned video timing and chapter synchronization.
- Increased overall video production quality.

### Fixed
- Corrected various spelling mistakes throughout the project.
- Fixed subtitle timing and synchronization issues.
- Resolved audio-visual misalignments in several scenes.

### Technical Enhancements
- **Repository Maintenance:** Removed all system-generated files (e.g., `.DS_Store`, `@eaDir`).
- **Version Control:** Improved `.gitignore` to prevent future inclusion of system files.
- **Code Cleanliness:** Resolved sync conflicts and cleaned up the repository.
- **Documentation:** Updated all documentation to reflect the latest project state.

## [0.1.02] - 2025-03-18

### Improved

- Optimized WordPress character walking animation in scenes `c03-s01` and
  `c03-s03`

- Reduced file size of fireworks video background in scene `c06-s05`
- Enhanced image material integration across various formats
- Completed and revised shot list documentation

## [0.1.01] - 2025-03-14

### Issues Fixed

- General bug fixes and stability improvements

## [0.1.00] - 2025-03-13

### Changes Made

- Updated storyboard with improved visual flow

### Features Added

- Initial animated short film version
- Complete text materials in both languages
- Translated quiz content for German audience

## [0.0.01] - 2025-01-04

### Features Added

- Initial repository structure and project setup
- English text material creation
- First German translation draft
- English published version as baseline
- Storyboard development (English and German drafts)
- Initial shot list documentation
