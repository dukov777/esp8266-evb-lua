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
