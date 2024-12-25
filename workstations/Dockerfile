# Build image
FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

# Update and remove pre-installed Temurin JDK
RUN apt-get update && apt-get remove -y temurin-11-jdk temurin-17-jdk && apt-get autoremove -y && apt-get clean

# Install SDKMAN!
RUN curl -s "https://get.sdkman.io" | bash && \
    chmod +x "/root/.sdkman/bin/sdkman-init.sh"

# Move SDKMAN to shared directory
RUN mv /root/.sdkman /opt/sdkman && \
    chmod -R 777 /opt/sdkman

# Set environment variables to enable SDKMAN!
ENV SDKMAN_DIR="/opt/sdkman"
ENV PATH="${SDKMAN_DIR}/bin:${PATH}"

# Install specific Java version (21.0.1-librca) using SDKMAN
RUN bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && \
    sdk install java 21.0.1-librca && \
    sdk default java 21.0.1-librca && \
    sdk install springboot"

# Initialize SDKMAN in global shell
RUN echo "source /opt/sdkman/bin/sdkman-init.sh" >> /etc/bash.bashrc

# Verify installation version
RUN bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && java -version"

# Add VSCode extensions installation script
COPY 200_install_extensions.sh /etc/workstation-startup.d/200_install_extensions.sh
RUN chmod +x /etc/workstation-startup.d/200_install_extensions.sh

# Copy Google Java Formatter installation script to startup scripts
COPY 200_install_google_java_formatter.sh /etc/workstation-startup.d/200_install_google_java_formatter.sh
RUN chmod +x /etc/workstation-startup.d/200_install_google_java_formatter.sh

# Keep original ENTRYPOINT setting
ENTRYPOINT ["/google/scripts/entrypoint.sh"]
