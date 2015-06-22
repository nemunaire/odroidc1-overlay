Odroid-C1 Gentoo Overlay
========================

This overlay includes ebuilds for the following packages:

* `app-misc/odroidc1-remote`: Odroid C1 remote control setup (https://github.com/mdrjr/c1_irremote)
* `dev-embedded/u-boot-tools-odroidc1`: Odroid C1 U-Boot (https://github.com/hardkernel/u-boot)
* `media-libs/aml-odroidc1`: Odroid C1 Amlogic Libraries (https://github.com/mdrjr/c1_aml_libs)
* `sys-kernel/odroidc1-sources`: Linux source for Odroid devices (https://github.com/hardkernel/linux)
* `x11-drivers/xf86-video-odroidc1`: Xorg DDX driver for Odroid-C1 (https://github.com/mdrjr/c1_mali_ddx)
* `x11-libs/odroidc1-mali`: Closed source drivers for Mali (https://github.com/mdrjr/c1_mali_libs)

Usage with Layman
-----------------

```
$ wget "https://raw.githubusercontent.com/nemunaire/odroidc1-overlay/master/overlays.xml" -O /etc/layman/overlays/odroidc1.xml
$ layman -f -a odroidc1
```

Usage with Portage
------------------

```
mkdir /usr/local/portage
git clone git://github.com:nemunaire/odroidc1-overlay.git /usr/local/portage
echo 'PORTDIR_OVERLAY="${PORTDIR_OVERLAY} /usr/local/portage/"' >> /etc/portage/make.conf
```
