FROM debian:jessie

RUN apt-get update && apt-get install -y \
        wget \
        apt-utils \
        sudo

RUN wget -qO - https://download.alephobjects.com/ao/aodeb/aokey.pub | sudo apt-key add -

RUN sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak && sudo sed -i '$a deb http://download.alephobjects.com/ao/aodeb jessie main' /etc/apt/sources.list && sudo apt-get update -y && sudo apt-get install cura-lulzbot -y

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
        mkdir -p /home/ptl && \
        echo "ptl:x:${uid}:${gid}:Post Tenebras Lab,,,:/home/ptl:/bin/bash" >> /etc/passwd && \
        echo "ptl:x:${uid}:" >> /etc/group && \
        echo "ptl ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ptl && \
        chmod 0440 /etc/sudoers.d/ptl && \
        mkdir /home/ptl/Documents && \
        mkdir /home/ptl/.cura && \
        mkdir /home/ptl/.local && \
        chown ${uid}:${gid} -R /home/ptl &&\
        usermod -a -G tty ptl && \
        usermod -a -G dialout ptl

USER ptl
ENV HOME /home/ptl
CMD /usr/bin/cura-lulzbot /home/ptl/Documents
