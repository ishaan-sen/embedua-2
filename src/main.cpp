#include <Arduino.h>
#include "uiua_string.hpp"
#include "uiua.h"

void setup()
{
    Serial.begin(115200);
    while (!Serial)
        ;
    char *s8 = "hello world";
    size_t utf32_len;
    uint32_t *s32 = utf8_to_utf32(s8, &utf32_len);
    char *s8_2 = utf32_to_utf8(s32, utf32_len);
    Serial.println(s8_2);
}

void loop()
{
    delay(100);
}