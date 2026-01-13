#!/bin/bash

# Robust and agressive local R installation

R_VERSION="${R_VERSION:-4.5.2}"
R_REPO="${R_REPO:-https://cran.r-project.org/src/base/R-4/R-${R_VERSION}.tar.gz}"

printf "\n\nINSTALL R dependencies\n"

sudo apt update

## Blood and pain: R v4.0.0+
sudo apt install -y build-essential
sudo apt install -y libcurl4-openssl-dev
sudo apt install -y libbz2-dev
sudo apt install -y libpcre2-dev
sudo apt install -y libmagick++-dev libpng-dev libjpeg-dev
sudo apt install -y ninja-build #TODO: also from hpc (remove from here)
sudo apt install -y meson # TODO:guess was from hpc (remove from here)
sudo apt install -y libcairo2-dev
sudo apt install -y libharfbuzz-dev
sudo apt install -y libfribidi-dev
sudo apt install -y libfreetype-dev
sudo apt install -y libwebp-dev
sudo apt install -y libvips-dev
sudo apt install -y xorg-dev gsfonts-x11 xfonts-base xfonts-scalable xfonts-100dpi xfonts-75dpi
sudo apt install -y texlive texlive-fonts-extra texinfo
sudo apt install -y openjdk-11-jdk
sudo apt install -y libssl-dev
sudo apt install -y libxml2-dev


## R local install
RDIR="$HOME/.tools/R/R-$R_VERSION"
RBUILD_DIR="$HOME/tmp/R-build"
RSRC_DIR="$RDIR/src"
LOCAL_BIN="$HOME/.local/bin"

mkdir -p "$RSRC_DIR"
cd "$RDIR"

wget -O "R-${R_VERSION}.tar.gz" "$R_REPO"
tar -xzf "R-${R_VERSION}.tar.gz" -C "${RSRC_DIR}" --strip-components=1

# Build
rm -rf "${RBUILD_DIR}"
mkdir -p "${RBUILD_DIR}"
cd "${RBUILD_DIR}"

# Configure
"${RSRC_DIR}/configure" \
  --prefix="$RDIR" \
  --enable-memory-profiling \
  --enable-R-shlib \
  --with-blas \
  --with-lapack \
  --with-libpng \
  --with-jpeglib \
  --with-cairo \
  --with-readline=yes \
  --with-system-tre=no

# Compile
make -j$(nproc) && make install

# Link binary
ln -sf "$RDIR/bin/R" "$LOCAL_BIN/R"
ln -sf "$RDIR/bin/Rscript" "$LOCAL_BIN/Rscript"

# Clean-up
rm -rf "$RBUILD_DIR"
rm "$RDIR/R-${R_VERSION}.tar.gz"
unset RDIR RBUILD_DIR RSRC_DIR R_VERSION R_REPO LOCAL_BIN

echo "R installation complete. Binaries linked to ~/.local/bin"
