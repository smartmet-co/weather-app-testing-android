*** Settings ***
Documentation    This suite tests fmi mobile weather app weather view.
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
Variables        ../variables/appium_setup_variables.py
Variables        ../variables/onboarding_variables.py
Variables        ../variables/dut_variables.py
Variables        ../variables/config_variables.py
Test Setup       Start Emulator And Appium With App    ${APP_PACKAGE}    latest.apk
Test Teardown    Run Keyword If Test Failed    Terminate All Processes Gracefully    emulator_process    appium_server_process

*** Test Cases ***
Verify 10-day Forecast Table View Elements
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
    Verify Forecast Time
    Verify Forecast Length    10
    Verify Table View Is Active
    Verify Parameters Button Is Enabled
    Verify Parameters Info Button Is Enabled
    Terminate All Processes Gracefully    emulator_process    appium_server_process

Verify 10-day Forecast Graph View Elements
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
    Verify Table View Is Active
    Verify Parameters Button Is Enabled
    Verify Parameters Info Button Is Enabled
    Click Chart Button
    Verify Graph View Is Active
    Verify Parameters Button Is Disabled
    Verify Parameters Info Button Is Disabled
    Terminate All Processes Gracefully    emulator_process    appium_server_process

Verify Parameters View Opens
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
    Verify Table View Is Active
    Click Parameters Button
    Verify Parameters View
    Click Parameters Close Button
    Verify Table View Is Active
    Terminate All Processes Gracefully    emulator_process    appium_server_process

Verify Parameters Info View Opens
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
    Verify Table View Is Active
    Click Parameters Info Button
    Verify Parameters Info View
    Click Parameters Info Close Button
    Verify Table View Is Active
    Terminate All Processes Gracefully    emulator_process    appium_server_process

Verify 10-day Forecast Horizontal Scroll Bar
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
    Verify First Date Of Forecast At Horizontal Scroll Bar
    Scroll Forecast Horizontal Scroll Bar To Right 3 Times
    Verify Last Date Of Forecast At Horizontal Scroll Bar
    Terminate All Processes Gracefully    emulator_process    appium_server_process

Verify Observation Stations Are Active Stations
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
    Swipe By Percent    50    90    50    10    duration=1500
    Open Observation Stations Dropdown List
    Verify Observation Stations Are Active Stations
    Click Close Observation Stations List Button
    Terminate All Processes Gracefully    emulator_process    appium_server_process

Verify Observation Stations Are Once In A Day Reporting Stations
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
    Swipe By Percent    50    90    50    10    duration=1500
    Open Observation Stations Dropdown List
    Verify Observation Stations Are Once In A Day Reporting Stations
    Click Close Observation Stations List Button
    Terminate All Processes Gracefully    emulator_process    appium_server_process

Verify Once A Day Reporting Observation Station List View Elements
    Set DUT Geo Fix Location    ${GEO_LOCATION_COORDINATES_DICT}[Posio]
    Weather forecast and observations Title Is Visible
    Click Skip Button
    Click Terms of Use Button
    Click Close Button From Terms Of Use View
    Click Accept Button
    Location Title Is Visible
    Click Next Setup Button
    Verify Grant Dialog Opens
    Press While Using App From Grant Dialog
    Verify Location Text From Upper Bar    Posio
    Swipe By Percent    50    90    50    10    duration=1500
    Open Observation Stations Dropdown List
    Select Observation Station    Posio Raistakka
    Click List View Button
    Verify Once A Day Reporting Station List View Date
    Terminate All Processes Gracefully    emulator_process    appium_server_process

Verify Active Observation Station List View Elements
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
    Swipe By Percent    50    90    50    10    duration=1500
    Open Observation Stations Dropdown List
    Select Observation Station    Salla Naruska
    Click List View Button
    Verify Active Station List View Date
    Terminate All Processes Gracefully    emulator_process    appium_server_process
