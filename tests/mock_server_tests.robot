*** Settings ***
Documentation    This suite tests fmi mobile weather app features and elements against mock server.
Library          AppiumLibrary
Library          OperatingSystem
Library          Process
Library          String
Library          Collections
Library          RequestsLibrary
Resource         ../resources/mock_server_resources.resource
Resource         ../resources/appium_resources.resource
Resource         ../resources/dut_resources.resource
Resource         ../resources/onboarding_resources.resource
Resource         ../resources/process_resources.resource
Resource         ../resources/weather_view_resources.resource
Variables        ../variables/config_variables.py
Variables        ../variables/appium_setup_variables.py
Variables        ../variables/onboarding_variables.py
Variables        ../variables/dut_variables.py
Test Setup       Start Emulator And Appium With App    ${APP_PACKAGE}    latest.apk
Test Teardown    Run Keyword If Test Failed    Terminate All Processes Gracefully    emulator_process    mock_server_process    appium_server_process

*** Test Cases ***
Mock Server Onboarding Test
    [Setup]    Start Emulator And Appium With Mock Server    ${CONFIG_MOCK_SERVER_PATH}    ${APP_PACKAGE}    app-latest.apk
    Set Mock Server Geolocation    tikkurila
    Set Mock Server Forecast    winter
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
    Press While Using App From Grant Dialog
    Verify Location Text From Upper Bar    Tikkurila
    Terminate All Processes Gracefully    emulator_process   mock_server_process    appium_server_process