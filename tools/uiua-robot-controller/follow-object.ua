# Experimental!
~ "gh: Omnikar/uiua-math" ~ Median
I ~ "gh: Marcos-cat/iris"

Cam  ← "Omkar’s iPhone Camera"
UDP  ← &udpb "0.0.0.0:8888"
Addr ← "192.168.4.1:8888"

# I~Open ×1/5 1920_1440 "camera test"
I~Open ⍜⊣×₂×1/5 1920_1440 "camera test"
°I~Window~FPS 30

# I~Texture~LoadImage ▽₂1/5 &camcap Cam
I~Texture~LoadImage ˙⊂ ▽₂1/5 &camcap Cam

I~Loop!(
  &camcap Cam
  ▽₂1/5

  # ∩♭₋₁⟜⊸(⇡△₂)
  # ⍖↧⊸↥0÷/+∩⌟⊏1_2 0⍉
  # ⊏↙500
  # ⍜⊡≡⋅Green

  ⧋⊢₂⊸hsv
  ×⊓(
    # 0 for red hue
    # -τ/12 # Orange hue
    -τ/6 # Yellow hue
    # -τ/3 # Green hue
    # -2τ/3 # Blue hue
    ⍜⊙+◿τπ
    <0.4⌵ # Hue threshold
  | >0.8
  ) # Saturation threshold

  # ⊂⤙×

  ⟜⊸×
  ±⊸⧻⊚

  # ⨬◌(⁅≡Median⍉
  #    +⌟♭₂⊞×A₂⇡5
  #    ⍜⬚0⊡≡⋅Red)
  # ⨬◌(⁅⊸≡Median⍉
  #    ▽⊙⍉<140⌵/ℂ⊸-
  #    # ⁅÷₂+⊃/↧/↥
  #    # +⌟♭₂⊞×A₂⇡5
  #    # ⊃/↧/↥
  #    ⍜⍉≡(∩⌟⍣⊏0⟜¯↧40⌊÷2⊸⧻⍆)
  #    ⊂⊃(
  #     ⊚⊞↥˜∩(°⊚⊟)∩°⊟
  #   | ⁅÷₂+
  #     +⌟♭₂⊞×A₂⇡5)
  #    ⍜⬚0⊡≡⋅Red)
  # ˜⊂

  ⨬(0 [0 0] ◌
  | ⊸≡Median⍉
    ▽⊙⍉<100⌵/ℂ⊸-
    ⊃⧻(⍜⍉≡(∩⌟⍣⊏0⟜¯↧30⌊÷2⊸⧻⍆)
       ⊃(
        ⁅÷₂+
        ⟜(+⌟♭₂⊞×A₂⇡5)
      | ⊚⊞↥˜∩(°⊚⊟)∩°⊟
      )
       ⊙(⍜⬚0⊡≡⋅Red⊂)
    )
  )
  ⊙⊙˜⊂

  ⊸>1000
  ⨬(◌ # &udps [255 127 127 254 254] Addr UDP
  | ⊙⊣
    ⊟⊸¯↧⟜×200↥0÷⟜˜-7000
    ×◡⋅(<110⌵-127)

    ↥0↧254⌊+⊙(˙⊟×254÷384)

    ⊂255⊂⊙254_254
    # &udps ⊙(Addr UDP)
    &p
  )

  °⊸I~Texture~Image
  ⊸I~Draw~Background
)
