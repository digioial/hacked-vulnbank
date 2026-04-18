# HackEd - Lab - Standalone Kali + Vuln web app
This is a docker image including Kali distro and a vulnerable web app. 
RDP is available on Kali (port 3390), so you can connect to GUI even using docker on Windows 10 (no WSL2).

## Prerequisites
1) Docker. In case you don't have alredy installed it, you can download Docker Desktop from official repository
> https://www.docker.com

## Installation
1) Download **\<kali image\>** from this repository.
2) If not done before, start docker engine (eg. starting Docker Desktop)
3) Open terminal (e.g. cmd on Windows), move to the folder containing the downloaded file **\<kali image\>**, and run the following command to install the image on Docker
> docker load -i **\<kali image\>**
4) On the same terminal, run the following command to create the container starting from the image
> docker run --tty --interactive -p 3390:3390 -p 5000:5000 --name **\<kali container\>** **\<kali image\>**

## Starting the lab
1) If not done before, start docker engine (eg. starting Docker Desktop)
2) Open terminal (e.g. cmd on Windows), and run the following command to start the container
> docker start **\<kali container\>**
3) On the same terminal, run the following command to attach the terminal
> docker attach **\<kali container\>**
4) In the attached terminal on Kali, run the following command
> ./mystart
 
In case you need another terminal on the same running container, run the following command
> docker exec -it **\<kali container\>** bash
