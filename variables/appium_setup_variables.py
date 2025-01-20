from appium.options.android.common.app.optional_intent_arguments_option import OPTIONAL_INTENT_ARGUMENTS

from variables.config_variables import CONFIG_PLATFORM_VERSION, CONFIG_DEVICE_NAME, CONFIG_APPIUM_SERVER_URL

PLATFORM_NAME = 'android'
PLATFORM_VERSION = CONFIG_PLATFORM_VERSION
DEVICE_NAME = CONFIG_DEVICE_NAME
AUTOMATION_NAME = 'uiautomator2'
APPIUM_SERVER = CONFIG_APPIUM_SERVER_URL
APP_PACKAGE = 'fi.fmi.mobileweather'
APP_ACTIVITY = 'fi.fmi.mobileweather.MainActivity'
OPTIONAL_INTENT_ARGUMENTS = "--es config 'http://localhost:3000/config'"

APPIUM_BASE_PATH_START_CMD = 'appium --base-path /wd/hub/'