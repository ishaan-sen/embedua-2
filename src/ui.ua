Serial ~ "serial.ua"
Servo ~ "servo.ua"

LeftServoPin  ← 10
RightServoPin ← 11

# Byte that separates packets in the serial stream
PacketSep ← 255

# FFI import! void delay u32
# ? Milliseconds
Delay ← |1.0 # External!

# Open both serial ports
OpenSerialPorts ← Serial!(∩⌟Begin S₀ S₁ BaudRate)

# Block until the given serial port is available
# ? Port
WaitForSerial ← ◌⍢(Delay 100 ∘|¬⊸Serial~Exists)

# LeftServoPtr RightServoPtr ?
CreateServos ← ∩Servo~Make LeftServoPin RightServoPin

# ? Byte ServoPtr
SetServo ← (
  +988×4
  ◌⊸Serial!(PrintInt S₀)
  ˜Servo~WriteMicroseconds
  Serial!(PrintStr "\n" S₀)
)

# LeftServoPtr RightServoPtr ? LeftServoPtr RightServoPtr
ProcessPacket ← (
  ∩⌟₀Serial!(Read S₁) # ? Byte₂ Byte₁
  Serial!(PrintStr "Received packet\n" S₀)
  # TODO: Subscripted by
  ⊃˜∩SetServo⋅⋅⊙∘
)

# FFI export! void setup
Setup ← (
  OpenSerialPorts

  # Wait for serial port 0
  # WaitForSerial Serial~S₀

  Serial!(PrintStr "Serial connected.\n" S₀)

  CreateServos

  ⍢(>2 Serial!(Available S₁)
    ◌⍢⊙(
      =PacketSep Serial!(Read S₁)
      ◌⍢⊙ProcessPacket⊙0
    )⊙0
  | 1)
  ⋅◌
)

# FFI export! void loop
Loop ← Delay 100
