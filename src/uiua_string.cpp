#include <Arduino.h>
#include <stdlib.h>
#include <stdint.h>

extern "C"
{
  char *utf32_to_utf8(uint32_t *utf32_string, size_t utf32_length)
  {
    char *utf8_string = (char *)malloc(utf32_length * sizeof(uint32_t) + sizeof(char));
    size_t utf8_len = 0;
    for (size_t i = 0; i < utf32_length; i++)
    {
      if (utf32_string[i] < 0x00000080)
      {
        utf8_string[utf8_len] = (char)utf32_string[i];
        utf8_len++;
      }
      else if (utf32_string[i] < 0x00000800)
      {
        utf8_string[utf8_len] = 0xC0 | (utf32_string[i] >> 6);
        utf8_string[utf8_len + 1] = 0x80 | (utf32_string[i] & 0x3F);
        utf8_len += 2;
      }
      else if (utf32_string[i] < 0x00010000)
      {
        utf8_string[utf8_len] = 0xE0 | (utf32_string[i] >> 12);
        utf8_string[utf8_len + 1] = 0x80 | ((utf32_string[i] >> 6) & 0x3F);
        utf8_string[utf8_len + 2] = 0x80 | (utf32_string[i] & 0x3F);
        utf8_len += 3;
      }
      else if (utf32_string[i] < 0x00110000)
      {
        utf8_string[utf8_len] = 0xF0 | (utf32_string[i] >> 18);
        utf8_string[utf8_len + 1] = 0x80 | ((utf32_string[i] >> 12) & 0x3F);
        utf8_string[utf8_len + 2] = 0x80 | ((utf32_string[i] >> 6) & 0x3F);
        utf8_string[utf8_len + 3] = 0x80 | (utf32_string[i] & 0x3F);
        utf8_len += 4;
      }
    }
    utf8_string[utf8_len] = '\0';
    return utf8_string;
  }

  void print_utf32(uint32_t *utf32_string, size_t utf32_length)
  {
    char *utf8_string = utf32_to_utf8(utf32_string, utf32_length);
    Serial.println(utf8_string);
  }

  void *uiua_malloc(uint64_t size)
  {
    return malloc(size);
  }

  void uiua_free(void *ptr)
  {
    free(ptr);
  }

  void write_u32_ptr(uint32_t *ptr, uint32_t num)
  {
    *ptr = num;
  }

  uint32_t *utf8_to_utf32(const char *utf8_string, size_t *utf32_length)
  {
    size_t utf8_len = strlen(utf8_string);
    uint32_t *utf32_string = (uint32_t *)malloc((utf8_len + 1) * sizeof(uint32_t));
    size_t utf32_idx = 0;
    size_t i = 0;

    while (i < utf8_len)
    {
      uint32_t codepoint = 0;
      uint8_t byte = (uint8_t)utf8_string[i];

      if (byte < 0x80)
      {
        codepoint = byte;
        i++;
      }
      else if ((byte & 0xE0) == 0xC0)
      {
        codepoint = (byte & 0x1F) << 6;
        codepoint |= (utf8_string[i + 1] & 0x3F);
        i += 2;
      }
      else if ((byte & 0xF0) == 0xE0)
      {
        codepoint = (byte & 0x0F) << 12;
        codepoint |= (utf8_string[i + 1] & 0x3F) << 6;
        codepoint |= (utf8_string[i + 2] & 0x3F);
        i += 3;
      }
      else if ((byte & 0xF8) == 0xF0)
      {
        codepoint = (byte & 0x07) << 18;
        codepoint |= (utf8_string[i + 1] & 0x3F) << 12;
        codepoint |= (utf8_string[i + 2] & 0x3F) << 6;
        codepoint |= (utf8_string[i + 3] & 0x3F);
        i += 4;
      }
      else
      {
        i++;
        continue;
      }

      utf32_string[utf32_idx] = codepoint;
      utf32_idx++;
    }

    utf32_string[utf32_idx] = 0;
    *utf32_length = utf32_idx;
    return utf32_string;
  }
}