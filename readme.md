# Turntable-Pi
This project takes an input device (USB connection to a turntable) and makes the output available as an HTTP stream suitable for consumption from an application like TuneIn Radio.

### Required components
- Turntable with USB output: https://www.bestbuy.com/site/sony-bluetooth-stereo-turntable-black/6336535.p?skuId=6336535
- Raspberry Pi 4 or similar device

### Setup
Assuming that docker, docker-compose are already installed and repository is already cloned.
1. Plugin the turntable and start trying to identify the path to the device. This is easier if you only have a single device.
2. Run `lsusb` and you should see similar output:
    ```
    Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
    Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
    Bus 001 Device 003: ID 08bb:29c0 Texas Instruments PCM2900C Audio CODEC
    Bus 001 Device 002: ID 2109:3431 VIA Labs, Inc. Hub
    Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
    ```
3. If you aren't sure which device it is at this point or you need additiona details, you can run `lsusb -v` to get additional details for all the devices. To inspect a specific device, use the bus and device number. For the Texas Instruments PCM2900C device, this would be `lsusb -s 1:3 -v` to get the specific device.
4. Once you have identified the device, see if you can identify the path. Run `ls /dev/input/by-id` and choose the ID that closely relates to the device you saw in the previous step.
5. Take the path and update the `docker-compose.yml` devices section with the path to your turntable.
6. Run `docker-compose up --build -d` and let the image build and start up.
7. You should be able to hit Icecast2 at `http://{{turntablehost}}:8000`. The stream will be available at `http://{{turntable}}:8000/turntable.mp3`.

### Todos
- [ ] Use hardware acceleration enabled version of FFMPEG to support FLAC streams
- [ ] Move to NixOS and run directly on NixOS rather than Docker
- [ ] Parameterize config files and setup HTTPS streams.
