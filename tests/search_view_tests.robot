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