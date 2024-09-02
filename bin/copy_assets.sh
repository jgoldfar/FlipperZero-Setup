#!/bin/sh

set -eu

REPO_DIR="$(cd `dirname $0` && pwd)/.."

cd "$REPO_DIR"

if [ -z "${SDCARD_MOUNT_DIR}" ] ; then
    SDCARD_MOUNT_DIR="$REPO_DIR/sd_card"
fi

if [ ! -d "${SDCARD_MOUNT_DIR}" ] ; then
    echo "Error: ${SDCARD_MOUNT_DIR} is not mounted"
    echo ""
    echo " 1) Install any firmware onto the Flipper at least once"
    echo " 2) Unmount the SD card in the Flipper"
    echo "    Settings > Storage > Unmount SD Card"
    echo " 3) Insert the SD card into a reader in this computer"
    echo " 4) Mount the SD card to ${SDCARD_MOUNT_DIR}"
    echo "    e.g. mount -t vfat -o rw,umask=000 /dev/sda1 ${SDCARD_MOUNT_DIR}"
    echo " 5) Run this script again"
    exit 1
fi

mkdir -pv sd_backup

tar cvfz "sd_backup/flipper-sd-backup-$(date +%Y-%m-%d).tgz" ${SDCARD_MOUNT_DIR}

# ELF applications
# SDK may not be stable - delete any existing Flipper apps
mkdir -pv ${SDCARD_MOUNT_DIR}/apps

rm -f ${SDCARD_MOUNT_DIR}/apps/*.fap

cd firmware
FBT_NO_SYNC=y ./fbt COMPACT=1 DEBUG=0 VERBOSE=1 fap_dist

cd "${REPO_DIR}"

rsync -rav firmware/dist/f7-C/apps/ ${SDCARD_MOUNT_DIR}/apps/.
rsync -rav firmware/dist/f7-C/apps_data/ ${SDCARD_MOUNT_DIR}/apps_data/. \
      --exclude example_plugins \
      --exclude example_plugins_multi

# BadUSB: currently considering if we want this

# mkdir -pv ${SDCARD_MOUNT_DIR}/badusb

# rsync -rv assets/playground/BadUSB/* ${SDCARD_MOUNT_DIR}/badusb/. \
#     --exclude *.md
# rsync -rv assets/badusb/Payloads/* ${SDCARD_MOUNT_DIR}/badusb/.

# Dolphin pictures? Not a feature we want

# mkdir -pv ${SDCARD_MOUNT_DIR}/dolphin

# rsync -rv assets/playground/Graphics/manifest.txt ${SDCARD_MOUNT_DIR}/dolphin/.

# Infrared

mkdir -pv ${SDCARD_MOUNT_DIR}/infrared

rsync -rv assets/infrared/* ${SDCARD_MOUNT_DIR}/infrared/. \
    --exclude README.md \
    --exclude _CSV-IRDB_ \
    --exclude _Pronto_Converted_ \
    --exclude _Converted_


# Music Player (not a feature we want)

# mkdir -pv ${SDCARD_MOUNT_DIR}/music_player

# rsync -rv assets/music_player/* ${SDCARD_MOUNT_DIR}/music_player/. \
#     --exclude README.md \
#     --exclude *.zip

# NFC

mkdir -pv ${SDCARD_MOUNT_DIR}/nfc/amiibo

rsync -rv assets/nfc/amiibo/Legend_of_Zelda ${SDCARD_MOUNT_DIR}/nfc/amiibo/.
rsync -rv assets/nfc/amiibo/Pikmin_Amiibo ${SDCARD_MOUNT_DIR}/nfc/amiibo/.
rsync -rv assets/nfc/amiibo/Super_Smash_Bros ${SDCARD_MOUNT_DIR}/nfc/amiibo/.

## These no longer appear to be relevant
# rsync -rv assets/playground/NFC/* ${SDCARD_MOUNT_DIR}/nfc/. \
#     --exclude *.md \
#     --exclude Amiibo \
#     --exclude HID_iClass \
#     --exclude mf_classic_dict


# Sub-GHz

mkdir -pv ${SDCARD_MOUNT_DIR}/subghz

for bak_file in touchtunes_map.txt universal_rf_map.txt; do
    if [ -e ${SDCARD_MOUNT_DIR}/subghz/assets/$bak_file ]; then
        mv ${SDCARD_MOUNT_DIR}/subghz/assets/$bak_file ${SDCARD_MOUNT_DIR}/subghz/assets/$bak_file.bak
    fi
done

rsync -rv assets/playground/Sub-GHz/* ${SDCARD_MOUNT_DIR}/subghz/. \
    --exclude *.md \
    --exclude *.png \
    --exclude Settings \
    --exclude TouchTunes/*.md \
    --exclude TouchTunes/touchtunes_map

rsync assets/playground/Sub-GHz/Settings/setting_user ${SDCARD_MOUNT_DIR}/subghz/assets/.

#sed -e 's/add_standard_frequencies: false/add_standard_frequencies: true/' \
#    -e's/ignore_default_tx_region: false/ignore_default_tx_region: true/' \
#    ${SDCARD_MOUNT_DIR}/subghz/assets/setting_user | tee ${SDCARD_MOUNT_DIR}/subghz/assets/setting_user

for bak_file in touchtunes_map.txt universal_rf_map.txt; do
    if [ -e ${SDCARD_MOUNT_DIR}/subghz/assets/$bak_file.bak ]; then
        mv ${SDCARD_MOUNT_DIR}/subghz/assets/$bak_file.bak ${SDCARD_MOUNT_DIR}/subghz/assets/$bak_file
    fi
done

# # WAV player

# mkdir -pv ${SDCARD_MOUNT_DIR}/wav_player

# rsync -rv assets/playground/Wav_Player/* ${SDCARD_MOUNT_DIR}/wav_player/. \
#     --exclude *.md

# # Clean up any DS_Store files
find ${SDCARD_MOUNT_DIR} -name ".DS_Store" -type f -delete
# Clean up other MacOS junk we don't want on the SD Card
rm -rf ${SDCARD_MOUNT_DIR}/.Trashes
rm -rf ${SDCARD_MOUNT_DIR}/.Spotlight-V100
