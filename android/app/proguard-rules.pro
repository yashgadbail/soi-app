# Keep rules for release builds (R8).
# Flutter's own rules are added by the Flutter Gradle plugin. Add plugin-
# specific rules here only when a release build fails at runtime.

# mobile_scanner bundles the ML Kit barcode model; keep its public API.
-keep class com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**
