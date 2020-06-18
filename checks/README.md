# Checks
Checks are scripts that verify document integrity.

### instalation
You need to install the checks (git hooks) in order to commit to the repository. 
Simply run ../checks/install-hooks.sh

### description of scripts
check_file_length.sh - verifies that paralel text files (OST, TTcs{1,2}, TTde) have the same number of lines.
check_sentence_format - all text files are in a sentence per line format, begin with capital letter and end with [.!?]
