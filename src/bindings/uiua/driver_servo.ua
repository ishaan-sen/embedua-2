# FFI import! u32 get_driver u8
# DriverPtr ? I2CAddress
GetDriver ← |1 # External!

# FFI import! void set_pwm_frequency u32 u32
# ? DriverPtr Frequency
SetPWMFreq ← |2.0 # External!

# FFI import! void set_oscillator_frequency u32 u32
# ? DriverPtr Frequency
SetOscillatorFreq ← |2.0 # External!

# FFI import! void write_us u32 u8 u16
# ? DriverPtr ServoIndex Microseconds
WriteMicroseconds ← |3.0 # External!
