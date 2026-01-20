#include <Arduino.h>
#include <Servo.h>

extern "C"
{
    void *native_make_servo(int pin)
    {
        Servo *servo = new Servo;
        servo->attach(pin);
        return servo;
    }
    void native_write_us(Servo *servo, int value)
    {
        servo->writeMicroseconds(value);
    }
}