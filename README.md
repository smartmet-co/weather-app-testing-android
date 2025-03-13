# Weather app Android test automation

## **Prequisites**

- Node (20)
- Java JDK 17
- Python 3.12 ->

## **Robot Framework and Python libraries installation**

`pip install robotframework`

`pip install robotframework-appiumlibrary`

`pip install robotframework-seleniumlibrary`

`pip install Appium-Python-Client`

`pip install pytz`

## **Appium installation**

`npm install -g appium`

`npm install -g appium-doctor`

`appium driver install uiautomator2`

 install Appium Inspector from https://github.com/appium/appium-inspector/releases

## **Android Studio installation**

1. Download and install Android Studio
2. Install following developer tools from Android Studio SDK manager -> Android SDK
 - At least one SDK Platform (e.g. 14)
 - Android SDK Build-Tools
 - Android SDK Command-line Tools
 - Android Emulator
 - Android Emulator hypervisor driver (Windows)
 - Android SDK Platform-Tools
3. Set Environmental variables and path
 - Set Environmental variable ANDROID_HOME (.../Android/sdk)
 - Set Environmental variable JAVA_HOME (.../jdk-xx.xx/bin)
 - Set following to PATH:

    `$ANDROID_HOME/emulator`

    `$ANDROID_HOME/platform-tools`

    `$ANDROID_HOME/tools`

    `$ANDROID_HOME/tools/bin`
    
    `$JAVA_HOME`
4. Create at least one emulator with Android Studio -> Virtual Device Manager

## **Running Robot Framework tests locally**

- Clone test environment: https://github.com/fmidev/weather-app-testing-android.git
- Copy weather-app *.apk file you want to test to `weather-app-testing-android/apk` folder.
- Create config_variables.py file to weather-app-testing-android/variables folder. Folder should contain two variables which represents local emulator or device:

  ANDROID_VERSION_LOCAL_1 = 'Here Android platform version of the local device or emulator under test. E.g. 14'

  DEVICE_NAME_LOCAL_1 = 'Here name of the local device or emulator under test. E.g. My_Phone_API_35'

- To run all tests use `robot tests/`
- To run single test suite use `robot tests/test_suite_tests.robot`

