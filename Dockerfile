FROM gitpod/openvscode-server:1.95.2

# Switch to root user for installations
USER root

########################SETUP your ENVIRONMENT########################
#Download and install JAVA
RUN wget https://download.java.net/java/GA/jdk23.0.1/c28985cbf10d4e648e4004050f8781aa/11/GPL/openjdk-23.0.1_linux-x64_bin.tar.gz && \
    tar -xvf openjdk-23.0.1_linux-x64_bin.tar.gz -C /opt && \
    rm openjdk-23.0.1_linux-x64_bin.tar.gz

ENV JAVA_HOME=/opt/jdk-23.0.1
ENV PATH=$JAVA_HOME/bin:$PATH
# Install Maven
RUN apt-get update
RUN apt-get install -y maven
####################################################################

USER openvscode-server
# Expose OpenVSCode Server port
EXPOSE 3000
ENV OPENVSCODE_SERVER_ROOT="/home/.openvscode-server"
ENV OPENVSCODE="${OPENVSCODE_SERVER_ROOT}/bin/openvscode-server"
COPY .extension /home/.extension
ENTRYPOINT [ "/bin/sh", "-c", "exec ${OPENVSCODE_SERVER_ROOT}/bin/openvscode-server \
                                                                 --host 0.0.0.0\
                                                                 --without-connection-token \"${@}\"\
                                                                 --install-extension /home/.extension/StartupTask-0.0.1.vsix\
                                                                 --install-extension vscjava.vscode-java-pack\
                                                                 --start-server\
                                                                 --default-folder /home/workspace", "--" ]

