Doku: https://gluon.readthedocs.org/en/v2015.1/user/site.html

Gluon versions used for specific Kieler Freifunk Firmware builds:

- 2016.1.2 - Gluon 2016.1.2
  - BugFixes
- 2016.1.5 - Gluon 2016.1.5
	- USB-auto-mount
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
You can easily create your own experimental build with these commands:

    sudo apt-get install git make gcc g++ unzip libncurses5-dev zlib1g-dev subversion gawk bzip2 libssl-dev
    git clone https://github.com/freifunk-gluon/gluon.git
    cd gluon
    git clone git@git.freifunk.in-kiel.de:ffki-site.git site
    make update
    D=$(date '+%y%m%d%H%M');
    for TARGET in ar71xx-generic ar71xx-nand mpc85xx-generic x86-generic x86-kvm_guest x86-64 x86-xen_domu; do
    	make GLUON_TARGET=$TARGET DEFAULT_GLUON_RELEASE=2016.1.5~exp$D BROKEN=1;
    done



