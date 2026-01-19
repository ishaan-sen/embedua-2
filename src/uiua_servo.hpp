#include <Arduino.h>
#include <Servo.h>

extern "C"
{
    void *make_servo(int pin);
    void write_us(void *servo, int value);
}