Firmware Site Config for Freifunk Kiel
--------------------------------------

The Freifunk next firmware is based on gluon branch `2020.2.x`.

The autoupdater branch is set to `next`.

## debug

you can debug lua scripts in modules with 

    apt install luarocks
    luarocks install --local luacheck
    tests/validate_site.sh
    ~/.luarocks/bin/luacheck --config "tests/.luacheckrc" /tmp/site-validate/|grep "(E"
