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
Resource         ../resources/search_view_resources.resource
Variables        ../variables/appium_setup_variables.py
Variables        ../variables/onboarding_variables.py
Variables        ../variables/dut_variables.py
Suite Setup      Suite Setup Actions    ${APP_PACKAGE}    app-latest.apk
Suite Teardown   Suite Teardown Actions
Test Setup       Run Skipped Onboarding Process
Test Teardown    Set Default Weather View

*** Test Cases ***
Verify Warnings View Elements
    Verify Location Text From Upper Bar
    Set New Location From Search View    Helsinki
    Open Warnings View