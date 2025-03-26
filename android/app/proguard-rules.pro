# Jangan obfuscate kode Flutter
-keep class io.flutter.** { *; }

# Jangan obfuscate model JSON (jika menggunakan serialization)
-keep class com.example.yourapp.model.** { *; }

# Hindari penghapusan kode penting
-keepattributes *Annotation*