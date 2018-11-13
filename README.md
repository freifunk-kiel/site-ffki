Firmware Site Config for Freifunk Cuxhaven
------------------------------------------

Download der Firmware:
----------------------

- https://www.freifunk-cuxhaven.de/category/router

Build
-----
You can easily create your own experimental firmware with the build script `make-release.sh`

Or build with these commands:

    sudo apt-get install git make gcc g++ unzip libncurses5-dev zlib1g-dev subversion gawk bzip2 libssl-dev
    git clone https://github.com/freifunk-gluon/gluon.git
    cd gluon
    git clone https://github.com/Freifunk-Cuxhaven/site-ffcux site
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
