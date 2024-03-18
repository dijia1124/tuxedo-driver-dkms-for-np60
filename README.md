# Tuxedo Driver DKMS for NP60

This bash script facilitates the installation of the "tuxedo-driver-dkms" package from the AUR, specifically tailored for Clevo NP60 laptops running arch linux, should also work on other new Clevo Laptops that aren't rebranded by Tuxedo.

## Usage
Need have wget installed.

To use the script, first make it executable and then run it:

```bash
chmod +x install.sh
./install.sh
```

During the execution, you will be prompted to enter the pkgver (package version) of the tuxedo-drivers. You can find the current version by visiting the [tuxedo-drivers-dkms](https://aur.archlinux.org/packages/tuxedo-drivers-dkms) package page on AUR. For example, if "tuxedo-drivers-dkms-4.3.2.tar.gz" is listed in the sources, the pkgver to use would be 4.3.2.
