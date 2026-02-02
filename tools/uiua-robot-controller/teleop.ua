~ "gh: uiua-lang/rayua"
  ~ BeginDrawing EndDrawing InitWindow WindowShouldClose
  ~ ClearBackground DrawText
  ~ GamepadAxis GamepadButton
  ~ GetGamepadAxisMovement IsGamepadAvailable
  ~ SetTargetFPS

GamepadID ← 0

InitWindow 500 500 "uiuabot"

SetTargetFPS 30

# &tcpc "192.168.4.1:23"
&udpb "0.0.0.0:8888"

⍢(BeginDrawing

  ClearBackground ⊚4

  GamepadAxis~RightTrigger
  °(-⊸¬) GetGamepadAxisMovement GamepadID
  ⌊⍜-× 254 100

  GamepadAxis~LeftTrigger
  °(-⊸¬) GetGamepadAxisMovement GamepadID
  ⌊⍜-× 254 0

  GamepadAxis!(LeftY RightX)
  ∩(GetGamepadAxisMovement GamepadID)

  ∩⌞÷↥1+◡∩⌵
  ⊃+-
  ∩(×>0.12⊸⌵
    °(-⊸¬)
    ⌊↥0↧⟜×254)

  ⊟₅255
  ⊸⊙(DrawText $"_"|95_220 30 ↯4 255)
  ⊸&udps ⊙"192.168.4.1:8888"

  EndDrawing
| ¬WindowShouldClose)

&cl
