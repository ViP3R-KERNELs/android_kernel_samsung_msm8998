#!/bin/bash
set -e -o pipefail

# =========================
#   BUILD IDENTITY
# =========================
DATE=$(date +'%Y%m%d-%H%M')

export ARCH=arm64
export DEFCONFIG=viper_defconfig

export LOCALVERSION=-ViP3R🐍-v1.0-NETHUNTER-EDITION-2K26
export KBUILD_BUILD_USER=IamCOD3X
export KBUILD_BUILD_HOST=RYZEN
export ANDROID_MAJOR_VERSION=p
export PLATFORM_VERSION=9.0.0

# =========================
#   PATHS
# =========================
KERNEL_PATH=$(pwd)
OUT=${KERNEL_PATH}/out
JOBS=$(nproc)

# =========================
#   TOOLCHAIN (GCC)
# =========================
TC_PATH=/home/ripper/Desktop/OS/KERNEL_STUFF/ToolChains

export PATH="${TC_PATH}/aarch64-linux-androidkernel/bin:${TC_PATH}/armhf-4.9/bin:${PATH}"

export CROSS_COMPILE=aarch64-linux-android-
export CROSS_COMPILE_ARM32=arm-linux-androideabi-

# =========================
#   CLEAN
# =========================
echo "[*] Cleaning source"
make clean && make mrproper
rm -rf "${OUT}"
mkdir -p "${OUT}"

# =========================
#   DEFCONFIG
# =========================
echo "[*] Applying defconfig: ${DEFCONFIG}"
make \
  O="${OUT}" \
  ARCH=arm64 \
  ${DEFCONFIG}

# =========================
#   BUILD
# =========================
echo "[*] Building kernel (GCC)"
make \
  -j${JOBS} \
  O="${OUT}" \
  ARCH=arm64

echo "[✓] Kernel build finished"
