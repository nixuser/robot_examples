import filecmp
import os

def compare_files(file1, file2):
    # Check that both files exist
    if not (os.path.exists(file1) and os.path.exists(file2)):
        raise FileNotFoundError(f"Either {file1} or {file2} does not exist")
    # Compare the files byte by byte
    result = filecmp.cmp(file1, file2)
    # Return True if the files are equal, False otherwise
    return result

def compare_directories(dir1, dir2):
    # Check that both directories exist
    if not (os.path.isdir(dir1) and os.path.isdir(dir2)):
        raise NotADirectoryError(f"Either {dir1} or {dir2} is not a directory")
    # Compare the directories recursively
    result = filecmp.dircmp(dir1, dir2)
    # Return True if the directories are equal, False otherwise
    return result.same_files and \
           not result.diff_files
