#!/bin/bash
set -euo pipefail

echo "Installing Git hooks..."

# Check for .git directory
if [ ! -d ".git" ]; then
    echo "Error: .git directory not found. Please run this script from the Git repository root."
    exit 1
fi

# Create hooks directory
mkdir -p .git/hooks

# Create pre-commit hook directly
PRE_COMMIT=".git/hooks/pre-commit"

cat << 'EOF' > "$PRE_COMMIT"
#!/bin/bash
set -euo pipefail

# Check if google-java-format is available
if ! command -v google-java-format &> /dev/null; then
    echo "Warning: google-java-format command not found. Skipping formatting."
    exit 0
fi

# Find staged Java files
staged_files=$(git diff --cached --name-only --diff-filter=ACM | grep "\.java$" || true)

# Exit if no Java files are staged
if [ -z "$staged_files" ]; then
    echo "No staged Java files to format."
    exit 0
fi

echo "Formatting staged Java files..."

# Format each file and re-stage it
for file in ${staged_files}; do
    if [ -f "$file" ]; then
        google-java-format -i "$file"
        git add "$file"
        echo "Formatted and staged: $file"
    fi
done
EOF

# Set execute permission
chmod +x "$PRE_COMMIT"

echo "Git pre-commit hook installation complete!"