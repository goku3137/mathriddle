# OWASP MASVS-RESILIENCE-1: R8 / ProGuard Optimization and Obfuscation Rules for SMATH

# Flutter Engine & Framework
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep native JNI methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Preserve LineNumberTable and SourceFile attributes for crash reporting symbolication
-keepattributes SourceFile,LineNumberTable

# Obfuscate names and dictionary
-repackageclasses ''
-allowaccessmodification

