# Experimental!

QueryModel ← (
  ⊸⧻
  "127.0.0.1:11434"
  "/api/chat"

  $$ POST _ HTTP/1.1
  $$ Host: _
  $$ Content-Type: application/json
  $$ Content-Length: _
  $$ Connection: close
  $$ 
  $$ _
  $$
  ⍜⊏(≡⊂@\r)⊚⊸=@\n
  ⍜(&tcpc "127.0.0.1:11434"|&rs∞˜⊸&w)
  ⊜□ ⊸≠@{
  ↘1
  ≡⍜(°□|⊂@{)
  /◇⊂
  # &p
  °json
  ◇get "message"
  ◇get"content"
  °□
)

EncodeImage ← (
  img "jpeg"
  &runs "base64"
  ⟜∪⌟˜&w⊙∘
  &cl
  ⤙&rb ∞
  ⊙&cl&cl
  +@\0
)

Control ← map {"CENTER" "LEFT" "RIGHT"} {[255 127 127 254 254] [255 100 100 254 254] [255 154 154 254 254]}
S       ← &udpb "0.0.0.0:8888"

# NewImage ? LineWidth Image
AddLines ← ⍜⊙⤸₁⊙(×≥|/↧⌵⊞-×÷⟜⇡3⟜⇡⊸⧻)
Overlay  ← ⍜°⍉⊂ ↧⊸↥0 ⤚÷⊃(-∪⊃×+|+⊃×(×∪×¬)) ∩⍜(⇌°⍉)°⊂

# NewImage ? Image
AddText ← (
  ⤸₁⇌⬚1⍜°⍉↙₄
  {"LEFT" "CENTER" "RIGHT"}
  ⍚(⤸₁⇌⌝↘¯⟜⌝↘ 10_10 layout!(°⊸Color Red) 40)
  °⊏⊙(÷₃⊸⧻)
  ∧◇(⌝↘⌊+⊃(÷2-⋅⧻)∪⌟×∘
     Overlay⬚0↙◡⋅△₂)
  ⇌⤸₁
)

ImageProcess ← AddText AddLines 5

ConstructQuery ← (
  Content ← "You are an image recognition model specializing in object detection and localization. This image is divided into three sections with vertical bars. Which one contains the person? Reply with exactly one word: 'LEFT', 'RIGHT', or 'CENTER'."
  Images ← {EncodeImage ⊸&ims ImageProcess ▽₂0.5 &camcap 0}
  Messages ← {map {"role" "content" "images"}{"user" Content Images}}
  map{"model" "messages" "stream"} {"llama3.2-vision:90b" Messages False}
  json
)

RunModel ← (
  ⍥(&sl 0.1 ◌ &camcap 0)3
  ConstructQuery
  QueryModel
  ▽⊸±⌵
  ⊸&p
  Control
  °□ ˜get
)

# ⍥(RunModel) 5
⍥(&udps ⊸&p RunModel "192.168.4.1:8888" S) 5
