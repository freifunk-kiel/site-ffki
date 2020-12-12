Firmware Site Config for Freifunk Kiel
--------------------------------------

[![Build Status](https://travis-ci.org/freifunk-kiel/site-ffki.svg?branch=nightly)](https://travis-ci.org/freifunk-kiel/site-ffki)

The Freifunk next firmware is based on gluon branch `master`.

The autoupdater branch is set to `next`.

## debug

you can debug lua scripts in modules with 

    apt install luarocks
    luarocks install --local luacheck
    tests/validate_site.sh
    ~/.luarocks/bin/luacheck --config "tests/.luacheckrc" /tmp/site-validate/|grep "(E"
