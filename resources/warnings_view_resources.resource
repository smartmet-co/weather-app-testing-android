*** Keywords ***
Open Warnings View
    Wait Until Page Contains Element    xpath=//*[@resource-id='navigation_warnings']
    Click Element                       xpath=//*[@resource-id='navigation_warnings']
    Wait Until Page Contains Element    xpath=//android.view.View[@content-desc="Warnings"]

Verify Warnings View Elements
    Wait Until Page Contains Element    xpath=//android.widget.Button[@content-desc="warnings info"]
    Wait Until Page Contains Element    xpath=//android.widget.FrameLayout[@resource-id="map"]

Verify Warnings Days Horizontal Ribbon Elements
    ${current_date}=    Get Current Date    %a, %d %b
    Wait Until Page Contains Element    xpath=//android.view.ViewGroup[@content-desc="${current_date}"]/android.view.ViewGroup
    ${warnings_days_text}=    Get Element Attribute    xpath=//android.widget.FrameLayout[@resource-id="map"]/following-sibling::android.view.View    content-desc
    ${how_many_warnings_days}=    Extract Integer From String    ${warnings_days_text}
    ${future_date_found}=    Get Future Date    ${how_many_warnings_days-1}    %a, %d %b
    ${future_date_not_found}=    Get Future Date    ${how_many_warnings_days}    %a, %d %b
    Wait Until Page Contains Element    xpath=//android.view.ViewGroup[@content-desc="${future_date_found}"]/android.view.ViewGroup
    Page Should Not Contain Element     xpath=//android.view.ViewGroup[@content-desc="${future_date_not_found}"]/android.view.ViewGroup