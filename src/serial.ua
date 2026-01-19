# FFI import! void serial_begin u8 u32
# ? Port Rate
Begin ← |2.0 # External!

# FFI import! bool serial_exists u8
# PortExists ? Port
Exists ← |1 # External!

# FFI import! u32 serial_write_buffer u8 u32 u32
# AmountWritten ? Port DataPtr Len
WriteBuffer ← |3 # External!

# FFI import! u32 serial_write_str u8 u32
# AmountWritten ? Port DataPtr
WriteStr ← |2 # External!

# FFI import! u32 serial_write u8 u8
# AmountWritten ? Port Byte
Write ← |2 # External!

# FFI import! u32 serial_print_int u8 i32
# AmountWritten ? Port Value
PrintInt ← |2 # External!

# FFI import! i32 serial_read u8
# IncomingByte ? Port
Read ← |1 # External!

# FFI import! i32 serial_read_int u8
# IncomingInt ? Port
ReadInt ← |1 # External!

# FFI import! u32 serial_available u8
# BytesAvailable ? Port
Available ← |1 # External!

# Ports
S₀ ← 0
S₁ ← 1
