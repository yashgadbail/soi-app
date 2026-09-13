plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// ---------------------------------------------------------------------------
// Release signing
//
// The upload key never lives in this repository. Its path and passwords come
// from the USER-level Gradle properties file (~/.gradle/gradle.properties):
//
//   SOI_UPLOAD_STORE_FILE=<absolute path outside the repository>/soi-release.keystore
//   SOI_UPLOAD_KEY_ALIAS=soi
//   SOI_UPLOAD_STORE_PASSWORD=...
//   SOI_UPLOAD_KEY_PASSWORD=...
//
// When the properties are absent, debug builds and APKs still work (a
// contributor without the key is not blocked), but building a release
// bundle (AAB) fails hard: a store bundle signed with the debug key is never
// what anyone wants, and silence is the bug. See docs/RELEASE.md.
// ---------------------------------------------------------------------------
val hasUploadKey = project.hasProperty("SOI_UPLOAD_STORE_FILE")

android {
    namespace = "org.swagofindia.soi"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // Same application id as the app already on Google Play. Changing it
        // would make this a new listing and lose the rating, declarations,
        // reviews and installs.
        applicationId = "org.swagofindia.soi"
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        resourceConfigurations += listOf("en")
    }

    signingConfigs {
        if (hasUploadKey) {
            create("release") {
                storeFile = file(project.property("SOI_UPLOAD_STORE_FILE") as String)
                storePassword = project.property("SOI_UPLOAD_STORE_PASSWORD") as String
                keyAlias = project.property("SOI_UPLOAD_KEY_ALIAS") as String
                keyPassword = project.property("SOI_UPLOAD_KEY_PASSWORD") as String
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (hasUploadKey) signingConfigs.getByName("release")
                            else signingConfigs.getByName("debug")
            // Code shrinking and obfuscation (R8). Mapping files are produced
            // under build/app/outputs/mapping/release and uploaded with the AAB.
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    packaging {
        jniLibs {
            // 16 KB page-size alignment for native libraries (Play requirement).
            useLegacyPackaging = false
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}

// Refuse to build a store bundle with the debug key.
gradle.taskGraph.whenReady {
    if (!hasUploadKey && allTasks.any { it.name.lowercase().contains("bundlerelease") }) {
        throw GradleException(
            "Refusing to build a release bundle with the debug key.\n" +
            "SOI_UPLOAD_STORE_FILE is not set, so this AAB would be signed CN=Android Debug " +
            "and Google Play would reject it.\n" +
            "Put SOI_UPLOAD_STORE_FILE / SOI_UPLOAD_KEY_ALIAS / SOI_UPLOAD_STORE_PASSWORD / " +
            "SOI_UPLOAD_KEY_PASSWORD in the USER-level ~/.gradle/gradle.properties."
        )
    }
}
