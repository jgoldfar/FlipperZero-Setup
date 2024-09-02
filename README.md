# FlipperZero Setup

## Setup

0) Clone this repository on a unix-like system
1) `git submodule update --init --recursive`
2) `./bin/build-firmware.sh`
3) Flash the DFU using `qFlipper` (https://flipperzero.one/update) or using `./fbt flash_usb`
4) `SDCARD_MOUNT_DIR=/path/to/sdcard ./bin/copy_assets.sh`


## About

This repository combines several existing projects to enable functionality with the FlipperZero.

A FlipperZero is a near-distance digital communication multi-tool, including the following functionality:

- NFC (Near-Field Communication): "[NFC] is used in smart cards for access control and cards, and digital business cards, is compatible with Flipper Zero. The 13.56 MHz NFC module has the ability to imitate, read, and store these cards. An NFC card is a transponder with a unique identification (UID), and rewritable memory for data storage"
- 125 kHz RFID: "low-frequency (LF) radio frequency identification (RFID), [is] used in supply chain tracking systems, animal chips, and access control systems"
- Sub-1 GHz Radio: "can read, store, and emulate remote controls, allowing it to receive and send radio frequencies between 300 and 928 MHz. These switches, radio locks, wireless doorbells, remote controls, barriers, gates, smart lighting, and other devices can all be operated with these controls."
- Infrared port
- GPIO pins
- Bluetooth LE
- USB 2.0, compatible with [`BadUSB`](https://en.wikipedia.org/wiki/BadUSB): "BadUSB is a computer security attack using USB devices that are programmed with malicious software. For example, USB flash drives can contain a programmable Intel 8051 microcontroller, which can be reprogrammed, turning a USB flash drive into a malicious device"
- 1-Wire

### Dependencies

The upstream script repositories and projects are integrated with this repository via submodules, [managed](https://github.com/TransitiveDependencyDownstreams) locally.

- `firmware` is a clone of https://github.com/flipperdevices/flipperzero-firmware
- `assets/playground` is a fork of https://github.com/UberGuidoZ/Flipper containing a grab-bag of FlipperZero scripts.
- `assets/badusb` is a clone of the latest BadUSB script repository, https://github.com/I-Am-Jakoby/Flipper-Zero-BadUSB
- `assets/nfc/amiibo` is a collection of NFC scripts for emulating a [Nintendo Amiibo](https://www.nintendo.com/us/amiibo/) game add-on based on https://github.com/RogueMaster/FlipperAmiibo
- `assets/infrared` is a clone of https://github.com/logickworkshop/Flipper-IRDB, a categorized collection of infrared codes. The built-in categorization is organized by type of device first; if a device is found to be missing, check https://github.com/Lucaslhm/Flipper-IRDB which is organized by manufacturer

Codes and configuration from these vendored repositories are bundled into the Flipper when running the setup steps above.

Additional sources and possible installable scripts

- https://github.com/flipperdevices/flipperzero-good-faps flipperzero apps maintained by the original manufacturer
- https://github.com/djsime1/awesome-flipperzero
- https://github.com/Next-Flip/Momentum-Firmware a new firmware including custom apps
- https://github.com/aleff-github/my-flipper-shits/ more BadUSB scripts
- https://github.com/xMasterX/all-the-plugins/tree/dev a collection of apps for flipper
- https://github.com/quen0n/unitemp-flipperzero - an application for reading from environmental sensors
- https://github.com/xMasterX/all-the-plugins/tree/dev/base_pack/dtmf_dolphin bluebox/redbox for flipper
- https://github.com/xMasterX/all-the-plugins/tree/dev/base_pack/find_my_flipper find my app for flipper. Possibly originally from https://github.com/MatthewKuKanich/FindMyFlipper/tree/main
- https://github.com/xMasterX/all-the-plugins/tree/dev/base_pack/spectrum_analyzer radio spectrum analyzer for flipper
- https://github.com/MuddledBox/flipperzero-firmware/tree/Mouse_Jiggler/applications/mouse_jiggler a simple mouse jiggler
- https://github.com/kala13x/flipper-xremote an advanced IR remote application
