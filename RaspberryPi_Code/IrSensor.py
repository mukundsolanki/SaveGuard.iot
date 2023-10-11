import RPi.GPIO as GPIO
import time
from flask import Flask

app = Flask(__name__)

# Set the GPIO mode to BCM
GPIO.setmode(GPIO.BCM)
ir_sensor_pin = 17
GPIO.setup(ir_sensor_pin, GPIO.IN)

@app.route('/')
def status():
    ir_state = GPIO.input(ir_sensor_pin)
    if ir_state == GPIO.LOW:
        return "locked"
    else:
        return "unlocked"

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
    try:
        while True:
            time.sleep(0.1)
    except KeyboardInterrupt:
        GPIO.cleanup()
