PLATFORM_NAME = 'android'
AUTOMATION_NAME = 'uiautomator2'
APP_PACKAGE = 'fi.fmi.mobileweather'
APP_ACTIVITY = 'fi.fmi.mobileweather.MainActivity'
OPTIONAL_INTENT_ARGUMENTS = "--es config 'http://localhost:3000/config'"

APPIUM_SERVER = 'http://127.0.0.1:4723/wd/hub'
APPIUM_BASE_PATH_START_CMD = 'appium --base-path /wd/hub/'