#ifndef UTF_CONVERTER_H
#define UTF_CONVERTER_H

#include <stdint.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C"
{
#endif
    char *utf32_to_utf8(uint32_t *utf32_string, size_t utf32_length);

    uint32_t *utf8_to_utf32(const char *utf8_string, size_t *utf32_length);

    void print_utf32(uint32_t *utf32_string, size_t utf32_length);

    void *uiua_malloc(uint64_t size);

    void uiua_free(void *ptr);

    void write_u32_ptr(uint32_t *ptr, uint32_t num);

#ifdef __cplusplus
}
#endif

#endif