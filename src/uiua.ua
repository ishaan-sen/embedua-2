# FFI import! u32 uiua_malloc u32
Malloc ← |1 # External!
# FFI import! void uiua_free u32
Free ← |1.0 # External!
# FFI import! void write_u32_ptr u32 u32
WriteUIntPtr ← |2.0 # External!
# FFI import! void print_utf32 u32 u32
PrintExtern ← |2.0 # External!

Print ← (
  Malloc ∩×₄⟜⇡⊸⧻
  ⟜(⊃≡WriteUIntPtr⧻+)
  Free⟜PrintExtern
)

# FFI export! void uiua_main
UiuaMain ← Print "Hello, world! 🗿"