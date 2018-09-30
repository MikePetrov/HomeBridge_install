#!/bin/bash
set -o nounset
set -o errexit

Color_Off='\033[0m'
Color_Red='\033[0;31m'
Color_Green='\033[0;32m'
Color_Blue='\033[0;34m'
Color_Cyan='\033[0;36m'

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
sudo apt install -y libavahi-compat-libdnssd-dev mc xz-utils

ver=$(node -v)
echo -e "Current Node version is ${Color_Cyan}$(Ver)${Color_Off}"
# устанавливаем NodeJs-current (актуальная сейчас)
cd ~
wget https://nodejs.org/dist/v10.11.0/node-v10.11.0-linux-armv6l.tar.xz
tar -xvJf ~/node-v10.11.0-linux-armv6l.tar.xz
ver=$(~/node-v10.11.0-linux-armv6l/bin/node -v)
echo -e "${Color_Green}Unpacking version: $ver ${Color_Off}"
cd ~/node-v10.11.0-linux-armv6l
sudo cp -R * /usr/local/
export PATH=$PATH:/usr/local/bin
ver=$(node -v)
echo -e "${Color_Green}System version NodeJS: $ver ${Color_Off}"
ver=$(npm -v)
echo -e "${Color_Green}System version NPM: $ver ${Color_Off}"

# копирование файлов конфигурации 
mkdir -p ~/.homebridge
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

# confirm version
echo -e "${Color_Green}Successfully installed. HomeBridge version is: $Ver${Color_Off}"
