#include <Wire.h>
#include <Adafruit_MotorShield.h>

extern "C"
{
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
}