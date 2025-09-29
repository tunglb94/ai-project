// clone/frontend/android/build.gradle.kts

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        val gradlePluginVersion = "8.3.0"
        val googleServicesVersion = "4.4.1"
        classpath("com.android.tools.build:gradle:$gradlePluginVersion")
        classpath("com.google.gms:google-services:$googleServicesVersion")
        // Định nghĩa kotlin_version ở đây để sử dụng trong buildscript block này
        // nhưng chúng ta sẽ đặt nó ở cấp độ 'extra' để subproject có thể truy cập
        // val kotlin_version = "1.9.22" // Xóa dòng này nếu có
    }
}

// Định nghĩa kotlin_version ở cấp độ root project để tất cả các subproject có thể truy cập
allprojects {
    repositories {
        google()
        mavenCentral()
    }
    // Sử dụng 'extra.set()' để định nghĩa property
    extra.set("kotlin_version", "1.9.22") // Phiên bản Kotlin
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}