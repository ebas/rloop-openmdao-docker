FROM ubuntu:14.04

ADD root/install.sh /root/install.sh
ADD root/divzero.patch /root/divzero.patch

RUN /root/install.sh

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
