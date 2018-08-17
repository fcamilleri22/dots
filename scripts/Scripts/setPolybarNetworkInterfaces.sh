
DIR=$HOME/Scripts
CFG=$HOME/.config/polybar/config
WIFI=$($DIR/getWifiInterfaceName.sh)
WIRED=$($DIR/getWiredInterfaceName.sh)

[ "$WIFI" ] && \
    sed -rz -i "s/interface = \w+/interface = $WIFI/1"  $CFG

[ "$WIRED" ] && \
    sed -rz -i "s/interface = \w+/interface = $WIRED/2" $CFG
