Änderungen mit Firmwareversion 2016.2.4 basierend auf Gluon 2016.2.4
================================================================

Änderungen an Gluon 2016.2.4
----------------------------
 * Ein Problem mit batman-adv (compat 15) wurde behoben. Dieses führte dazu, dass Pakete einer bestimmten Größe nicht übertragen werden konnen (b7eeef9).
 Die Gluon Entwickler gehen davon aus, dass dies der Grund für hängende Autoupdateprozesse war.
 * Ein Problem beim kompilieren der Gluon Firmware wurde behoben (#1059).
 * Es wurde ein Fehler im Ladescript von respondd behoben, der zum einem Speicherüberlauf führte (9a0aeb9).
 * Die sysupgrade Files für x86 Systeme wurden repariert (41fd50d, ad37e2b).
 * Der Manifestgenerator erstellt nun Hashwerte mit dem SHA256 Algorithmus.

Probleme mit Gluon 2016.2.4
--------------------------------------
 * Beim Update von x86 Systemen kann es zum Verlust der Konfiguration kommen, wenn die Kernel Partition anwächst.
 * Wenn Mesh on WAN aktiviert ist, wird bei bestimmten Modellen die MAC Adresse des WAN Ports verändert. Dies kann in Umgebungen mit vorgeschalteten MAC Filterregeln zu Problemen führen.
 * Die TX Leistung der meisten Ubiquiti Geräte ist zu hoch eingestellt. Genaue Werte sind unbekannt. Es wird empfolen die Sendeleistung per Hand zu reduzieren.
 
 Offizielle Changelogs zum nachlesen:
------------------------------------

* https://gluon.readthedocs.io/en/latest/releases/v2016.2.4.html


Änderungen mit Firmwareversion 2016.2.3 basierend auf Gluon 2016.2.3
================================================================

Änderungen an Gluon 2016.2.3
----------------------------
 * respondd wird nun bei einem Fehler automatisch neu gestartet (#863)
 * autoupdater timeouts verändert, dies verhindert ein "hängen" des Autoupdaters beim Manifest-Download. Er wurde nun so verbessert, dass der wget Prozess jederzeit sicher beendet werden kann. (#987)
 * Änderung der WLAN-Länderkodierung wurde verbessert (#1001)
 
Mehr Routermodelle werden unterstützt
-------------------------------------

    ar71xx-generic
        TP-Link:    TL-WR940N v4, TL-WR1043ND v4
    ramips-rt305x
        Fonera:     20N

 Offizielle Changelogs zum nachlesen:
------------------------------------

* https://gluon.readthedocs.io/en/latest/releases/v2016.2.3.html

Änderungen mit Firmwareversion 2016.2.2 basierend auf Gluon 2016.2.2
================================================================

Änderungen an Gluon 2016.2.2
----------------------------
 * Bootprobleme auf mehreren QCA955x-basierenden Geräten behoben (z.B. OpenMesh OM5P AC v2) (#965)
 * Build-Prozess: Git Downloadprobleme von git.kernel.org auf Debian Wheezy behoben(#919)
 * Fix: RX Filter von Ubiquiti UAP Outdoor+ Geräten (d43147a8e03d)
 * Fix: vertauschtes WAN/LAN interface bei der CPE210 (59deb2064d54)
 * Deutliche Vverringerung der CPU Last durch die Steuerung der Signal LEDs (#897)
 * Fix: Netzwerk-Port des Ubiquiti UAP AC Lite (#911)
 * Build: /tmp Verzeichnis des Hosts wird nicht länger genutzt (f9072a36411b)
 * Fix: mesh interface type respondd/alfred announcements wenn VLANs über IBSS genutzt werden (#941)
 * Fix: next-node ebtables Regeln ohne next_node.ip4 (9dbe9f785d2b) 
 * x86-generic und x86-64 images haben nun PATA und MMC support.
 * Clean up opkg postinst scripts während der Imageerstellung.

Mehr Routermodelle werden unterstützt
-------------------------------------

    ar71xx-generic
        TP-Link:    CPE210/510 EU/US versions, TL-WA801N/ND v3, TL-WR841ND v11 EU/US versions 

Offizielle Changelogs zum nachlesen:
------------------------------------

* http://gluon.readthedocs.io/en/v2016.2.2/releases/v2016.2.2.html
