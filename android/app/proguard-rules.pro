# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.** { *; }

# Keep your main activity
-keep class com.example.e_summit25.MainActivity { *; }

# Keep classes with @Keep annotation
-keep @interface androidx.annotation.Keep
-keep @androidx.annotation.Keep class * { *; }

# Keep classes with @Keep annotation in your app
-keep @interface com.example.e_summit25.annotation.Keep
-keep @com.example.e_summit25.annotation.Keep class * { *; }

# Keep Google Play Core classes
-keep class com.google.android.play.core.** { *; }
-keep interface com.google.android.play.core.** { *; }