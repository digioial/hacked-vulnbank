# HackEd - Lab - Standalone Kali + Vuln web app
This is a docker image including Kali distro and a vulnerable web app. 
RDP is available on Kali (port 3390), so you can connect to GUI even using docker on Windows 10 (no WSL2).

## Prerequisites
1) Docker. In case you don't have alredy installed it, you can download Docker Desktop from official repository
> https://www.docker.com

## Installation
1) Download **kalifullimage** from following repository.
> https://drive.google.com/file/d/1hTXw6WpLuNsl9CrXQCUDGCIW72IBiPJ3/view?usp=sharing
2) If not done before, start docker engine (eg. starting Docker Desktop)
3) Open terminal (e.g. cmd on Windows), move to the folder containing the downloaded file **kalifullimage**, and run the following command to install the image on Docker
> docker load -i **kalifullimage**
4) On the same terminal, run the following command to create the container starting from the image
> docker run --tty --interactive -p 3390:3390 -p 5000:5000 --name **kalifull** **kalifullimage**

## Starting the lab
1) If not done before, start docker engine (eg. starting Docker Desktop)
2) Open terminal (e.g. cmd on Windows), and run the following command to start the container
> docker start **kalifull**
3) On the same terminal, run the following command to attach the terminal
> docker attach **kalifull**
4) In the attached terminal on Kali, run the following command
> ./mystart
 
In case you need another terminal on the same running container, run the following command
> docker exec -it **kalifull** bash

## Connecting Kali GUI
In case you need to need to connect to Kali GUI: 
1) Start **Remote Desktop Connection"
2) Type
> localhost:3390
3) Login as
> Username: kali
> Password: KaliLinu
