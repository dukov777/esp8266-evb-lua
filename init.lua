-- Configuration to connect to the MQTT broker.
BROKER = <string>    -- Ip/hostname of MQTT broker
BRPORT = <int>       -- MQTT broker port
BRUSER = <string>    -- If MQTT authenitcation is used then define the user
BRPWD  = <string>    -- The above user password
CLIENTID = "ESP8266-" ..  node.chipid() -- The MQTT ID. Change to something you like

SENSOR_TOPIC = <string>   -- Publish topic
RELAY_TOPIC = <string>    -- Subscribe topic

-- Example
-- BROKER = "m20.cloudmqtt.com"   -- Ip/hostname of MQTT broker
-- BRPORT = 17501                 -- MQTT broker port
-- BRUSER = "the-best"            -- If MQTT authenitcation is used then define the user
-- BRPWD  = ":-)"                 -- The above user password
-- SENSOR_TOPIC = "esp-evb/sensor/1"
-- RELAY_TOPIC = "esp-evb/relay/1"

-- Router setings
SSID = "router name"
PASS = "router password"

LOG_ENABLE = true    -- enable loging to UART channel 

dofile("api.lua")
tmr.alarm(0, 5000, 0, function() dofile("relay_control.lua") end )

