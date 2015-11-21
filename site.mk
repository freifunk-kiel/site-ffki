GLUON_SITE_PACKAGES := \
	gluon-mesh-batman-adv-14 \
	gluon-alfred \
	gluon-announced \
	gluon-autoupdater \
	gluon-setup-mode \
	gluon-config-mode-core \
	gluon-config-mode-autoupdater \
	gluon-config-mode-hostname \
	gluon-config-mode-mesh-vpn \
	gluon-config-mode-geo-location \
	gluon-config-mode-contact-info \
	gluon-ebtables-filter-multicast \
	gluon-ebtables-filter-ra-dhcp \
	gluon-luci-admin \
	gluon-luci-autoupdater \
	gluon-luci-portconfig \
	gluon-luci-private-wifi \
	gluon-luci-wifi-config \
	gluon-next-node \
	gluon-mesh-vpn-fastd \
	gluon-radvd \
	gluon-status-page \
	iwinfo \
	iptables \
	haveged

ifeq ($(GLUON_TARGET),x86-generic)
# support the usb stack on x86 devices
# and add a few common USB NICs
GLUON_SITE_PACKAGES += \
	kmod-usb-core \
	kmod-usb2 \
	kmod-usb-hid \
	kmod-usb-net \
	kmod-usb-net-asix \
	kmod-usb-net-dm9601-ether
endif

#ar71xx-generic
GLUON_TLWR1043_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_TLWR842_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_TLWDR4300_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_TLWR2543_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_WRT160NL_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_DIR825B1_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_TLWR710_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_GLINET_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_WNDR3700_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_WZRHPG450H_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_WZRHPAG300H_SITE_PACKAGES := mod-usb-core kmod-usb2
GLUON_ARCHERC7_SITE_PACKAGES := mod-usb-core kmod-usb2

#mpc85xx-generic
GLUON_TLWDR4900_SITE_PACKAGES := mod-usb-core kmod-usb2

# not found: Netgear WNDR 4300

# if you build only one target use the generic versioning
# if you build several targets in one go, you have to set the version
#DEFAULT_GLUON_RELEASE := 0.8~exp$(shell date '+%y%m%d%H%M')
DEFAULT_GLUON_RELEASE := 0.8~exp201511212000

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

GLUON_PRIORITY ?= 0
GLUON_BRANCH ?= experimental
export GLUON_BRANCH

GLUON_TARGET ?= ar71xx-generic
export GLUON_TARGET

GLUON_LANGS ?= en de
