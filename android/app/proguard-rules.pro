# MetroLife ProGuard rules
# 參考: R8 minify rules

# Google Guava / J2ObjC
-dontwarn com.google.j2objc.annotations.**
-keep class com.google.j2objc.annotations.** { *; }
-dontwarn sun.misc.**

# Google Maps
-keep class com.google.android.gms.maps.** { *; }
-keep interface com.google.android.gms.maps.** { *; }

# Drift / SQLite
-keep class com.sqlite3.** { *; }
-keep class org.sqlite.** { *; }

# Freezed / JSON serialization
-keep class **.freezed.dart { *; }
-keep class **.g.dart { *; }

# Health package
-keep class com.pberna.plugin.health.** { *; }

# Dio / Retrofit
-keep class retrofit2.** { *; }
-dontwarn retrofit2.**
-keepattributes Signature
-keepattributes Exceptions

# Awesome Notifications
-keep class me.carda.awesome_notifications.** { *; }

# Kotlin coroutines
-dontwarn kotlinx.coroutines.**
-keep class kotlinx.coroutines.** { *; }

# General Android
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile
