# Tuxedo Driver DKMS for NP60

This bash script facilitates the installation of the "tuxedo-driver-dkms" package from the AUR, specifically tailored for Clevo NP60 laptops running arch linux, should also work on other new Clevo Laptops that aren't rebranded by Tuxedo.

The core functionality of this script is to ensure that the tuxedo-driver-dkms package can be installed and operated on Clevo NP60 laptops, as well as other newer Clevo models not explicitly supported by Tuxedo. The script achieves this by modifying the tuxedo_is_compatible function within the Tuxedo drivers' source code.

By default, the tuxedo_is_compatible function checks the system's hardware against a predefined list of supported devices. If the device is not recognized, the function returns false, preventing the driver from proceeding with the installation or operation.

This script intervenes by altering the source code of the tuxedo_is_compatible function so that it always returns true. 

## Usage
Need have wget installed.

To use the script, first make it executable and then run it:

```bash
chmod +x install.sh
./install.sh
```

During the execution, you will be prompted to enter the pkgver (package version) of the tuxedo-drivers. You can find the current version by visiting the [tuxedo-drivers-dkms](https://aur.archlinux.org/packages/tuxedo-drivers-dkms) package page on AUR. For example, if "tuxedo-drivers-dkms-4.3.2.tar.gz" is listed in the sources, the pkgver to use would be 4.3.2.
