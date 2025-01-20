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


Terminate All Processes Gracefully
    [Arguments]    @{args}
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
        END
        IF    ${is_process_running}!=${None}
            Process Should Be Stopped    ${process}
        END
    END
    Terminate All Processes