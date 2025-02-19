*** Keywords ***
Click Next Button
    Click Element    xpath=//android.widget.Button[@content-desc="Next"]/android.view.ViewGroup

${icon_name} Icon Is Visible
    [Arguments]    ${icon_xpath}
    Wait Until Element Is Visible    xpath=${icon_xpath}    timeout=30

${title_text} Title Is Visible
    Wait Until Element Is Visible    xpath=//android.view.View[@text="${title_text}"]    timeout=10

${title_text} Intro Text Is Visible
    [Arguments]    ${body_text}
    Element Text Should Be    xpath=//android.widget.TextView[@resource-id="onboarding_description_text"]    ${body_text}

${title_text} Setup Text Is Visible
    [Arguments]    ${body_text}
    Element Text Should Be    xpath=//android.widget.TextView[@resource-id="setup_description_text"]    ${body_text}

Accept Button Should Be ${state}
    Wait Until Element Is Visible    xpath=//android.widget.Button[@content-desc="Accept"]
    IF         '${state}'=='Disabled'
        Element Should Be Disabled    xpath=//android.widget.Button[@content-desc="Accept"]
    ELSE IF    '${state}'=='Enabled'
        Element Should Be Enabled    xpath=//android.widget.Button[@content-desc="Accept"]
    END

Click Skip Button
    Click Element    xpath=//android.widget.Button[@resource-id="onboarding_skip_button"]
    Terms of Use Title Is Visible
    Accept Button Should Be Disabled

Click Terms of Use Button
    Click Element    xpath=//android.widget.Button[@content-desc="Terms of Use"]

Click Close Button From Terms Of Use View
    Wait Until Element Is Visible    xpath=//*[@resource-id='terms_close_button']
    Click Element     xpath=//*[@resource-id='terms_close_button']

Click Accept Button
    Accept Button Should Be Enabled
    Click Element    xpath=//android.widget.Button[@content-desc="Accept"]

Click Next Setup Button
    Wait Until Element Is Visible    xpath=//android.widget.Button[@content-desc="Next"]
    Click Element    xpath=//android.widget.Button[@resource-id="setup_primary_button"]

Verify Grant Dialog Opens
    Wait Until Element Is Visible    xpath=//android.widget.LinearLayout[@resource-id="com.android.permissioncontroller:id/grant_dialog"]

Verify Grant Dialog Elements
    [Arguments]    ${body_text}
    Wait Until Element Is Visible    xpath=//android.widget.ImageView[@resource-id="com.android.permissioncontroller:id/permission_icon"]
    Element Text Should Be           xpath=//android.widget.TextView[@resource-id="com.android.permissioncontroller:id/permission_message"]    ${body_text}
    Element Should Be Visible        xpath=//android.widget.RadioButton[@resource-id="com.android.permissioncontroller:id/permission_location_accuracy_radio_fine" and @checked="true"]
    Element Should Be Visible        xpath=//android.widget.RadioButton[@resource-id="com.android.permissioncontroller:id/permission_location_accuracy_radio_coarse" and @checked="false"]
    Element Should Be Visible        xpath=//android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_allow_foreground_only_button"]
    Element Should Be Visible        xpath=//android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_allow_one_time_button"]
    Element Should Be Visible        xpath=//android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_deny_button"]

Press ${selection} From Grant Dialog
    IF    '${selection}'=='Do Not Allow'
        Click Element    xpath=//android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_deny_button"]
    ELSE IF    '${selection}'=='This Time Only'
        Click Element    xpath=//android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_allow_one_time_button"]
    ELSE IF    '${selection}'=='While Using App'
        Click Element    xpath=//android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_allow_foreground_only_button"]
    END
    Wait Until Element Is Visible    xpath=//android.view.View[@resource-id="navigation_others"]

Run Skipped Onboarding Process
    Weather forecast and observations Title Is Visible
    Click Skip Button
    Click Terms of Use Button
    Click Close Button From Terms Of Use View
    Click Accept Button
    Location Title Is Visible
    Click Next Setup Button
    Verify Grant Dialog Opens
    Press While Using App From Grant Dialog

Setup Onboarding Test
    [Arguments]    ${app_package}    ${package_name}
    ${is_ci_env}=    Verify Environment
    IF    ${is_ci_env}==${TRUE}
        Install New Apk And Uninstall Old If Found    ${app_package}    ${package_name}
        Set Appium Capabilities And Open App
    ELSE IF    ${is_ci_env}==${FALSE}
        Import Variables    ${CURDIR}/../variables/config_variables.py
        Terminate All Processes Gracefully    emulator_process    appium_server_process
        Start Emulator And Appium With App    ${app_package}    ${package_name}
    END