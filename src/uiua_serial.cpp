#include <Arduino.h>

Stream *serials[] = {&Serial, (Stream *)&Serial1};

extern "C" {
  void serial_begin(uint8_t selector, uint32_t baud_rate) {
    switch (selector) {
    case 0:
      Serial.begin(baud_rate);
      break;
    case 1:
      Serial1.begin(baud_rate);
      break;
    default:
      break;
    }
  }

  uint8_t serial_exists(uint8_t selector) {
    switch (selector) {
    case 0:
      return (bool)Serial;
      break;
    case 1:
      return (bool)Serial1;
      break;
    default:
      break;
    }
    return 0;
  }

  uint32_t serial_available(uint8_t selector){
    return serials[selector]->available();
  }

  size_t serial_write(uint8_t selector, char byte) {
    return serials[selector]->write(byte);
  }
  size_t serial_write_str(uint8_t selector, char *string) {
    return serials[selector]->write(string);
  }
  size_t serial_write_buffer(uint8_t selector, char *buffer, size_t len) {
    return serials[selector]->write(buffer, len);
  }
  size_t serial_print_int(uint8_t selector, int32_t value){
    return serials[selector]->print(value);
  }

  int serial_read(uint8_t selector) {
    return serials[selector]->read();
  }
  int32_t serial_read_int(uint8_t selector) {
    return serials[selector]->parseInt();
  }
  
}
