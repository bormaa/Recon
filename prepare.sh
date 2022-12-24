sudo apt-get install golang-go -y
go env -w GO111MODULE=off
wget https://github.com/tomnomnom/assetfinder/releases/download/v0.1.1/assetfinder-linux-amd64-0.1.1.tgz
tar -xvf assetfinder-linux-amd64-0.1.1.tgz
chmod +x assetfinder
sudo snap install amass
pip3 install bs4 requests
cd ~
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r
sudo pip install -r requirements.txt
wget https://github.com/tomnomnom/httprobe/releases/download/v0.2/httprobe-linux-amd64-0.2.tgz
tar -xvf httprobe-linux-amd64-0.2.tgz
