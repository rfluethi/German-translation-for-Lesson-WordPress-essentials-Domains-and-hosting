# Repository Structure

This document provides an overview of the repository's structure, including the purpose of each directory and file.

```plaintext
/repository-root
│
├── /docs/                  # Documentation and textual resources for the learning materials
│   ├── /images/            # Images used within the documentation
│   ├── quiz.md             # Quiz questions for the project, adapted from the original lesson
│   ├── shotlist.md         # Details on scenes, including references to files used in production
│   ├── storyboard-de.md    # Visual overview of the German video sequences
│   ├── storyboard-en.md    # Visual overview of the original English video sequences
│   ├── text-material-de.md # German adaptation of the learning material text
│   └── text-material-en.md # Original English text for the learning material
│
├── /src/                   # Working files used in creating the learning materials
│   ├── /assets/            # Icons, graphics, and reusable assets for production
│   ├── /audio/             # Audio files used in the videos
│   ├── /subtitles/         # Subtitle files for the videos
│       ├── /english/       # English subtitles (adapted from the German version)
│       └── /german/        # German subtitles matching the spoken video content
│
├── /media/                 # Media resources for the learning materials
│   └── /video/             # Finalized video files for the learning materials
│
├── .gitignore              # Specifies files and directories to exclude from version control
├── CHANGELOG.md            # Tracks updates and changes in the repository
├── CONTRIBUTING.md         # Guidelines for contributors
├── REPOSITORY_STRUCTURE.md # This file, detailing the repository's structure
└── README.md               # Main description of the GitHub repository
```

## Production Documents

This repository includes essential production documents for creating and localizing the learning materials. For details about specific content such as **Text Materials** and **Quiz**, refer to the [README](https://chatgpt.com/c/README.md) file.

### Storyboard

The **Storyboard** provides a visual representation of the video sequences and is a key guide for production:

- **[storyboard-en](https://chatgpt.com/c/docs/storyboard-en.md):** Original English storyboard.
- **[storyboard-de](https://chatgpt.com/c/docs/storyboard-de.md):** Adapted German storyboard.

### Shot List

The **Shot List** ([shotlist](https://chatgpt.com/c/docs/shotlist.md)) includes:

- A detailed list of scenes and corresponding resources.
- References to media files and their licenses.
- Notes on timing, transitions, and production requirements.