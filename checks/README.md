# Checks
Checks are scripts that verify document integrity.

### instalation
You need to install the checks (git hooks) in order to commit to the repository. 
Simply run ./scripts/install-hooks.sh

### description of scripts
check_file_length.sh - verifies that paralel text files (OST, TTcs{1,2}, TTde) have the same number of lines.
