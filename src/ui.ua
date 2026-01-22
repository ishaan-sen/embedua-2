# Experimental!

Serial ~ "serial.ua"
MotorDriver ~ "motor_driver.ua"

# I2C address, 0x60
ISCAddress ← 96

# TODO: Put actual values
# Front, back
LeftMotorPorts ← [1 2]
# Front, back
RightMotorPorts ← [3 4]

# Byte that separates packets in the serial stream
PacketSep ← 255

# FFI import! void delay u32
# ? Milliseconds
Delay ← |1.0 # External!

# Open both serial ports
OpenSerialPorts ← Serial!(∩⌟Begin S₀ S₁ BaudRate)

# Block until the given serial port is available
# TODO: Fix compiler bug that requires ∘ in loop
# ? Port
WaitForSerial ← ◌⍢(Delay 100 ∘|¬⊸Serial~Exists)

# LeftDCMotorPtrs RightDCMotorPtrs ?
CreateMotors ← (
  MotorDriver~GetMotorDriver ISCAddress # DriverPtr ?
  ⊙⊓LeftMotorPorts RightMotorPorts
  ∩⌞≡MotorDriver~GetDCMotor
)

# ? Byte DCMotorPtr
SetMotor ← (
  -127                   # SpeedVal ? Byte
  ◌⊸Serial!(PrintInt S₀) # SpeedVal ? SpeedVal
  MotorDriver!⊃↓(
    ˜SetDCSpeed⌵
  | ˜RunDCMotor+1<0)
)

ProcessPacket ← (
  ∩⌟₀Serial!(Read S₁) # Byte₂ Byte₁ ?
  Serial!(PrintStr "Received packet\n" S₀)
  ⊸₂˜∩≡SetMotor # ? Byte₂ Byte₁ LeftMotorPtr RightMotorPtr
)

Loop ← (
  >2 Serial!(Available S₁)
  ◌⍢⊙(
    =PacketSep Serial!(Read S₁)
    ◌⍢⊙ProcessPacket⊙0
  )⊙0
)

# FFI export! void setup
Setup ← (
  OpenSerialPorts
  CreateMotors
  ⍢Loop 1
  ⋅◌
)

# FFI export! void loop
DelayLoop ← Delay 100
