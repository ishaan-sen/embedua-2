#include <Arduino.h>
#include <Servo.h>

extern "C"
{
    void *make_servo(int pin)
    {
        Servo *servo = new Servo;
        servo->attach(pin);
        return servo;
    }
    void write_us(Servo *servo, int value)
    {
        servo->writeMicroseconds(value);
    }
}