*** Keywords ***
Open Other View
    Wait Until Page Contains Element    xpath=//*[@resource-id='navigation_others']
    Click Element                       xpath=//*[@resource-id='navigation_others']
    Wait Until Page Contains Element    xpath=//*[@resource-id='navigation_settings']
    Wait Until Page Contains Element    xpath=//*[@resource-id='navigation_about']
    Wait Until Page Contains Element    xpath=//*[@resource-id='navigation_terms_and_conditions']
    Wait Until Page Contains Element    xpath=//*[@resource-id='navigation_accessibility']
    Wait Until Page Contains Element    xpath=//*[@resource-id='navigation_feedback']
