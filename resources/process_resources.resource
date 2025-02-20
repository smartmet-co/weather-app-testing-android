*** Keywords ***
Verify Should Process Be Running
    [Arguments]    ${process}    ${should_process_be_running}
    IF    ${should_process_be_running}==${TRUE}
        Process Should Be Running    ${process}
    ELSE IF    ${should_process_be_running}==${FALSE}
        Process Should Be Stopped    ${process}
    END
    
Verify Is Process Running
    [Arguments]    ${process}
    ${is_process_running}=    Is Process Running    ${process}

Start Logcat
    [Arguments]    ${local_logging}=LOGGING_OFF    ${remove_file}=REMOVE_PREVIOUS_LOG    ${filter}=${APP_PACKAGE}    ${log_level}=W
    ${is_ci_env}=    Verify Environment
    IF    ${is_ci_env}==${TRUE}
        Start Process   adb logcat *:${log_level} | grep ${filter}    shell=yes    stdout=${CURDIR}/../stdout/logcat.txt    alias=logcat_process
    ELSE IF    ${is_ci_env}==${FALSE} and '${local_logging}'=='LOGGING_ON'
        IF    '${remove_file}'=='REMOVE_PREVIOUS_LOG'    Remove File    ${CURDIR}/../stdout/logcat.txt
        Start Process   adb logcat *:${log_level} | findstr ${filter}    shell=yes    stdout=${CURDIR}/../stdout/logcat.txt    alias=logcat_process
    END

Stop Logcat
    ${res}=    Run Process    pkill    -f    logcat
    Log    ${res.stdout}
    Terminate Process    logcat_process
    Process Should Be Stopped    logcat_process

Terminate All Processes Gracefully
    [Arguments]    @{args}
    ${is_ci_env}=    Verify Environment
    IF    ${is_ci_env}==${TRUE}
        No Operation
    ELSE IF    ${is_ci_env}==${FALSE}
        FOR    ${process}    IN    @{args}
            ${is_process_running}=    Is Process Running    ${process}
            IF    ${is_process_running}==${None}
                CONTINUE
            ELSE IF    '${process}'=='appium_server_process' and ${is_process_running}==${TRUE}
                Stop Appium Server
            ELSE IF    '${process}'=='emulator_process' and ${is_process_running}==${TRUE}
                Stop Emulator
            ELSE IF    '${process}'=='mock_server_process' and ${is_process_running}==${TRUE}
                Stop Mock Server
            ELSE IF    '${process}'=='logcat_process' and ${is_process_running}==${TRUE}
                Stop Logcat
            END
            IF    ${is_process_running}!=${None}
                Process Should Be Stopped    ${process}
            END
        END
    END
    Terminate All Processes