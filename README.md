# Workbench Toolbelt

> **IMPORTANT:**
This is NOT Workbench
This is a companion container that can enhance Workbench and is not at all required to connect to your EON or test with your vehicle.
To download Workbench, visit https://opc.ai/workbench

## Purpose

The goal of this repo is to quickly get up and running with **[commaai/openpilot-tools](https://github.com/commaai/openpilot_tools)** and stream previous drive data into **[Workbench](https://opc.ai/workbench)** and visualize it for testing, learning and experimentation purposes. We're trying to enable usage of **[commaai/openpilot-tools](https://github.com/commaai/openpilot_tools)** the need for a GUI.

An added benefit of building this container is that we can test **[Workbench](https://opc.ai/workbench)** features without requiring an EON to be connected to a running vehicle.

## Usage

To get started, install Docker on your Mac, Windows, or Linux machine.
Not going to cover this as its very easy to install.

Now clone this repo to your computer...

```
git clone https://github.com/openpilot-community/workbench-toolbelt.git ~/MyProjectsDirectory/workbench-toolbelt
```

Change into that directory...

```
cd ~/MyProjectsDirectory/workbench-toolbelt
```

Build the docker container...

```
docker-compose build
```

Start the docker container...

```
docker-compose up
```

You should now see something like the following:

```sh
workbench-toolbelt % docker-compose up
Starting workbench-toolbelt_server_1_ff1733ad9450 ... done
Attaching to workbench-toolbelt_server_1_ff1733ad9450
server_1_ff1733ad9450 |
server_1_ff1733ad9450 | ---> Starting the SSH server.
server_1_ff1733ad9450 | Starting OpenBSD Secure Shell server: sshd.
server_1_ff1733ad9450 | sshd is running.
```

Now switch to a new tab in your Terminal emulator and test it out...

```
ssh root@0.0.0.0 -p 8022 -i ~/.ssh/openpilot_rsa
```

If you already had your openpilot_rsa key setup from using Workbench, this should all be successful and return something similar to below...

```sh
workbench-toolbelt % ssh root@0.0.0.0 -p 8022 -i ~/.ssh/openpilot_rsa
Last login: Tue Feb 12 23:08:47 2019 from 172.22.0.1
root@server:/system/comma/home#
```

## Scan for EON with Workbench

Now that you have it running, this container will show up in Workbench as if it's an EON.