*** Settings ***
Documentation    This suite tests fmi mobile weather app warnings view.
Library          AppiumLibrary
Library          OperatingSystem
Library          Process
Library          String
Library          Collections
Library          ../libraries/fmi_custom_library.py
Resource         ../resources/appium_resources.resource
Resource         ../resources/dut_resources.resource
Resource         ../resources/onboarding_resources.resource
Resource         ../resources/process_resources.resource
Resource         ../resources/weather_view_resources.resource
Resource         ../resources/warnings_view_resources.resource
Variables        ../variables/appium_setup_variables.py
Variables        ../variables/onboarding_variables.py
Variables        ../variables/dut_variables.py
Variables        ../variables/config_variables.py
Test Setup       Start Emulator And Appium With App    ${APP_PACKAGE}    latest.apk
Test Teardown    Run Keyword If Test Failed    Terminate All Processes Gracefully    emulator_process    appium_server_process

*** Test Cases ***
Verify Warnings View Elements
    Set DUT Geo Fix Location    ${GEO_LOCATION_COORDINATES_DICT}[Savukoski]
    Weather forecast and observations Title Is Visible
    Click Skip Button
    Click Terms of Use Button
    Click Close Button From Terms Of Use View
    Click Accept Button
    Location Title Is Visible
    Click Next Setup Button
    Verify Grant Dialog Opens
    Press While Using App From Grant Dialog
    Verify Location Text From Upper Bar    Savukoski
    Open Warnings View
    Terminate All Processes Gracefully    emulator_process    appium_server_process