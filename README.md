Firmware Site Config for Freifunk Kiel
--------------------------------------

# Autoupdater sources

We are working with those autoupdater branches:

### stable
Built on the site-ffki branch `master` on gluon 2016.2.1

### release-candidate (rc)
Built on the site-ffki branch `master` too, but with BROKEN=1 on gluon 2016.2.1

### nightly (exp)
Build on the site-ffki branch `experimental` with BROKEN=1 on gluon 2016.2.x (or later on gluon branch master)

### 802.11s (11s)
Build on the site-ffki branch `802.11s` with BROKEN=1 and support for ralink Routers on gluon 2016.2.x

Gluon Dokumentation: https://gluon.readthedocs.io/en/latest/user/site.html

#Releases

Gluon versions used for specific Kieler Freifunk Firmware builds:

- 2016.2.1 - Gluon 2016.2.1
  - BugFixes
  - Kontaktfeld pflicht, mit Hinweis auf anonym betreiben 
- 2016.1.6 - Gluon 2016.1.6
  - USB-auto-mount um USB Speichermedien im Config mode freizugeben
- 2016.1.5.1 - Gluon 2016.1.5
	- Kontaktfeld pflicht
	- roamguide (initial inaktiv)
- 0.9    - Gluon v2016.1.5
    - temporäre Zwischenversion um den update Branch bei Routern mit 0.8 auf stable zu setzen
- 0.8.x    - Gluon v2015.2
- 0.7.1    - Gluon v2015.1.1 (5.7.2015)
- 0.7      - Gluon 2015.1 (22.5.2015)
- 0.6      - Gluon 2014.4 (30.3.2015)
- 0.5.2    - Gluon 2014.3.1
- 0.5      - Gluon 2014.3
- 0.4.1    - Gluon de223ceaf2fd0c9e7892dbaf6a12058fc3fc6269
- 0.4      - Gluon (24.4.2014) 5a4767b78fef2a6c8c9ffd76c69731b9d8b37557
- 0.3.2.1  - (02.04.2013)
- 0.3.100-exp (0.4 Beta 1): 2c751d3612a7229de878c40ae724611f2f4f0bee


Download der Firmware:
----------------------

- https://kiel.freifunk.net/firmware.html

Build
-----
You can easily create your own experimental firmware with the build script `make-release.sh`

Or build with these commands:

    sudo apt-get install git make gcc g++ unzip libncurses5-dev zlib1g-dev subversion gawk bzip2 libssl-dev
    git clone https://github.com/freifunk-gluon/gluon.git
    cd gluon
    git clone git@git.freifunk.in-kiel.de:ffki-site.git site
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
