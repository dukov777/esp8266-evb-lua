import unittest
import paho.mqtt.client as mqtt, urlparse
import Queue, os

class TestReliability(unittest.TestCase):

    def test_sub(self):
        actuator_topic = os.environ.get('MQTT_RELAY', 'mqtt/relay/1')
        sensor_topic = os.environ.get('MQTT_SENSOR', 'mqtt/sensor/1')

        def on_connect(mosq, obj, rc):
            mosq.subscribe(sensor_topic, 2)
        
        def on_message(mosq, obj, msg):
            obj.put(str(msg.payload))
                
        def on_subscribe(mosq, obj, mid, granted_qos):
            res = mosq.publish(actuator_topic, "ON", qos=2)
            self.assertEqual(res[0], 0, "unable to publish")
        
        message = Queue.Queue()
        mqttc = mqtt.Client(userdata=message)

        # Assign event callbacks
        mqttc.on_message = on_message
        mqttc.on_connect = on_connect
        mqttc.on_subscribe = on_subscribe

        url_str = os.environ.get('CLOUDMQTT_URL', 'mqtt://localhost:1883')
        url = urlparse.urlparse(url_str)
        if url.username and url.password:
            mqttc.username_pw_set(url.username, url.password)

        mqttc.connect(url.hostname, url.port)
        mqttc.loop_start()
        
        try:
            msg = message.get(True, 20)
            self.assertEqual(msg, "ON", "Wrong message!")
        except Queue.Empty:
            self.fail("Message is not received")

        mqttc.loop_stop()
        

if __name__ == '__main__':
    unittest.main()
