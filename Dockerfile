FROM debian:jessie

# Replace 1000 with your user / group id
ENV LULZBOT_CURA_UID 1000
ENV LULZBOT_CURA_GID 1000

RUN apt-get update -y && \
        apt-get install -y \
        apt-utils \
        wget \
        sudo

RUN wget -qO - https://download.alephobjects.com/ao/aodeb/aokey.pub | sudo apt-key add -

RUN sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
        sudo sed -i '$a deb http://download.alephobjects.com/ao/aodeb jessie main' /etc/apt/sources.list && \
        sudo apt-get update -y && \
        sudo apt-get install cura-lulzbot -y

RUN export uid=${LULZBOT_CURA_UID} gid=${LULZBOT_CURA_GID} && \
        addgroup --gid ${gid} ptl && \
        adduser -q -u ${uid} --gid ${gid} --shell /bin/bash --gecos "First Last,RoomNumber,WorkPhone,HomePhone" ptl --disabled-password && \
        echo ptl:ptlptl | sudo chpasswd && \
        sudo -u ptl mkdir -p -m=00755 "/home/ptl/Documents" "/home/ptl/.cura" "/home/ptl/.local" && \
        usermod -a -G tty ptl && \
        usermod -a -G dialout ptl

USER ptl
ENV HOME /home/ptl
CMD /usr/bin/cura-lulzbot /home/ptl/Documents
