*** Keywords ***
Set Appium Capabilities And Open App
    ${android_driver}=    Open Application    ${APPIUM_SERVER}
    ...    platformName=${PLATFORM_NAME}
    ...    platformVersion=${PLATFORM_VERSION}
    ...    deviceName=${DEVICE_NAME}
    ...    automationName=${AUTOMATION_NAME}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}
    ...    optionalIntentArguments=e2e true

Set Appium Capabilities With Mock Server And Open App
    ${android_driver}=    Open Application    ${APPIUM_SERVER}
    ...    platformName=${PLATFORM_NAME}
    ...    platformVersion=${PLATFORM_VERSION}
    ...    deviceName=${DEVICE_NAME}
    ...    automationName=${AUTOMATION_NAME}

Start Appium Server
    Start Process    ${APPIUM_BASE_PATH_START_CMD}    shell=yes    stdout=DEVNULL    stderr=DEVNULL    alias=appium_server_process
    Wait For Process    appium_server_process    timeout=20 seconds
    Process Should Be Running    appium_server_process

Stop Appium Server
    ${result}=    Terminate Process    appium_server_process
    Process Should Be Stopped    appium_server_process