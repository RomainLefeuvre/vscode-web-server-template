<a id="readme-top"></a>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]


<!-- PROJECT LOGO -->
<br />
<div align="center">
  
<h3 align="center">Web IDE template</h3>

  <p align="center">
    Easily design reproducible development environment  
    <br />
    <a href="https://github.com/RomainLefeuvre/vscode-web-server-template"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    &middot;
    <a href="https://github.com/RomainLefeuvre/vscode-web-server-template/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    &middot;
    <a href="https://github.com/RomainLefeuvre/vscode-web-server-template/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li><a href="#prerequisites">Prerequisites</a></li>
    <li><a href="#installation">Installation</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>


## About The Project
This project provides a template for self-hosted web IDE, enabling end user to setup development environment in one command.

It describes how to setup the execution environment, deploy an instance of vscode server https://github.com/gitpod-io/openvscode-server and trigger command at the opening of the browser.

The main advantage of this template is that it provide a full tutorial to provide web ide that :
* provide custom dev environment
* install extension needed 
* launch automatically some commands at startup 

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Prerequisites
The only prerequiste is Docker

If you do not have docker, install it : [https://docs.docker.com/engine/install/](https://docs.docker.com/engine/install/)

## Designing Web IDE environment 
### I- Add your code
Add your code at the root of this project 

### II- Update the dev envrionment
The provided environment is an ubuntu image, you can customize the [Dockerfile](./Dockerfile) to install the software you need in the development environment (For instance here Java, maven ...) :

```
Dockerfile
...
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
...
```
### III- Update the list of extension that will be provided by default
To make the environement ready to use for end user, you can install automatically the needed extensions. 
To add an extension modify the ENTRYPOINT command of the [Dockerfile](./Dockerfile) and add a new line "--install-extension {your extension id}" (For instance here the java-pack) :
```
Dockerfile 
...
ENTRYPOINT [ "/bin/sh", "-c", "exec ${OPENVSCODE_SERVER_ROOT}/bin/openvscode-server \
                                                                 --host 0.0.0.0\
                                                                 --without-connection-token \"${@}\"\
                                                                 --install-extension /home/.extension/StartupTask-0.0.1.vsix\
                                                                 --install-extension vscjava.vscode-java-pack\
                                                                 --start-server\
                                                                 --default-folder /home/workspace", "--" ]
```

### IV- Add command launch at startup
If you want to automatically launch command at startup, you can add your command in [.init](./.init)
```
.init
echo ""
mvn clean package
```
Note that this feature is provided by the custom extension : [StartupTask](https://github.com/RomainLefeuvre/vs-code-startup-extension)


## Usage
To start your environment you just have to run : 

> docker-compose up --build

Wait a minute to ensure all the extension are installed.

Then you can access the web IDE with :

>[http://localhost:3000](http://localhost:3000)

Tada !

## License

Distributed under the project_license. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contact

Romain Lefeuvre -  contact@romainlefeuvre.com

Project Link: [https://github.com/RomainLefeuvre/vscode-web-server-template](https://github.com/RomainLefeuvre/vscode-web-server-template)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


[contributors-shield]: https://img.shields.io/github/contributors/RomainLefeuvre/vscode-web-server-template.svg?style=for-the-badge
[contributors-url]: https://github.com/RomainLefeuvre/vscode-web-server-template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/RomainLefeuvre/vscode-web-server-template.svg?style=for-the-badge
[forks-url]: https://github.com/RomainLefeuvre/vscode-web-server-template/network/members
[stars-shield]: https://img.shields.io/github/stars/RomainLefeuvre/vscode-web-server-template.svg?style=for-the-badge
[stars-url]: https://github.com/RomainLefeuvre/vscode-web-server-template/stargazers
[issues-shield]: https://img.shields.io/github/issues/RomainLefeuvre/vscode-web-server-template.svg?style=for-the-badge
[issues-url]: https://github.com/RomainLefeuvre/vscode-web-server-template/issues
[license-shield]: https://img.shields.io/github/license/RomainLefeuvre/vscode-web-server-template.svg?style=for-the-badge
[license-url]: https://github.com/RomainLefeuvre/vscode-web-server-template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username