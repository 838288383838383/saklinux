FROM ubuntu:24.04

LABEL maintainer="Sakura Package Manager"
LABEL description="SakLinux - Sakura's Subsystem for Linux"
LABEL version="1.0"

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Copy rootfs overlay
COPY rootfs/ /

# Copy setup script
COPY installer/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

# Run base setup
RUN /tmp/setup.sh

# Set default shell
CMD ["/bin/bash"]
