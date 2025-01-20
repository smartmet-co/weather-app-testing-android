*** Keywords ***
Open Warnings View
    Wait Until Page Contains Element    xpath=//*[@resource-id='navigation_warnings']
    Click Element                       xpath=//*[@resource-id='navigation_warnings']
    Wait Until Page Contains Element    xpath=//*[@resource-id='warnings_info_button']