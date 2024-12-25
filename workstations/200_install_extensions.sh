#!/bin/bash
echo "Installing VSCode extensions as user 'user'..."

# Extensions to install
extensions=(
    "vscjava.vscode-java-pack"
    "VMware.vscode-boot-dev-pack"
    "GabrielBB.vscode-lombok"
    "redhat.fabric8-analytics"
    "SonarSource.sonarlint-vscode"
    "Continue.continue"
    "PKief.material-icon-theme"
    "mhutchie.git-graph"
)

# Run installation as 'user'
for ext in "${extensions[@]}"; do
    runuser user -c "/opt/code-oss/bin/codeoss-cloudworkstations --install-extension $ext"
done

echo "Extensions installed successfully."
