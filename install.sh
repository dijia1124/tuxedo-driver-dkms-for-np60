#!/bin/bash

# Set variables
pkgname="tuxedo-drivers"
pkgver="4.3.2"
aururl="https://aur.archlinux.org/cgit/aur.git/snapshot/${pkgname}-dkms.tar.gz"
srcurl="https://github.com/tuxedocomputers/tuxedo-drivers/archive/refs/tags/v${pkgver}.tar.gz"
workdir="$HOME/.cache/${pkgname}"
modfile="${workdir}/tuxedo-drivers-4.3.2/src/tuxedo_compatibility_check/tuxedo_compatibility_check.c" # Path to the file you want to modify, relative to src directory


# Prompt user to input pkgver
echo "Enter pkgver (e.g. 4.3.2):"
read pkgver

echo "pkgver given: $pkgver"
# Prepare work directory
mkdir -p "$workdir"
cd "$workdir"

# Download AUR PKGBUILD snapshot and source code
echo "Downloading AUR PKGBUILD snapshot and source code..."
wget -O "${pkgname}-dkms.tar.gz" "$aururl"
wget -O "${pkgname}-${pkgver}.tar.gz" "$srcurl"

# Extract them
tar -xzf "${pkgname}-dkms.tar.gz"
tar -xzf "${pkgname}-${pkgver}.tar.gz"

# Navigate to source directory
cd "${pkgname}-${pkgver}"
echo "Applying modifications..."
# Make modifications
cp "$modfile" "${modfile}.bak"
# Replace method body with 'awk'
awk '
/^bool tuxedo_is_compatible\(void\) \{/ {
    print "bool tuxedo_is_compatible(void) {\n    return true;\n}"
    inFunc = 1
    bracketCount = 1
    next
}
{
    if(inFunc) {
        if(/}/) {
            bracketCount--
        }
        if(/{/) {
            bracketCount++
        }
        if(bracketCount == 0) {
            inFunc = 0
        }
    } else {
        print
    }
}
' "${modfile}.bak" > "$modfile"

echo "Modification applied."

# Repackage the source
echo "Repackaging modified source..."
cd ..
pwd
tar -czvf "${pkgname}-${pkgver}.tar.gz" "${pkgname}-${pkgver}/"

# Update PKGBUILD
echo "Updating PKGBUILD..."
cd "${pkgname}-dkms"
sed -i "/^source=/c\source=(${pkgname}-${pkgver}.tar.gz tuxedo_io.conf dkms.conf)" PKGBUILD


# Update checksums
echo "Updating checksums..."
sha256sum=$(sha256sum "../${pkgname}-${pkgver}.tar.gz" | awk '{print $1}')
sha512sum=$(sha512sum "../${pkgname}-${pkgver}.tar.gz" | awk '{print $1}')
sed -i "0,/sha256sums=('\([^']*\)'/s//sha256sums=('$sha256sum'/" PKGBUILD
sed -i "0,/sha512sums=('\([^']*\)'/s//sha512sums=('$sha512sum'/" PKGBUILD

# Move to workdir
cd ..

# Move the modified package into package folder to be built
mv "${pkgname}-${pkgver}.tar.gz" "${pkgname}-dkms/"

cd ${pkgname}-dkms
# Build and install the package
echo "Building and installing the package..."
makepkg -si

echo "Cleanup..."
# Cleanup - Optional: Remove the work directory after installation
# rm -rf "$workdir"

echo "Done!"
