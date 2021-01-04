# ------------------------------------------------------------------------------
# Pull base image
FROM debian:bullseye-slim
MAINTAINER Brett Kuskie <fullaxx@gmail.com>

# ------------------------------------------------------------------------------
# Set environment variables
ENV DEBIAN_FRONTEND noninteractive

# ------------------------------------------------------------------------------
# Install vsftpd and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends stunnel && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Install startup script and stunnel config
COPY app/app.sh /app/
COPY conf/stunnel.conf /etc/stunnel/stunnel.conf

# ------------------------------------------------------------------------------
# Define runtime command
CMD ["/app/app.sh"]
