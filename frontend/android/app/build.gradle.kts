import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

// Cách đúng để tải local.properties cho các giá trị khác
val localProperties = Properties()
localProperties.load(FileInputStream(project.rootProject.file("local.properties")))

android {
    namespace = "com.doctorai.app" // Thay đổi thành namespace của ứng dụng của bạn
    
    // Sửa lỗi ở đây: Sử dụng flutter.compileSdkVersion trực tiếp
    compileSdk = flutter.compileSdkVersion.toInt() // Lấy từ Flutter object
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.doctorai.app" // Thay đổi thành ID ứng dụng của bạn
        
        // Sửa lỗi ở đây: Sử dụng flutter.minSdkVersion và flutter.targetSdkVersion trực tiếp
        minSdk = flutter.minSdkVersion.toInt() // Lấy từ Flutter object
        targetSdk = flutter.targetSdkVersion.toInt() // Lấy từ Flutter object
        
        // Giữ lại cách lấy version code và version name từ local.properties
        versionCode = localProperties.getProperty("flutter.versionCode").toInt()
        versionName = localProperties.getProperty("flutter.versionName")
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    // THÊM KHỐI signingConfigs VÀO ĐÂY
    signingConfigs {
        create("release") {
            storeFile = file(localProperties.getProperty("storeFile")!!)
            storePassword = localProperties.getProperty("storePassword")!!
            keyAlias = localProperties.getProperty("keyAlias")!!
            keyPassword = localProperties.getProperty("keyPassword")!!
        }
    }

    buildTypes {
        release {
            // ĐÃ SỬA: Áp dụng cấu hình ký 'release' thay vì 'debug'
            signingConfig = signingConfigs.getByName("release") 
            // Có thể thêm các cấu hình tối ưu hóa khác cho bản release tại đây
            // isMinifyEnabled = true
            // isShrinkResources = true
            // proguardFiles(getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro')
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Import the Firebase BoM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:33.0.0"))

    // Add the dependencies for the Firebase products you want to use
    implementation("com.google.firebase:firebase-analytics")

    // Truy cập kotlin_version từ rootProject.extra
    val kotlin_version = rootProject.extra["kotlin_version"] as String
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8:$kotlin_version")
    implementation("androidx.multidex:multidex:2.0.1")
}