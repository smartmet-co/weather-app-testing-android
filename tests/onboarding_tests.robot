*** Settings ***
Documentation    This suite tests fmi mobile weather app onboarding feature.
Library          AppiumLibrary
Library          OperatingSystem
Library          Process
Library          String
Library          Collections
Library          RequestsLibrary
Library          ../libraries/fmi_custom_library.py
Resource         ../resources/appium_resources.resource
Resource         ../resources/dut_resources.resource
Resource         ../resources/onboarding_resources.resource
Resource         ../resources/process_resources.resource
Resource         ../resources/weather_view_resources.resource
Resource         ../resources/search_view_resources.resource
Variables        ../variables/appium_setup_variables.py
Variables        ../variables/onboarding_variables.py
Variables        ../variables/dut_variables.py
Suite Setup      Suite Setup Actions    ${APP_PACKAGE}    app-latest.apk
Suite Teardown   Suite Teardown Actions
Test Setup       Setup Onboarding Test    ${APP_PACKAGE}    app-latest.apk
Test Teardown    Set Default Weather View

*** Test Cases ***
Open Mobile Weather App With Full Onboarding Successfully
    [Setup]    NONE
    Weather Forecast And Observations Icon Is Visible    ${ICON_NAME_1}
    Weather forecast and observations Title Is Visible
    Weather Forecast And Observations Intro Text Is Visible    ${INTRO_WFO_BODY_TEXT_EN}
    Click Next Button
    Map Icon Is Visible    ${ICON_NAME_1}
    Map Title Is Visible
    Map Intro Text Is Visible    ${INTRO_MAP_BODY_TEXT_EN}
    Click Next Button
    Warnings Icon Is Visible    ${ICON_NAME_1}
    Warnings Title Is Visible
    Warnings Intro Text Is Visible    ${INTRO_WAR_BODY_TEXT_EN}
    Click Next Button
    Customize Icon Is Visible    ${ICON_NAME_1}
    Customize Title Is Visible
    Customize Intro Text Is Visible    ${INTRO_CUS_BODY_TEXT_EN}
    Click Next Button
    Terms of Use Title Is Visible
    Accept Button Should Be Disabled
    Click Terms of Use Button
    Click Close Button From Terms Of Use View
    Click Accept Button
    Location Title Is Visible
    Location Setup Text Is Visible    ${INTRO_LOC_BODY_TEXT_EN}
    Click Next Setup Button
    Verify Grant Dialog Opens
    Verify Grant Dialog Elements    ${PERMISSION_LOC_TEXT_EN}
    Press While Using App From Grant Dialog
    Verify Location Text From Upper Bar
    [Teardown]    NONE

Open Mobile Weather App With Skip Onboarding Successfully
    Weather Forecast And Observations Icon Is Visible    ${ICON_NAME_1}
    Weather forecast and observations Title Is Visible
    Weather Forecast And Observations Intro Text Is Visible    ${INTRO_WFO_BODY_TEXT_EN}
    Click Skip Button
    Click Terms of Use Button
    Click Close Button From Terms Of Use View
    Click Accept Button
    Location Title Is Visible
    Location Setup Text Is Visible    ${INTRO_LOC_BODY_TEXT_EN}
    Click Next Setup Button
    Verify Grant Dialog Opens
    Verify Grant Dialog Elements    ${PERMISSION_LOC_TEXT_EN}
    Press Do Not Allow From Grant Dialog
    Verify Location Text From Upper Bar    Helsinki
    [Teardown]    NONE