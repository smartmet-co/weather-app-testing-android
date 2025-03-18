*** Settings ***
Documentation    This suite tests fmi mobile weather app search view.
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
Variables        ../variables/search_variables.py
Suite Setup      Suite Setup Actions    ${APP_PACKAGE}    app-latest.apk
Suite Teardown   Suite Teardown Actions
Test Setup       Run Skipped Onboarding Process
Test Teardown    Set Default Weather View

*** Test Cases ***
Verify Search Info View
    Verify Location Text From Upper Bar
    Open Search View
    Open Search Info View
    Verify Search Info View Titles    ${SEARCH_INFO_TITLE_1_EN}    ${SEARCH_INFO_TITLE_2_EN}
    Close Search Info
    Click Navigate Back From Search View
    Verify Location Text From Upper Bar

Save Search Location To My Places
    [Setup]    NONE
    Verify Location Text From Upper Bar    Helsinki
    Open Search View
    Enter Search Location    ${SEARCH_LOCATION_1}
    Save Search Location To My Places From Star Icon    ${SEARCH_LOCATION_1}
    Click Navigate Back From Search View
    Verify Location Text From Upper Bar    Helsinki
    Open Search View
    Clear All My Places
    Click Navigate Back From Search View
    Verify Location Text From Upper Bar    Helsinki

Delete Single Search Location From My Places
    [Setup]    NONE
    Verify Location Text From Upper Bar    Helsinki
    Open Search View
    Enter Search Location    ${SEARCH_LOCATION_1}
    Save Search Location To My Places From Star Icon    ${SEARCH_LOCATION_1}
    Enter Search Location    ${SEARCH_LOCATION_2}
    Save Search Location To My Places From Star Icon    ${SEARCH_LOCATION_2}
    Enter Search Location    ${SEARCH_LOCATION_3}
    Save Search Location To My Places From Star Icon    ${SEARCH_LOCATION_3}
    Delete Single Location From My Places From Star Icon     ${SEARCH_LOCATION_2}
    Verify All My Places Locations    ${SEARCH_LOCATION_1}    ${SEARCH_LOCATION_3}
    Verify Single Previous Searches Location    ${SEARCH_LOCATION_2}    unsaved
    Clear All My Places
    Verify Single Previous Searches Location    ${SEARCH_LOCATION_2}    unsaved
    Clear All Previous Searches
    Click Navigate Back From Search View
    Verify Location Text From Upper Bar    Helsinki