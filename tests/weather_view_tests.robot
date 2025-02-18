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
Resource         ../resources/search_view_resources.resource
Variables        ../variables/appium_setup_variables.py
Variables        ../variables/onboarding_variables.py
Variables        ../variables/dut_variables.py
Variables        ../variables/config_variables.py
Suite Setup      Suite Setup Actions    ${APP_PACKAGE}    app-latest.apk
Suite Teardown   Suite Teardown Actions
Test Setup       Run Skipped Onboarding Process
Test Teardown    Set Default Weather View

*** Test Cases ***
Verify 10-day Forecast Table View Elements
    Verify Location Text From Upper Bar
    Set New Location From Search View    Helsinki
    Verify Forecast Time
    Verify Forecast Length    10
    Verify Table View Is Active
    Verify Parameters Button Is Enabled
    Verify Parameters Info Button Is Enabled

Verify 10-day Forecast Graph View Elements
    [Setup]    NONE
    Verify Location Text From Upper Bar
    Verify Table View Is Active
    Verify Parameters Button Is Enabled
    Verify Parameters Info Button Is Enabled
    Click Chart Button
    Verify Graph View Is Active
    Verify Parameters Button Is Disabled
    Verify Parameters Info Button Is Disabled
    Click Table Button
    Verify Table View Is Active

Verify Parameters View Opens
    [Setup]    NONE
    Verify Location Text From Upper Bar
    Verify Table View Is Active
    Click Parameters Button
    Verify Parameters View
    Click Parameters Close Button
    Verify Table View Is Active

Verify Parameters Info View Opens
    [Setup]    NONE
    Verify Location Text From Upper Bar
    Verify Table View Is Active
    Click Parameters Info Button
    Verify Parameters Info View
    Click Parameters Info Close Button
    Verify Table View Is Active

Verify 10-day Forecast Horizontal Scroll Bar
    [Setup]    NONE
    Verify Location Text From Upper Bar
    Verify First Date Of Forecast At Horizontal Scroll Bar
    Scroll Forecast Horizontal Scroll Bar To Right 3 Times
    Verify Last Date Of Forecast At Horizontal Scroll Bar

Verify Observation Stations Are Active Stations
    [Setup]    NONE
    Verify Location Text From Upper Bar
    Swipe By Percent    50    90    50    10    duration=1500
    Open Observation Stations Dropdown List
    Verify Observation Stations Are Active Stations
    [Teardown]    Set Default Weather View After Observation Station Test

Verify Observation Stations Are Once In A Day Reporting Stations
    [Setup]    NONE
    Verify Location Text From Upper Bar
    Set New Location From Search View    Savukoski
    Swipe By Percent    50    90    50    10    duration=1500
    Open Observation Stations Dropdown List
    Verify Observation Stations Are Once In A Day Reporting Stations
    [Teardown]    Set Default Weather View After Observation Station Test

Verify Once A Day Reporting Observation Station List View Elements
    [Setup]    NONE
    Verify Location Text From Upper Bar
    Set New Location From Search View    Posio
    Swipe By Percent    50    90    50    10    duration=1500
    Open Observation Stations Dropdown List
    Select Observation Station    Posio Raistakka
    Click Observation Station List View Button
    Verify Once A Day Reporting Station List View Date
    [Teardown]    Set Default Weather View After Observation Station Test

Verify Active Observation Station List View Elements
    [Setup]    NONE
    Verify Location Text From Upper Bar
    Set New Location From Search View    Savukoski
    Swipe By Percent    50    90    50    10    duration=1500
    Open Observation Stations Dropdown List
    Select Observation Station    Salla Naruska
    Click Observation Station List View Button
    Verify Active Station List View Date
    [Teardown]    Set Default Weather View After Observation Station Test