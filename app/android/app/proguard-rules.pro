# Keep Flutter and Dart runtime essentials
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.** { *; }

# Keep Kotlin metadata (avoid issues with reflection)
-keep class kotlin.Metadata { *; }

# Keep JSON models (if using reflection)
-keep class **.model.** { *; }
-keep class **.models.** { *; }

# OkHttp/Okio/HTTP (http package may use them transitively)
-dontwarn okhttp3.**
-dontwarn okio.**

# Keep annotations
-keepattributes *Annotation*

# If using file picker or image picker with reflection
-keep class com.mr.flutter.plugin.filepicker.** { *; }
-keep class io.flutter.plugins.imagepicker.** { *; }

# Keep Provider (usually not needed but safe)
-keep class androidx.lifecycle.** { *; }

# Avoid obfuscating Parcelable/Serializable (safety)
-keepclassmembers class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator CREATOR;
}
-keepclassmembers class * implements java.io.Serializable { *; }

# General recommendations
-dontoptimize
-dontshrink
-keep class ** { *; }
