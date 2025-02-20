*** Keywords ***
Restart Adb Server
    ${kill_result}=     Run    adb kill-server
    ${start_result}=    Run    adb start-server

Start Emulator
    ${emulator}=    Run Process   emulator    -list-avds    alias=list_avds
    Start Process    emulator    -avd    ${emulator.stdout}    stdout=DEVNULL    stderr=DEVNULL    alias=emulator_process
    Wait For Process    emulator_process    timeout=20 seconds
    Process Should Be Running    emulator_process

Stop Emulator
    ${result}=    Start Process   adb    emu    kill    stdout=${CURDIR}/../stdout/emu_kill.txt    alias=kill_emulator
    Wait For Process    kill_emulator    timeout=30
    ${stdout_file_content}=    Get File    ${CURDIR}/../stdout/emu_kill.txt
     @{lines}=    Split To Lines    ${stdout_file_content}
    ${last_value}=    Get From List    ${lines}    -1
    Should Be Equal    ${last_value}    OK
    ${result}=    Terminate Process    emulator_process
    Process Should Be Stopped    emulator_process

Install New Apk And Uninstall Old If Found
    [Arguments]    ${package_name}    ${apk_name}
    ${installed_apk_count}=    Verify Is Apk Installed    ${package_name}
    IF    ${installed_apk_count}==${0}
        Install Apk    ${apk_name}
    ELSE IF    ${installed_apk_count}==${1}
        Uninstall Apk    ${package_name}
        Install Apk      ${apk_name}
    END

Install Apk
    [Arguments]    ${apk_name}
    ${res}=    Run Process   adb    install    ${CURDIR}/../apk/${apk_name}    alias=apk_install
    @{lines}=    Split To Lines    ${res.stdout}
    List Should Contain Value    ${lines}    Success

Uninstall Apk
    [Arguments]    ${package_name}
    ${res}=    Run Process   adb    shell    pm    uninstall    ${package_name}    alias=apk_uninstall
    @{lines}=    Split To Lines    ${res.stdout}
    List Should Contain Value    ${lines}    Success

Verify Is Apk Installed
    [Arguments]    ${package_name}
    Run Process   adb    shell    pm    list    packages    stdout=${CURDIR}/../stdout/list_packages.txt
    ${stdout_file_content}=    Get File    ${CURDIR}/../stdout/list_packages.txt
    @{package_list}=    Split To Lines    ${stdout_file_content}
    ${match_count}=    Get Match Count    ${package_list}    package:${package_name}    ignore_whitespace=${TRUE}
    IF    ${match_count}>${1}    Fatal Error    msg=Too many packages installed with a same name!!!
    RETURN    ${match_count}
    
Set DUT Geo Fix Location
    [Arguments]    ${coordinates}
    [Documentation]    Specify coordinates with lon lat in decimal degrees. Eg. -12.345 67.890
    ${res}=    Run Process    adb    emu    geo    fix    ${coordinates}    alias=set_location
    @{lines}=    Split To Lines    ${res.stdout}
    List Should Contain Value    ${lines}    OK

Start Emulator And Appium With App
    [Arguments]    ${app_package}    ${package_name}    ${android_version}=${ANDROID_VERSION_LOCAL_1}    ${device_name}=${DEVICE_NAME_LOCAL_1}
    Start Appium Server
    Start Emulator
    Sleep    20
    Install New Apk And Uninstall Old If Found    ${app_package}    ${package_name}
    Start Logcat    local_logging=LOGGING_ON
    Set Appium Capabilities And Open App    ${android_version}    ${device_name}

Start Emulator And Appium With Mock Server
    [Arguments]    ${mock_server_location}    ${app_package}    ${package_name}
    Start Mock Server    ${mock_server_location}
    Start Appium Server
    Start Emulator
    Install New Apk And Uninstall Old If Found    ${app_package}    ${package_name}
    Set Appium Capabilities With Mock Server And Open App
    Open Fmi Application With Mock Server

Suite Setup Actions
    [Arguments]    ${app_package}    ${package_name}    ${set_ci_logging}=LOGGING_ON
    ${is_ci_env}=    Verify Environment
    IF    ${is_ci_env}==${TRUE}
        Install New Apk And Uninstall Old If Found    ${app_package}    ${package_name}
        IF    '${set_ci_logging}'=='LOGGING_ON'    Start Logcat
        Set Appium Capabilities And Open App
    ELSE IF    ${is_ci_env}==${FALSE}
        Import Variables    ${CURDIR}/../variables/config_variables.py
        Start Emulator And Appium With App    ${app_package}    ${package_name}
    END

Suite Teardown Actions
    ${is_ci_env}=    Verify Environment
    IF    ${is_ci_env}==${TRUE}
        Terminate All Processes
    ELSE IF    ${is_ci_env}==${FALSE}
        Terminate All Processes Gracefully    emulator_process    appium_server_process    logcat_process
    END

Verify Environment
    ${env_variables_dict}=    Get Environment Variables
    ${status}=    Get Status Is Key Found In Dictionary    ${env_variables_dict}    CI_ENV_ANDROID
    RETURN    ${status}

Unlock Emulator
    ${res}=    Run Process    adb    shell    input    keyevent    82    alias=unlock_emulator

Enable Touchscreen Input
    ${res}=    Run Process    adb    shell    settings    put    system    show_touches    1    alias=enable_touchscreen

Swipe Up
    [Arguments]    ${how_many_swipes}    ${start_x}=500    ${start_y}=900    ${end_x}=500    ${end_y}=100    ${duration}=500
    FOR    ${index}    IN RANGE    ${how_many_swipes} + 1
        ${res}=    Run Process    adb    shell    input    swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}
    END

Swipe Down
    [Arguments]    ${how_many_swipes}    ${start_x}=500    ${start_y}=100    ${end_x}=500    ${end_y}=900    ${duration}=500
    FOR    ${index}    IN RANGE    ${how_many_swipes} + 1
        ${res}=    Run Process    adb    shell    input    swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    ${duration}
    END