#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

extern "C"
{
    Adafruit_PWMServoDriver *get_driver(uint8_t address) // 0x40 default
    {
        Adafruit_PWMServoDriver *driver = new Adafruit_PWMServoDriver(address);
        return driver;
    }
    void set_pwm_frequency(Adafruit_PWMServoDriver *driver, uint32_t max_freq)
    {
        driver->setPWMFreq(max_freq);
    }    
    void set_oscillator_frequency(Adafruit_PWMServoDriver *driver, uint32_t freq)
    {
        driver->setOscillatorFrequency(freq); // should be 27000000
    }
    void write_us(Adafruit_PWMServoDriver *driver, uint8_t servo_inx, uint16_t microseconds)
    {
        driver->writeMicroseconds(servo_inx, microseconds);
    }
}

