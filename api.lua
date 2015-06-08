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

local function set_relay(data)
    if(data == "ON")then
        gpio.write(1, gpio.HIGH);
    elseif(data == "OFF")then
        gpio.write(1, gpio.LOW);
    end
end

local function on_connect(conn)
    log("Connected to MQTT:" .. BROKER .. ":" .. BRPORT .." as " .. CLIENTID )
    -- subscribe topic with qos = 0
    m:subscribe(RELAY_TOPIC, 0, function(conn) print("subscribe success") end)
    tmr.wdclr()
    tmr.alarm(1, 1000, 0, 
        function()
            m:publish(SENSOR_TOPIC, 
                      "OFF", 
                      0, 
                      0, 
                      function(conn) end)    
        end)         
end


-- public functions 

function log(msg)
    if LOG_ENABLE == true then
        print(msg)
    end
end

function connect_brocker()
    log("Connecting to MQTT broker. Please wait...")
    m:connect( BROKER , BRPORT, 0, on_connect)
end

function connect_to_router(ssid, pass)
    wifi.sta.getip()
    wifi.setmode(wifi.STATION)
    tmr.delay(1000000)
    wifi.sta.config(ssid, pass)
    tmr.delay(5000000)
end

function on_message_received(conn, topic, command) 
    log(topic .. ":" .. command) 
    if command ~= nil then
        set_relay(command)
        m:publish(SENSOR_TOPIC,
                  command,
                  0,
                  0,
                  function(conn) end)
    end
    tmr.wdclr()         
end

function on_mqqt_offline(conn) 
    log("offline")
    tmr.wdclr()
    m:close()
    tmr.alarm(0, 1000, 0, connect_brocker)
end
