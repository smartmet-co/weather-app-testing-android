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

Open Search Info View
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='search_header_info_button']
    Click Element                       xpath=//android.widget.Button[@resource-id='search_header_info_button']
    Wait Until Element Is Visible       xpath=//android.view.ViewGroup[@resource-id="search_info_bottom_sheet"]

Verify Search Info View Titles
    [Arguments]    ${title_1}    ${title_2}
    Wait Until Element Is Visible    xpath=//android.view.View[@text='${title_1}']
    Wait Until Element Is Visible    xpath=//android.view.View[@text='${title_2}']

Close Search Info
    Wait Until Page Contains Element            xpath=//android.widget.Button[@resource-id='search_info_bottom_sheet_close_button']
    Click Element                               xpath=//android.widget.Button[@resource-id='search_info_bottom_sheet_close_button']
    Wait Until Page Does Not Contain Element    xpath=//android.widget.Button[@resource-id='search_info_bottom_sheet_close_button']

Click Navigate Back From Search View
    Wait Until Page Contains Element            xpath=//android.widget.Button[@resource-id='header-back']
    Click Element                               xpath=//android.widget.Button[@resource-id='header-back']
    Wait Until Page Does Not Contain Element    xpath=//android.widget.Button[@resource-id='header-back']