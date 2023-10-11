import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)
ir_sensor_pin = 17

GPIO.setup(ir_sensor_pin, GPIO.IN)

try:
    while True:
        # Read the state of the IR sensor
        ir_state = GPIO.input(ir_sensor_pin)
        
        if ir_state == GPIO.LOW:
            print("Obstacle Detected!")
        else:
            print("No Obstacle")
        
        time.sleep(0.1)

except KeyboardInterrupt:
    GPIO.cleanup()
