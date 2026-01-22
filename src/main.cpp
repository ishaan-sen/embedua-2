/*

#include <Wire.h>
#include <Adafruit_MotorShield.h>

Adafruit_MotorShield *get_motor_driver(uint8_t address) // 0x60 default
{
    Adafruit_MotorShield *driver = new Adafruit_MotorShield(address);
    driver->begin();
    return driver;
}

Adafruit_DCMotor *get_dc_motor(Adafruit_MotorShield *driver, uint8_t port)
{
    return driver->getMotor(port);
}

void set_dc_speed(Adafruit_DCMotor *motor, uint8_t speed)
{
    motor->setSpeed(speed);
}

void run_dc_motor(Adafruit_DCMotor *motor, uint8_t command)
{
    motor->run(command);
}


void setup(void) {
    Adafruit_MotorShield *driver = get_motor_driver(0x60);
    Adafruit_DCMotor *motors[4];
    uint8_t dirs[] = {1, 2, 2, 2};
    for (int i = 0; i < 4; i++){
        motors[i] = get_dc_motor(driver, i+1);
        set_dc_speed(motors[i], 128);
        run_dc_motor(motors[i], dirs[i]);
    }
}

void loop(){}

*/
