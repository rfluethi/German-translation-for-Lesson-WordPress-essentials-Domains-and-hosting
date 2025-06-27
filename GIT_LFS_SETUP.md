# Git LFS Setup for Large Files

This repository uses Git Large File Storage (LFS) for managing large files.

## What is Git LFS?

Git LFS is an extension for Git that efficiently manages large files by storing them outside the Git repository. This improves performance and reduces repository size.

## Automatic LFS Management

**🎉 IMPORTANT: LFS management is AUTOMATIC!**

Once Git LFS is set up, **no manual configuration is required** for new files. The system automatically detects and manages large files based on file extensions defined in `.gitattributes`.

### How it works:
1. **Create** any file with a supported extension (e.g., `*.mp4`, `*.wav`, `*.cmproj`)
2. **Add** it to git with `git add filename`
3. **Git LFS automatically** recognizes and manages the file
4. **No manual setup** required!

### Example:
```bash
# Create a new video file
cp my-video.mp4 media/video/video-v-0-03-00.mp4

# Add it to git (LFS handles it automatically)
git add media/video/video-v-0-03-00.mp4

# Check that it's managed by LFS
git lfs ls-files
# Output: media/video/video-v-0-03-00.mp4 (managed by LFS)
```

## Large Files in this Repository

The following file types are **automatically** managed with Git LFS:

### Video Files (Automatic)
- **All MP4 files** (`*.mp4`) - anywhere in the repository
- **All MOV files** (`*.mov`)
- **All AVI files** (`*.avi`)
- **All MKV files** (`*.mkv`)
- **All WebM files** (`*.webm`)

### Audio Files (Automatic)
- **All WAV files** (`*.wav`)
- **All M4A files** (`*.m4a`)
- **All MP3 files** (`*.mp3`)
- **All AAC files** (`*.aac`)

### Project Files (Automatic)
- **All project files** (`*.cmproj`, `*.moho`)

### Design Files (Automatic)
- **All design files** (`*.psd`, `*.ai`, `*.afdesign`)

### Archive Files (Automatic)
- **All archive files** (`*.zip`, `*.tar.gz`, `*.7z`)

### Current Large Files
- `media/video/video-v-0-02-00.mp4` (39MB)
- `src/assets/video/video-v-0-02-00.cmproj/` (225MB) - All files in this directory
- All MP4 files in `src/assets/animation/`

## Installing Git LFS

### For Developers

1. **Install Git LFS:**
   ```bash
   # macOS (with Homebrew)
   brew install git-lfs
   
   # Ubuntu/Debian
   sudo apt install git-lfs
   
   # Windows (with Chocolatey)
   choco install git-lfs
   ```

2. **Initialize Git LFS:**
   ```bash
   git lfs install
   ```

3. **Clone repository:**
   ```bash
   git clone <repository-url>
   cd <repository-name>
   git lfs pull
   ```

### For CI/CD (GitHub Actions)

The release script is already configured to use Git LFS:

```yaml
- name: Checkout repository with LFS
  uses: actions/checkout@v4
  with:
    lfs: true
```

## Release Process

When creating a release, ZIP files are automatically created that include all LFS files:

1. **tutorial-docs.zip** - Documentation
2. **tutorial-assets.zip** - All assets (incl. LFS files)
3. **tutorial-videos.zip** - Video files (incl. LFS files)
4. **tutorial-complete.zip** - Complete project (incl. all LFS files)

## Notes for Developers

### ✅ Automatic Operations
- **Adding new large files:** Git LFS automatically recognizes files based on the `.gitattributes` configuration
- **No manual tracking required:** Just create and add files normally
- **File extensions matter:** Only files with configured extensions are managed by LFS

### 🔍 Checking and Managing
- **Checking files:** `git lfs ls-files` shows all files managed with LFS
- **Checking LFS status:** `git lfs status` shows the status of LFS files
- **Downloading LFS files:** `git lfs pull` downloads all LFS files

### 📝 Adding New File Types (Advanced)
If you need to add support for new file types, you can extend the `.gitattributes` file:

```bash
# Add support for new file type
git lfs track "*.newextension"
git add .gitattributes
git add file.newextension
```

## Troubleshooting

### LFS files are not downloaded

```bash
git lfs pull
git lfs fetch --all
```

### Check LFS status

```bash
git lfs status
git lfs ls-files
```

### Verify automatic detection is working

```bash
# Create a test file
echo "test" > test.mp4

# Add it to git
git add test.mp4

# Check if it's managed by LFS
git lfs ls-files | grep test.mp4

# Clean up
git reset HEAD test.mp4
rm test.mp4
```

## More Information

- [Git LFS Documentation](https://git-lfs.github.com/)
- [Git LFS GitHub](https://github.com/git-lfs/git-lfs) 