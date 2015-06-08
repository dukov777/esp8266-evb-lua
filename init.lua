--[[ 
Copyright (c) 2015, Petar Lalov
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of esp8266-evb-lua nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]--

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

