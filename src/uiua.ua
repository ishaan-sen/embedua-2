# FFI import! u32 uiua_malloc u32
# Ptr ? Size
Malloc ← |1 # External!
# FFI import! void uiua_free u32
# ? Ptr
Free ← |1.0 # External!
# FFI import! void write_u32_ptr u32 u32
# ? Ptr Value
WriteUIntPtr ← |2.0 # External!
# FFI import! u32 utf32_to_utf8 u32 u32
# NewPtr ? DataPtr Len
ToUTF₈ ← |2 # External!

# FFI import! void delay u32
# ? Milliseconds
Delay ← |1.0 # External!

┌─╴Serial
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

  # FFI import! u8 serial_read u8
  # IncomingByte ? Port
  Read ← |1 # External!

  # FFI import! u32 serial_available u8
  # BytesAvailable ? Port
  Available ← |1 # External!

  # Ports
  S₀ ← 0
  S₁ ← 1
└─╴

# ? String
SerialPrint ← (
  Malloc ∩×₄⟜⇡⊸⧻
  ⟜(⊃≡WriteUIntPtr⧻+)
  Free⟜ToUTF₈
  Free⤙Serial!(WriteStr S₀)
  ◌
)

# FFI export! void setup
Setup ← SerialPrint "Hello, world!" ⍢(Delay 100|Serial!(¬ Exists S₀)) Serial!(Begin S₀) 115200

# FFI export! void loop
Loop ← Delay 100
