# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Git LFS (Large File Storage) integration for large files
- Automatic management of video and audio files with Git LFS
- Extended release pipeline with LFS support
- New ZIP files in releases: tutorial-complete.zip with all LFS files
- Documentation for Git LFS setup (GIT_LFS_SETUP.md)

### Changed

- Release script (.github/workflows/release.yml) extended with LFS support
- .gitattributes configured for automatic LFS management
- Improved ZIP creation with git archive for LFS files

### Technical Details

- Large files are automatically managed with Git LFS:
  - media/video/video-v-0-02-00.mp4 (39MB)
  - src/assets/video/video-v-0-02-00.cmproj/ (225MB)
  - All MP4 files in src/assets/animation/
  - All WAV and M4A audio files
  - Project files (.cmproj, .moho)
  - Design files (.psd, .ai, .afdesign)

## [0.2.00] - 2025-06-26

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

### Issues Fixed

- Corrected various spelling errors throughout the content
- Resolved timing issues in subtitle synchronization
- Fixed audio-visual alignment in multiple scenes

### Technical

- **Repository Maintenance**: Removed all system-generated files
  (.DS_Store, @eaDir directories)

- **Version Control**: Enhanced .gitignore configuration to prevent future
  system file inclusion

- **Code Quality**: Resolved sync-conflict files and improved repository
  cleanliness

- **Documentation**: Updated project documentation to reflect current state

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


