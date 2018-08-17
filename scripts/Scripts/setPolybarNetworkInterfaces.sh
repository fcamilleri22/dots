
DIR=$HOME/Scripts
CFG=$HOME/.config/polybar/config
WIFI=$($DIR/getWifiInterfaceName.sh)
WIRED=$($DIR/getWiredInterfaceName.sh)

sed -rz -i "s/interface = \w+/interface = $WIFI/1"  $CFG
sed -rz -i "s/interface = \w+/interface = $WIRED/2" $CFG
