sudo apt-get update
sudo apt-get upgrade -y
sudo apt install git -y

## docker install
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker pi

## install docker-compose
sudo apt-get install libffi-dev libssl-dev -y
sudo apt install python3-dev -y
sudo apt-get install python3 python3-pip -y

##reboot
sudo python3 -m pip install docker-compose

sudo systemctl enable docker


##setting static ip
IFS=' ' read -r -a array <<< $(ip r | grep "default via")
DNS_IP=$(grep "nameserver" /etc/resolv.conf  | sed 's/^.* //' | head -1)

sudo cat << EOF > /etc/dhcpcd.conf
# A sample configuration for dhcpcd.
# See dhcpcd.conf(5) for details.

# Allow users of this group to interact with dhcpcd via the control socket.
#controlgroup wheel

# Inform the DHCP server of our hostname for DDNS.
hostname

# Use the hardware address of the interface for the Client ID.
clientid
# or
# Use the same DUID + IAID as set in DHCPv6 for DHCPv4 ClientID as per RFC43>
# Some non-RFC compliant DHCP servers do not reply with this set.
# In this case, comment out duid and enable clientid above.
#duid

# Persist interface configuration when dhcpcd exits.
persistent

# Rapid commit support.
# Safe to enable by default because it requires the equivalent option set
# on the server to actually work.
option rapid_commit

# A list of options to request from the DHCP server.
option domain_name_servers, domain_name, domain_search, host_name
option classless_static_routes
# Respect the network MTU. This is applied to DHCP routes.
option interface_mtu

# Most distributions have NTP support.
#option ntp_servers

# A ServerID is required by RFC2131.
require dhcp_server_identifier

# Generate SLAAC address using the Hardware Address of the interface
#slaac hwaddr
# OR generate Stable Private IPv6 Addresses based from the DUID
slaac private
interface eth0
static routers=${array[2]}
static domain_name_servers=$DNS_IP
static ip_address=192.168.1.90/24
EOF

sudo reboot
