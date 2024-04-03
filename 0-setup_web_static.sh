#!/usr/bin/env bash
# Setup web servers for deployment of AirBnb_clone
if ! command -v nginx &>/dev/null; then
    sudo apt-get update
    sudo apt-get -y install nginx
fi
sudo mkdir -p /data/web_static/{releases/test,shared}
<<<<<<< HEAD
echo "<html><head></head><body>Dik lhdera dyal tberguigue rak 3lih nta o rbat</body></html>" | sudo tee /data/web_static/releases/test/index.html
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -R ubuntu:ubuntu /data/
sudo sed -i '/listen 80 default_server/a location /hbnb_static { alias /data/web_static/current/;}' /etc/nginx/sites-enabled/default
=======
echo "<html><head></head><body>Dik lhdera dyal tberguigue rak 3lih nta o rbat</body></html>" | sudo     tee /data/web_static/releases/test/index.html
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -R ubuntu:ubuntu /data/
sudo sed -i '/listen 80 default_server/a location /hbnb_static { alias /data/web_static/current/;}'     /etc/nginx/sites-enabled/default
>>>>>>> ceec4625cbf473231253c9a1909b77fb07372cd7
sudo service nginx restart
