# PTL-lulzbot

Docker version of Cura Lulzbot Edition.

## Usage

    docker pull posttenebraslab/ptl-lulzbot

    docker run --rm -e DISPLAY=$DISPLAY \
            -v $(pwd):/home/ptl/ \
            -v /dev/ttyACM0:/dev/ttyACM0 \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            posttenebraslab/ptl-lulzbot

select Lulzbot TAZ 4 and enjoy ;-)

## More infos

- [Lulzbot](https://www.lulzbot.com)
- [Lulzbot Cura Debian installation](https://www.lulzbot.com/cura/debian-installation)
- [PTL](https://www.posttenebraslab.ch)
