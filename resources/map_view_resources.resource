*** Keywords ***
Open Map View
    Wait Until Page Contains Element    xpath=//*[@resource-id='navigation_map']
    Click Element                       xpath=//*[@resource-id='navigation_map']
    Wait Until Page Contains Element    xpath=//*[@resource-id='map_layers_button']
