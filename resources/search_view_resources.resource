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
    
Save Search Location To My Places From Star Icon
    [Arguments]    ${location}
    Wait Until Element Is Visible    xpath=//android.view.View[@content-desc="Search Results, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[@content-desc='${location}']
    Click Element                    xpath=//android.view.View[@content-desc="Search Results, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[@content-desc="Add ${location} to My Places"]
    Wait Until Element Is Visible    xpath=//android.view.View[@content-desc="My Places, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[@content-desc="Remove ${location} from My Places"]
    
Delete Single Location From My Places From Star Icon
    [Arguments]    ${location}
    Wait Until Element Is Visible               xpath=//android.view.View[@content-desc="My Places, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[@content-desc="Remove ${location} from My Places"]
    Click Element                               xpath=//android.view.View[@content-desc="My Places, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[@content-desc="Remove ${location} from My Places"]
    Wait Until Page Does Not Contain Element    xpath=//android.view.View[@content-desc="My Places, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[@content-desc="Remove ${location} from My Places"]
    Wait Until Element Is Visible               xpath=//android.view.View[@content-desc="Previous searches, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[@content-desc="Add ${location} to My Places"]

Clear All Previous Searches
    Wait Until Page Contains Element            xpath=//android.view.View[@content-desc="Previous searches, Remember"]
    Wait Until Page Contains Element            xpath=//android.widget.Button[@content-desc="Clear all previous searches"]
    Click Element                               xpath=//android.widget.Button[@content-desc="Clear all previous searches"]
    Wait Until Page Does Not Contain Element    xpath=//android.widget.Button[@content-desc="Clear all previous searches"]
    Wait Until Page Does Not Contain Element    xpath=//android.view.View[@content-desc="Previous searches, Remember"]
    Wait Until Page Does Not Contain Element    xpath=//android.view.View[@content-desc="Previous searches, Remember"]/following-sibling::android.view.ViewGroup

Clear All My Places
    Wait Until Page Contains Element            xpath=//android.view.View[@content-desc="My Places, Remember"]
    Wait Until Page Contains Element            xpath=//android.widget.Button[@content-desc="Clear all My Places"]
    Click Element                               xpath=//android.widget.Button[@content-desc="Clear all My Places"]
    Wait Until Page Does Not Contain Element    xpath=//android.widget.Button[@content-desc="Clear all My Places"]
    Wait Until Page Does Not Contain ELement    xpath=//android.view.View[@content-desc="My Places, Remember"]
    Wait Until Page DOes Not Contain Element    xpath=//android.view.View[@content-desc="My Places, Remember"]/following-sibling::android.view.ViewGroup

Verify Single My Places Location
    [Arguments]    ${location}
        Element Should Be Visible    xpath=//android.view.View[@content-desc="My Places, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[@content-desc="${location}"]
        Element Should Be Visible    xpath=//android.view.View[@content-desc="My Places, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[@content-desc="Remove ${location} from My Places"]
    
Verify Single Previous Searches Location
    [Arguments]    ${location}    ${save_state}
        Element Should Be Visible    xpath=//android.view.View[@content-desc="Previous searches, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[@content-desc="${location}"]
        IF    '${save_state}'=='unsaved'
            Element Should Be Visible    xpath=//android.view.View[@content-desc="Previous searches, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[@content-desc="Add ${location} to My Places"]
        ELSE IF    '${save_state}'=='saved'
            Element Should Be Visible    xpath=//android.view.View[@content-desc="Previous searches, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[@content-desc="Remove ${location} from My Places"]
        END

Verify All My Places Locations
    [Arguments]    @{args}
    ${elements_count}=    Get Matching Xpath Count    //android.view.View[@content-desc="My Places, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[contains(@content-desc,'from My Places')]
    Should Be Equal As Integers   ${elements_count}    ${{len(${args})}}
    FOR    ${location}    IN    @{args}
        Verify Single My Places Location    ${location}
    END

Verify All Previous Searches Locations
    [Arguments]    &{args}
    ${elements_count}=    Get Matching Xpath Count    //android.view.View[@content-desc="Previous searches, Remember"]/following-sibling::android.view.ViewGroup/android.widget.Button[contains(@content-desc,'from My Places') or contains(@content-desc,'to My Places')]
    Should Be Equal    ${elements_count}    ${{len(${args})}}
    FOR    ${location}    ${save_state}    IN    &{args}
        Verify Single Previous Searches Location    ${location}    ${save_state}
    END