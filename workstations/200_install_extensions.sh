#!/bin/bash
echo "Installing VSCode extensions as user 'user'..."

# Extensions to install
extensions=(
    "vscjava.vscode-java-pack@0.29.0"
    "VMware.vscode-boot-dev-packg@0.1.0"
    "GabrielBB.vscode-lombok@1.0.1"
    "redhat.fabric8-analytics@0.9.5"
    "SonarSource.sonarlint-vscode@4.6.0"
    "Continue.continue@0.9.239"
    "PKief.material-icon-theme@5.1.41"
    "mhutchie.git-graph@1.30.0"
)

# Run installation as 'user'
for ext in "${extensions[@]}"; do
    runuser user -c "/opt/code-oss/bin/codeoss-cloudworkstations --install-extension $ext"
done

echo "Extensions installed successfully."
