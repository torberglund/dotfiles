
sudo apt-get update
sudo apt-get install -y apt-transport-https
wget -qnc https://repo.nordvpn.com/gpg/nordvpn_public.asc -O - | sudo apt-key add -
echo "deb https://repo.nordvpn.com/deb/nordvpn/debian stable main" | sudo tee /etc/apt/sources.list.d/nordvpn.list
sudo apt-get update
sudo apt-get install -y nordvpn

sudo nordvpn set killswitch disable
sudo nordvpn set lan-discovery enable

nordvpn login      # opens browser to authenticate
# nordvpn connect    # connects to the best server
