# HackEd - Lab - Standalone Kali + VulnBank
This is a docker image including Kali distro and VulnBank web app. 
RDP is available on Kali (port 3390), so you can connect to GUI even using docker on Windows 10 (no WSL2).

## Installation
1) Download Docker Desktop from official repository (i.e. https://www.docker.com or from official stores like Windows Store).
2) Download **\<kali image\>** from this repository.
3) Start docker engine (eg. starting Docker Desktop)
4) Open terminal (e.g. cmd on Windows), move to the folder containing the downloaded file **\<kali image\>**, and run the following command to install the image on Docker
> docker load -i **\<kali image\>**
5) On the same terminal, run the following command to create the container starting from the image
> docker run --tty --interactive -p 3390:3390 -p 5000:5000 --name kali **\<kali image\>**

## Starting the lab
