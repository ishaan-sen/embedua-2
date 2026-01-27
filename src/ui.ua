# Experimental!

Serial ~ "serial.ua"
Servo ~ "native_servo.ua"
MotorDriver ~ "motor_driver.ua"

# I2C address, 0x60
ISCAddress ← 96

# TODO: Put actual values
# Front, back
LeftMotorPorts ← [1 2]
# Front, back
RightMotorPorts ← [3 4]

BaseServoPin ← 9
TipServoPin  ← 10

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

# BaseServoPtr TipServoPtr ?
CreateServos ← (
  ∩Servo~Make BaseServoPin TipServoPin
)

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
  Serial!(PrintStr "\n" S₀)
  MotorDriver!⊃↓(
    ˜SetDCSpeed⌵×2
  | ˜RunDCMotor+1<0)
)

ProcessPacket ← (
  ∩⌟₀Serial!(Read S₁) # Byte₂ Byte₁ ?
  Serial!(PrintStr "Received packet\n" S₀)
  ⊸₂˜∩≡SetMotor # ? Byte₂ Byte₁ LeftMotorPtr RightMotorPtr
  ⊙⊙(
    ∩⌟₀Serial!(Read S₁) # Byte₄ Byte₃ ?
    ∩(+992×4)
    ⊸₂˜∩˜Servo~WriteMicroseconds
  )
)

Loop ← (
  >4 Serial!(Available S₁)
  ◌⍢⊙(
    =PacketSep Serial!(Read S₁)
    ◌⍢⊙ProcessPacket⊙0
  )⊙0
)

# FFI export! void setup
Setup ← (
  OpenSerialPorts
  CreateServos
  CreateMotors
  ⍢Loop 1
  ⋅⋅⋅◌
)

# FFI export! void loop
DelayLoop ← Delay 100
