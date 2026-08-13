# Release Signing Configuration Rule

## Mandatory Release Signing Requirements

1. **Always Use `key.properties` and Release Keystore**:
   - Every release APK (`flutter build apk --release`) MUST be signed with `upload-keystore.jks` or `debug` fallback.
   - `android/app/build.gradle.kts` MUST contain:
     ```kotlin
     buildTypes {
         release {
             if (keystorePropertiesFile.exists()) {
                 signingConfig = signingConfigs.getByName("release")
             } else {
                 signingConfig = signingConfigs.getByName("debug")
             }
         }
     }
     ```

2. **Keystore Configuration (`key.properties`)**:
   - Store path: `key.properties` in root directory
   - Credentials:
     ```properties
     storePassword=android123
     keyPassword=android123
     keyAlias=upload
     storeFile=app/upload-keystore.jks
     ```

3. **Prevention of "App Not Installed" Error**:
   - Never produce unsigned release APKs.
   - Always run `apksigner verify -v` or ensure `signingConfig` is set before publishing or distributing release APKs.
