# esp8266-evb-lua
<snippet>
  <content><![CDATA[
# ${1:Project Name}

The project goal is to create simple mqtt application for ESP8266-EVB board.
Project main feature is the controlling of the relay.

## Installation

1. Download [nodemcu-firmware](https://github.com/nodemcu/nodemcu-firmware)
   `git clone https://github.com/nodemcu/nodemcu-firmware.git`

2. cd nodemcu-firmware/
   
3. Flash the esp8266-evb
   `tools/esptool.py --port /dev/ttyUSB0 write_flash 0x00000 pre_build/0.9.5/nodemcu_20150213.bin`

4. Download Lua files.
   The project is implemented and tested with 
   [ESPlorer](http://esp8266.ru/esplorer/) IDE.
   The ESPlorer is intuitive IDE that provides facilities to download and 
   monitor the Lua code.

5. Restart esp8266-evb


## Usage

1. Install "mosquitto"

2. Switch ON the relay
   `mosquitto_pub -h <broker ip> -p <broker port> -m ON -t <topic> -u <username> -P <password>`

3. Switch OFF the relay
   `mosquitto_pub -h <broker ip> -p <broker port> -m OFF -t <topic> -u <username> -P <password>`

## History


## Credits


## License

BSD-3

]]></content>
  <tabTrigger>readme</tabTrigger>
</snippet>
