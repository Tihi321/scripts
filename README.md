# Scripts Collection

A collection of utility batch scripts for various file and system operations.

## Batch Scripts

### convert_to_mp3.bat

Converts audio/video files to MP3 format using ffmpeg.

**Usage:**

```
convert_to_mp3.bat input_folder [output_folder] [bitrate]
```

**Example:**

```
convert_to_mp3.bat "C:\Music\FLAC" "C:\Music\MP3" 320k
```

### convert_video_resolution.bat

Resizes video files to different resolutions using ffmpeg.

**Usage:**

```
convert_video_resolution.bat input_file resolution [output_folder]
```

**Example:**

```
convert_video_resolution.bat video.mp4 720p
convert_video_resolution.bat video.mp4 1280x720 D:\converted_videos
```

### rename_with_prefix.bat

Renames files in a folder by adding a prefix at a specified character position.

**Usage:**

```
rename_with_prefix.bat folder_path prefix [char_position]
```

**Example:**

```
rename_with_prefix.bat "C:\Photos" "vacation_" 0
```

### resize_mp3_bitrate.bat

Changes the bitrate of MP3 files using ffmpeg.

**Usage:**

```
resize_mp3_bitrate.bat input_folder [bitrate]
```

**Example:**

```
resize_mp3_bitrate.bat "C:\Music" 192k
```

### restart_task_manager_icons.bat

Fixes issues with Windows Task Manager icons by clearing icon caches and restarting explorer.

**Usage:**

```
restart_task_manager_icons.bat
```

### stop_py_scripts_by_memo_usage.bat

Stops Python processes based on memory usage thresholds.

**Usage:**

```
stop_py_scripts_by_memo_usage.bat
```

Then follow prompts to enter memory thresholds.

## Requirements

- Most audio/video scripts require [FFmpeg](https://ffmpeg.org/download.html) installed and available in your PATH.
- Scripts should be run with administrator privileges for system operations like task killing or registry access.
