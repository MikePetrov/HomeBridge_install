
# HomeBridge_install

    wget -O - https://mikepetrov.github.io/HomeBridge_install/install.sh | bash
    
***Автоматизация развертывания <a href="https://github.com/nfarina/homebridge">'HomeBridge'</a> являющегося мостом между датчиками куплеными на AlliExpress и устройствами на платформе Apple IOS***

* Меняем имя хоста на HomeBridge
* Отключаем SWAP, для продления жизни флешки
* удаляем не мусор и не используемые пакеты
* Устанавливаем NodeJS (из актуальной ветки на сегодняшний день)
* Устанавливаем не достающие пакеты `nodejs` и `libavahi-compat-libdnssd-dev`
* Создаем папку `.homebridge` в домашнем каталоге текущего пользователя
* Копируем туда файл конфигурации с данными для запуска веб-морды
* Устанавливаем сам `homebridge` и веб-морду `homebridge-config-ui-x`
* Устанавливаем дополнительные модули
* Создаем `homebridge.service` и запускаем его

Если лень изобретать велосипед(писать свои модули), 
то его можно поискать в репозитории: <a href="https://www.npmjs.com/search?q=homebridge">'npmjs'</a>

доступ к веб-морде homebridge по адресу http://local.ip.homebridge:8080.
