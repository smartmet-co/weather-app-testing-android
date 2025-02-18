*** Keywords ***

Open Search View
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='search_header_button']
    Click Element                       xpath=//android.widget.Button[@resource-id='search_header_button']
    Wait Until Element Is Visible       xpath=//android.widget.Button[@content-desc='Find My Location']/android.widget.Button/android.view.ViewGroup
    
Enter Search Location
    [Arguments]    ${location}
    Input Text    xpath=//android.widget.EditText[@resource-id='search_input']    ${location}
    
Select From Location Search Results
    [Arguments]    ${location}
    Wait Until Element Is Visible    xpath=//android.widget.Button[@content-desc='${location}']
    Click ELement                    xpath=//android.widget.Button[@content-desc='${location}']
    Verify Location Text From Upper Bar    ${location}
    
Set New Location From Search View
    [Arguments]    ${location}
    Open Search View
    Enter Search Location    ${location}
    Select From Location Search Results    ${location}