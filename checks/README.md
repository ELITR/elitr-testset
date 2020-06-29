# Checks
Checks are scripts that verify document integrity.

### instalation
You need to install the checks (git hooks) in order to commit to the repository. 
Simply run ../checks/install-hooks.sh

### description of scripts
implemented:
check_precommit.sh - this script runs the most important checks before every commit to the repository. It prevents commiting if it finds an error. If it gives any warnings, you can ignore them. 
check_all.sh - this script runs every check. It can give a lot of warings and can take some time to finish. 
check_file_length.sh - verifies that paralel text files (OST, TTcs{1,2}, TTde) have the same number of lines.
check_file_size - all (sound) files are below 50 mb. 
check_sentence_format - all text files are in a sentence per line format, begin with capital letter and end with [.!?] (non-essential, just a warning)
check_has_translation - finds source files (.OSt) that do not have any translations (non-essential, just a warning)

to be added:
check_filename_extensions - all filename extensions are included in readme (prevents typos and ensures good documentation)
check_sound_format - only mp3 can be stored directly, others path only, eg. waw.linkletter and end with [.!?]
check_source_file_exists - every translation (eg. TTcs) has a source file (eg. OSt)
check_utf8 - every text file is in UTF-8 (or ASCII)
check_line_ends - every text file has native line ends (LF on Linux, CR on old Mac, CRLF on Windows), *last line ends with an explicit linebreak*
check_wav - some soxi or whatever diagnosis, if the file format looks good
...
