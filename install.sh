#!/bin/bash

# смена hostname на HomeBridge
oldname=$(cat /etc/hostname)
sudo sed -i "s/$oldname/HomeBridge/g" /etc/hosts
sudo sed -i "s/$oldname/HomeBridge/g" /etc/hostname


# отключение swap файла
sudo dphys-swapfile swapoff
sudo dphys-swapfile uninstall
sudo update-rc.d dphys-swapfile remove

# удаление не нужных пакетов
sudo apt autoremove --purge

# установка не достающих пакетов
sudo apt install -y libavahi-compat-libdnssd-dev mc

# устанавливаем NodeJs-current (актуальная сейчас)
cd ~
wget https://nodejs.org/dist/v10.11.0/node-v10.11.0-linux-armv6l.tar.xz
tar -xzf node-v10.11.0-linux-armv6l
node-v10.11.0-linux-armv6l/bin/node -v
cd node-v10.11.0-linux-armv6l
sudo cp -R * /usr/local/
export PATH=$PATH:/usr/local/bin
node -v
npm -v

# копирование файлов конфигурации 
mkdir ~/.homebridge
wget -P ~/.homebridge https://mikepetrov.github.io/HomeBridge_install/default_config.json
mv ~/.homebridge/default_config.json ~/.homebridge/config.json
sudo wget -P /etc/systemd/system/ https://mikepetrov.github.io/HomeBridge_install/homebridge.service 

# установка HomeBridge и Web Interface
sudo npm i -g --unsafe-perm homebridge homebridge-config-ui-x
# установка модулей home bridge (не нужное коментируем, здесь и в файле example.config.json)
## ip камеры
sudo npm i -g --unsafe-perm homebridge-camera-ffmpeg
## 
## 

# запуск в качестве демона
sudo systemctl daemon-reload
sudo systemctl enable homebridge
sudo systemctl start homebridge

# перезагрузка
sudo shutdown -r
