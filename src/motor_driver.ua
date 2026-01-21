# FFI import! u32 get_motor_driver u8
# DriverPtr ? I2CAddress
GetMotorDriver ← |1 # External!

# FFI import! u32 get_dc_motor u32 u8
# DCMotorPtr ? DriverPtr Port
GetDCMotor ← |2 # External!

# FFI import! void set_dc_speed u32 u8
# ? DCMotorPtr Speed
SetDCSpeed ← |2.0 # External!

# FFI import! void run_dc_motor u32 u8
# ? DCMotorPtr Command
RunDCMotor ← |2.0 # External!

FORWARD ← 1
BACKWARD ← 2
BRAKE ← 3
IDLE ← 4
