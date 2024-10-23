# German Translation of 'WordPress essentials: Domains and hosting' Lesson.

Welcome to the repository for the German translation and redesign of the "WordPress essentials: Domains and hosting" lesson. This project is dedicated to enhancing accessibility to WordPress learning resources for German-speaking audiences by providing translated and culturally adapted content. As part of the [Open Educational Resources (OER)](https://en.wikipedia.org/wiki/Open_educational_resources) initiative, this repository ensures that educational materials are freely available and adaptable, promoting lifelong learning and knowledge sharing. 

By leveraging the power of [WordPress](https://wordpress.org/) as an open-source community, this project not only facilitates the dissemination of knowledge but also empowers individuals to contribute and improve the content collaboratively. The open-source nature of this repository guarantees that changes and updates can be independently verified and implemented by anyone, ensuring the content remains relevant and up-to-date. This collaborative approach embodies the spirit of open-source and OER, fostering a community-driven effort to make education more inclusive and universally accessible.

## Table of Contents

- [German Translation of 'WordPress essentials: Domains and hosting' Lesson.](#german-translation-of-wordpress-essentials-domains-and-hosting-lesson)
  - [Table of Contents](#table-of-contents)
  - [Original Resources](#original-resources)
    - [English](#english)
    - [German](#german)
  - [Documents](#documents)
    - [Storyboard](#storyboard)
    - [Text Materials](#text-materials)
  - [Subtitles](#subtitles)
    - [Quiz](#quiz)
    - [Shot List](#shot-list)
  - [Repository Structure](#repository-structure)
  - [Contributing](#contributing)
    - [How to Contribute](#how-to-contribute)
  - [Downloadable Release Files](#downloadable-release-files)
  - [License](#license)
  - [Contact](#contact)

## Original Resources

This section lists the original English resources and their German counterparts. These resources serve as the foundation for our translation and adaptation efforts.

### English
- Learning Path / Lesson: [WordPress essentials: Domains and hosting | Learn WordPress](https://learn.wordpress.org/lesson/wordpress-essentials-domains-and-hosting/)
- YouTube Video: [WordPress essentials: Domains and hosting - YouTube](https://www.youtube.com/watch?v=stbR6Tf7tCg)
- WordPress.tv Video: [WordPress essentials: Domains and hosting - YouTube](https://www.youtube.com/watch?v=stbR6Tf7tCg)
- Original GitHub Issue for the English Video: [Tutorial - Choosing a domain name and hosting service · Issue #1963 · WordPress/Learn](https://github.com/WordPress/Learn/issues/1963)

### German
- Lesson Title: WordPress-Grundlagen: Domains und Hosting
- GitHub Issue for the German Translation: [German translation for Lesson "WordPress essentials: Domains and hosting" · Issue #2955 · WordPress/Learn](https://github.com/WordPress/Learn/issues/2955)

## Documents

Documents for the German translation of the learning materials.

### Storyboard

The [Storyboard](docs/storyboard.md) provides a visual representation of the educational video. It includes a detailed sequence of scenes and outlines the entire flow of the video. It serves as a fundamental guide and starting point for the entire production.

### Text Materials

The [Text Materials](docs/text-materials.md) file contains the complete transcript of the educational video, including all spoken passages. Additionally, it includes other related texts that are part of this project. The quiz texts are stored in a separate file, [quiz.md](docs/quiz.md).

## Subtitles

The directory [Subtitles](src/subtitles) contains the subtitle files for the instructional video. The English original subtitles can be found in the folder [src/subtitles/english](src/subtitles/english). The German subtitles are located in the folder [src/subtitles/german](src/subtitles/german).

### Quiz

The [Quiz](docs/quiz.md) contains a series of questions related to the content of the educational video. It is designed to test the viewer's understanding of the material and reinforce key concepts. The questions were taken from the English version and translated into German.

### Shot List

The [Shot List](docs/shotlist.md) is a detailed listing of all scenes and shots in the educational video. It includes references to the media resources used, notes on the corresponding licenses, as well as all timing and editing marks.

## Repository Structure

```plaintext
/repository-root
│
├── /docs/                # Documentation of the learning materials
│   ├── /images/          # Directory for images used in the documentation
│   ├── quiz.md           # The quiz questions associated with this project
│   ├── shotlist.md       # Detailed documentation of the scenes and files used in the production
│   ├── storyboard.md     # A visual outline of the scenes and sequences in the video
│   └── text-materials.md # Texts and dialogs of the learning materials
│
├── /src/                 # Directory for working files used in creating the learning materials
│   ├── /assets/          # Directory for images, icons, etc.
│   ├── /audio/           # Directory for audio files used in the video
│   ├── /subtitles/       # Directory for subtitle files for the educational video
│   └── /voices/          # Directory for voice recordings for the instructional video
│
├── /media/               # Media resources for the learning materials
│   └── /video/           # Directory for video files
│
├── .gitignore            # Files or directories to be excluded from version control
└── README.md             # This file
```

Directories are only visible in the repository if they contain files.

## Contributing

We welcome all forms of contribution! Whether you're interested in improving the translation, adapting the lesson for another language, or enhancing the video production, your input is valuable.

For suggestions and feedback on the German version, please comment on **[Issue #2955](https://github.com/WordPress/Learn/issues/2955)**.

If you would like to translate this content into your own language, you can clone this repository and create a new branch named after your language. Please see the site [Translating Content – Make WordPress Training](https://make.wordpress.org/training/handbook/training-team-how-to-guides/content-localization/translating-content/) for more information.

### How to Contribute

1. **Fork the Repository:**
   - Click the "Fork" button at the top right of the repository page to create your own copy of the repository.

2. **Clone Your Forked Repository:**
   - Replace `yourusername` with your GitHub username in the command below:
   ```bash
   git clone https://github.com/rfluethi/German-translation-for-Lesson-WordPress-essentials-Domains-and-hosting.git
   ```
   - Navigate into the cloned directory:
   ```bash
   cd German-translation-for-Lesson-Introduction-to-WordPress
   ```

3. **Create a Branch:**
   - Create a new branch for your feature or fix. Replace `your-feature-name` with a descriptive name for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make Changes:**
   - Implement your improvements or translations. Ensure that your changes align with any existing coding standards or guidelines.

5. **Commit Changes:**
   - Commit your changes with a descriptive message:
   ```bash
   git commit -m "Describe your changes here"
   ```

6. **Push to GitHub:**
   - Push your branch to your forked repository:
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Submit a Pull Request:**
   - Go to the original repository at `https://github.com/rfluethi/German-translation-for-Lesson-WordPress-essentials-Domains-and-hosting/`.
   - Click on the "Pull Requests" tab, then click the "New Pull Request" button.
   - Select your branch from the "compare" dropdown and submit your pull request for review.

## Downloadable Release Files

Each release includes the following files, which are automatically generated by the `release.yml` script ("Create and upload ZIP files for release") if the corresponding data is available:

- **[tutorial-docs.zip](https://github.com/rfluethi/German-translation-for-Lesson-WordPress-essentials-Domains-and-hosting/releases/latest/download/tutorial-docs.zip)**: Documentation files from the `/docs/` directory covering the learning materials.
- **[tutorial-assets.zip](https://github.com/rfluethi/German-translation-for-Lesson-WordPress-essentials-Domains-and-hosting/releases/latest/download/tutorial-assets.zip)**: Working files from the `/src/` directory used in creating the learning materials.
- **[tutorial-videos.zip](https://github.com/rfluethi/German-translation-for-Lesson-WordPress-essentials-Domains-and-hosting/releases/latest/download/tutorial-videos.zip)**: The latest generated video.

These files, along with **Source code (zip)** and **Source code (tar.gz)**, are available for the latest release under **[current release](https://github.com/rfluethi/German-translation-for-Lesson-WordPress-essentials-Domains-and-hosting/releases/latest)** including the corresponding release notes.

You can also download the **[main.zip](https://github.com/rfluethi/German-translation-for-Lesson-WordPress-essentials-Domains-and-hosting/archive/refs/heads/main.zip)**, which contains the current version of all actively worked-on files.

## License

The content of this repository is licensed under the [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/) license. Please note that some logos, images, and other assets may be subject to different copyright restrictions. Refer to the documentation and original resources for further details.

## Contact

For any questions or suggestions, please contact the project maintainer at [mail@rfluethi.com](mailto:mail@rfluethi.com). You can also join our community discussions on [WordPress Slack](https://make.wordpress.org/chat/) for more interactive support.
