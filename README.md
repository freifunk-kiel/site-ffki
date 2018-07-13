Firmware Site Config for Freifunk Kiel
--------------------------------------

The Freifunk alt-esc firmware is based on our nightly but in a fork from T-X at
https://github.com/T-X/gluon.git (BRANCH: pr-gluon-alt-esc which is based on 
gluon branch v2018.1.x). The autoupdater branch is `alt-esc`.

You can always find
the latest gluon documentation at:
https://gluon.readthedocs.io/en/latest/user/site.html

# Autoupdater Sources

We are working with those autoupdater branches:

## nightly
Build on the site-ffki branch `nightly`, probably with BROKEN=1.
These builds are created automatically and will possibly break your devices
without prior notice. Use only if you know what you are doing.

## release-candidate (rc)
Built on the site-ffki branch `release-candidate`. These builds are initiated manually
and should be more or less stable. However they are still in testing for a
reason. Use this if you want to offer your devices as test-platforms for the
upcoming stable releases.

## stable
Not built directly but instead release-candidates are "promoted" to stable
after they have been thoroughly tested.


# Firmware Download

You can always find the current release at https://freifunk.in-kiel.de/firmware.html

# Development

## Validation

You can validate your changes to this repository by calling the validate_site.sh file with

    tests/validate_site.sh

## General process

- Usually no commits should affect `release-candidate` directly.
- Development for new firmwares takes place in the `nightly` branch.
- Buildbot creates new firmwares from `nightly` as needed.
- Release for new firmware is prepared through pull request from `nightly` to `release-candidate`
- After consensus over pull request, new `release-candidate` is manually built in Gitlab.
- Initial signature by developer allows update of `rc` nodes.
- After testing, `rc` is promoted to stable and signed by developers.

## Releases

These Kieler Freifunk firmwares have been released:

- 2016.2.7
  - Based on Gluon 2016.2.7
- 2016.2.6.2
  - Based on Gluon 2016.2.6
  - Deactivated legacy ibss meshing protocol
- 2016.2.6.1
  - Based on Gluon 2016.2.6
  - Activated 11s meshing protocol as well as old ibss meshing protocol
  - Eulenfunk Quickfix reboots broken nodes
- 2016.2.5
  - Based on Gluon 2016.2.5
  - Included acceptance of PPA in config mode
  - Included option to register for "Knotenalarm" in config mode
- 2016.2.1
  - Based on Gluon 2016.2.1
  - Contact information has information about anonymous option (one space)
  - Various bugfixes
- 2016.1.6
  - Based on Gluon 2016.1.6
  - USB-auto-mount for sharing attached USB memory devices (configuration in config-mode)
- 2016.1.5.1
  - Based on Gluon 2016.1.5
  - Contact information mandatory
  - roamguide added but initially deactivated
- 0.9
  - Based on Gluon v2016.1.5
  - intermediate version to change auto updater branch of old experimental routers to stable
- 0.8.x (experimental)
  - Based on Gluon v2015.2
- 0.7.1
  - Based on Gluon v2015.1.1 (5.7.2015)
- 0.7
  - Based on Gluon 2015.1 (22.5.2015)
- 0.6
  - Based on Gluon 2014.4 (30.3.2015)
- 0.5.2
  - Based on Gluon 2014.3.1
- 0.5
  - Based on Gluon 2014.3
- 0.4.1
  - Based on Gluon reference de223ceaf2fd0c9e7892dbaf6a12058fc3fc6269
- 0.4
  - Based on Gluon reference 5a4767b78fef2a6c8c9ffd76c69731b9d8b37557
- 0.3.2.1
  - Based on Gluon version from 2013-04-02
- 0.3.100-exp
  - Based on Gluon reference 2c751d3612a7229de878c40ae724611f2f4f0bee

## Building

You can easily create your own experimental firmware with the build script `make-release.sh`

Or build with these commands:

    sudo apt-get install git make gcc g++ unzip libncurses5-dev zlib1g-dev subversion gawk bzip2 libssl-dev
    git clone https://github.com/freifunk-gluon/gluon.git
    cd gluon
    git clone https://github.com/freifunk-kiel/ffki-site.git site
    make update
    D=$(date '+%y%m%d%H%M');
    ONLY_11S="ramips-rt305x ramips-mt7621"
    BANANAPI="sunxi"
    RASPBPI="brcm2708-bcm2708 brcm2708-bcm2709"
    X86="x86-64 x86-generic x86-kvm_guest x86-xen_domu"
    WDR4900="mpc85xx-generic"
    for TARGET in ar71xx-generic ar71xx-mikrotik ar71xx-nand $WDR4900 $RASPBPI $BANANAPI $X86; do
    	make GLUON_TARGET=$TARGET DEFAULT_GLUON_RELEASE=2016.2.1~exp$D BROKEN=1;
    done
