# FFI import! void pinMode i32 i32
PinMode ← |2.0 # External!

# FFI import! void digitalWrite i32 i32
DigitalWrite ← |2.0 # External!

# FFI import! void delay u32
Delay ← |1.0 # External!

Blink ← Delay 1000 DigitalWrite 13 1 Delay 1000 DigitalWrite 13 0

# FFI export! void uiua_main
UiuaMain ← ≡(Blink◌)⇡ 10 PinMode 13 1
