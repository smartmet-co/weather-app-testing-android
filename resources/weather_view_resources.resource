*** Keywords ***
Open Weather View
    Wait Until Page Contains Element    xpath=//*[@resource-id='navigation_weather']
    Click Element                       xpath=//*[@resource-id='navigation_weather']
    Wait Until Page Contains Element    xpath=//*[@resource-id='params_button']

Click Weather Button On Navigation Bar
    Wait Until Element Is Visible    xpath=//android.view.View[@resource-id="navigation_weather"]
    Click Element    xpath=//android.view.View[@resource-id="navigation_weather"]

Click Locate Button
    Click Element    xpath=//android.widget.Button[@content-desc="Locate"]
    
Double Click Locate Button
    FOR    ${index}    IN RANGE    1    3
        Click Element    xpath=//android.widget.Button[@content-desc="Locate"]
        Sleep    10
    END

Verify Location Text From Upper Bar
    [Arguments]    ${manual_location_text}=xxx
    ${is_ci_env}=    Verify Environment
    ${text}=    Set Variable If
    ...    ${is_ci_env}==${TRUE} and '${manual_location_text}'=='xxx'     ${CI_DEFAULT_LOCATION}
    ...    ${is_ci_env}==${FALSE} and '${manual_location_text}'=='xxx'    ${LOCAL_DEFAULT_LOCATION}
    ...    '${manual_location_text}'!='xxx'    ${manual_location_text}
    TRY
        Wait Until Page Contains Element    xpath=//android.view.ViewGroup[contains(@content-desc,"${text}")]    timeout=20
    EXCEPT     	Element * did not appear in *    type=GLOB
        Double Click Locate Button
    FINALLY
        Wait Until Page Contains Element    xpath=//android.view.ViewGroup[contains(@content-desc,"${text}")]    timeout=20
    END
    
Verify Forecast Time
    ${next_hour}=    Get Next Full Hour With Timezone
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="at ${next_hour}"]    timeout=15

Verify Forecast Length
    [Arguments]    ${length}
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="${length}-day forecast"]
    
Verify ${view_type} View Is Active
    IF    '${view_type}'=='Table'
        Wait Until Page Contains Element    xpath=//android.widget.ScrollView[@resource-id="weather_scrollview"]/android.view.ViewGroup/android.view.ViewGroup[7]/android.view.ViewGroup[2]
        Wait Until Page Contains Element    xpath=//android.widget.ScrollView[@resource-id="weather_scrollview"]/android.view.ViewGroup/android.view.ViewGroup[7]/android.widget.HorizontalScrollView[2]/android.view.ViewGroup
        Wait Until Element Is Visible       xpath=//android.widget.ScrollView[@resource-id="weather_scrollview"]/android.view.ViewGroup/android.view.ViewGroup[7]/android.widget.HorizontalScrollView[2]/android.view.ViewGroup
    ELSE IF    '${view_type}'=='Graph'
        Wait Until Page Contains Element    xpath=//android.view.ViewGroup[@resource-id="forecast_chart"]
        Wait Until Element Is Visible       xpath=//android.view.ViewGroup[@resource-id="forecast_chart"]
    END
    
Click ${view_type} Button
    IF    '${view_type}'=='Locate'    Sleep    10
    Click Element    xpath=//android.widget.Button[@resource-id="forecast_${view_type.lower()}_button"]
    Sleep    0.5

Click Parameters Info Button
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id="info_button" and @enabled="true"]
    Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id="info_button" and @enabled="true"]
    Click Element    xpath=//android.widget.Button[@resource-id="info_button"]

Click Parameters Info Close Button
    Click Element    xpath=//android.widget.Button[@resource-id="weather_info_bottom_sheet_close_button"]
    Wait Until Page Does Not Contain Element    xpath=//android.widget.Button[@resource-id="weather_info_bottom_sheet_close_button"]

Click Parameters Button
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id="params_button" and @enabled="true"]
    Click Element    xpath=//android.widget.Button[@resource-id="params_button"]

Click Close Observation Stations List Button
    Sleep    2
    ${close_button_count}=    Get Matching Xpath Count    //android.widget.Button[@content-desc="Close hourly parameter selection"]
    IF    ${close_button_count}==${1}
        Wait Until Page Contains Element    xpath=//android.widget.Button[@content-desc="Close hourly parameter selection"]
        Click Element    xpath=//android.widget.Button[@content-desc="Close hourly parameter selection"]
        Wait Until Page Does Not Contain Element    xpath=//android.widget.Button[@content-desc="Close hourly parameter selection"]
    ELSE
        Element Should Be Visible    xpath=//android.view.View[contains(@content-desc,'Observation station:')]/android.view.ViewGroup
    END

Click Observation Station List View Button
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='observation_list_button']
    Click Element                       xpath=//android.widget.Button[@resource-id='observation_list_button']
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='observation_list_button' and @selected='true']

Click Observation Station Graph View Button
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='observation_chart_button']
    Click Element                       xpath=//android.widget.Button[@resource-id='observation_chart_button']
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id='observation_chart_button' and @selected='true']

Verify Parameters Info View
    Wait Until Page Contains Element    xpath=//android.view.ViewGroup[@resource-id="weather_info_bottom_sheet"]
    Page Should Contain Element         xpath=//android.widget.TextView[@text="Precipitation bar explanations"]
    Page Should Contain Element         xpath=//android.widget.TextView[@text="Hourly forecast info"]

Verify Parameters View
    Wait Until Page Contains Element    xpath=//android.view.ViewGroup[@resource-id="weather_params_bottom_sheet"]
    Page Should Contain Element         xpath=//android.view.View[@text="Hourly view"]
    Page Should Contain Element         xpath=//android.widget.TextView[@text="Choose parameters to display in hourly view"]

Click Parameters Close Button
    Click Element    xpath=//android.widget.Button[@resource-id="weather_params_bottom_sheet_close_button"]
    Wait Until Page Does Not Contain Element    xpath=//android.widget.Button[@resource-id="weather_params_bottom_sheet_close_button"]

Verify ${date_type} Date Of Forecast At Horizontal Scroll Bar
    [Arguments]    ${days_ahead}=9    ${format}=%a %-d %b    ${index}=1
    ${is_ci_env}=    Verify Environment
    ${format}=    Set Variable If    ${is_ci_env}==${FALSE}    ${format.replace('-', '#')}    ${format}
    IF    '${date_type}'=='First'
        ${date}=    Get Current Date    ${format}
        Wait Until Page Contains Element    xpath=//android.widget.ScrollView[@resource-id="weather_scrollview"]//android.widget.HorizontalScrollView[1]//android.widget.Button[1]//android.widget.TextView[1]
        ${ui_date}=    Get Text    xpath=//android.widget.ScrollView[@resource-id="weather_scrollview"]//android.widget.HorizontalScrollView[1]//android.widget.Button[1]//android.widget.TextView[1]
    ELSE IF    '${date_type}'=='Last'
        ${date}=    Get Future Date    ${days_ahead}    ${format}
        Wait Until Page Contains Element    xpath=//android.widget.ScrollView[@resource-id="weather_scrollview"]//android.widget.HorizontalScrollView[1]//android.widget.Button[last()]//android.widget.TextView[1]
        ${ui_date}=    Get Element Attribute    xpath=//android.widget.ScrollView[@resource-id="weather_scrollview"]//android.widget.HorizontalScrollView[1]//android.widget.Button[last()]//android.widget.TextView[1]    text
    ELSE IF    '${date_type}'=='Any'
        ${date}=    Get Future Date    ${days_ahead}    ${format}
        Wait Until Page Contains Element    xpath=//android.widget.ScrollView[@resource-id="weather_scrollview"]//android.widget.HorizontalScrollView[1]//android.widget.Button[${index}]//android.widget.TextView[1]
        ${ui_date}=    Get Element Attribute    xpath=//android.widget.ScrollView[@resource-id="weather_scrollview"]//android.widget.HorizontalScrollView[1]//android.widget.Button[${index}]//android.widget.TextView[1]    text
    END
    Should Be Equal    ${date}    ${ui_date}

Verify Parameters Button Is ${state}
    IF    '${state}'=='Enabled'
        Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id="params_button" and @enabled="true"]
    ELSE IF    '${state}'=='Disabled'
        Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id="params_button" and @enabled="false"]
    END

Verify Parameters Info Button Is ${state}
    IF    '${state}'=='Enabled'
        Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id="info_button" and @enabled="true"]
    ELSE IF    '${state}'=='Disabled'
        Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id="info_button" and @enabled="false"]
    END

Scroll Forecast Horizontal Scroll Bar To ${direction} ${how_many_times} Times
    FOR    ${index}    IN RANGE    1    ${how_many_times} + 1
        IF    '${direction}'=='Right'
            Scroll
            ...    xpath=//android.widget.ScrollView[@resource-id="weather_scrollview"]//android.widget.HorizontalScrollView[1]//android.widget.Button[4]
            ...    xpath=//android.widget.ScrollView[@resource-id="weather_scrollview"]//android.widget.HorizontalScrollView[1]//android.widget.Button[1]
        ELSE IF    '${direction}'=='Left'
            Scroll
            ...    xpath=//android.widget.ScrollView[@resource-id="weather_scrollview"]//android.widget.HorizontalScrollView[1]//android.widget.Button[1]
            ...    xpath=//android.widget.ScrollView[@resource-id="weather_scrollview"]//android.widget.HorizontalScrollView[1]//android.widget.Button[4]
        END
    END

Open Observation Stations Dropdown List
    Click Element    xpath=//android.view.View[contains(@content-desc,'Observation station:')]/android.view.ViewGroup
    
Select Observation Station
    [Arguments]    ${station_name}
    Wait Until Element Is Visible    xpath=//android.view.ViewGroup[starts-with(@content-desc,"${station_name}")]
    ${is_selected}=    Get Element Attribute    xpath=//android.view.ViewGroup[starts-with(@content-desc,"${station_name}")]    selected
    IF    '${is_selected}'=='false'
        Click Element    xpath=//android.view.ViewGroup[starts-with(@content-desc,"${station_name}")]
    ELSE
        Click Close Observation Stations List Button
    END
    Wait Until Page Contains Element    xpath=//android.view.View[contains(@content-desc,"Observation station: ${station_name}")]

Return Observation Station ${sort_type} Distance List
    Wait Until Element Is Visible    xpath=//android.widget.Button[@content-desc="Close hourly parameter selection"]/following-sibling::android.view.ViewGroup[last()]
    @{observation_station_webelement_list}=    Get Webelements    xpath=//android.widget.Button[@content-desc="Close hourly parameter selection"]/following-sibling::android.view.ViewGroup/android.widget.TextView
    @{sorted_observation_stations_distance_list}=      Create List
    @{unsorted_observation_stations_distance_list}=    Create List
    @{observation_stations_text_list}=    Create List
    @{observation_stations_distance_list}=    Create List
    FOR    ${webelement}    IN    @{observation_station_webelement_list}
        ${text}=    Get Element Attribute    ${webelement}    text
        ${km}=      Get Float From String    ${text}
        Append To List    ${observation_stations_text_list}    ${text}
        Append To List    ${observation_stations_distance_list}    ${km}
    END
    IF    '${sort_type}'=='Sorted'
        @{sorted_observation_stations_distance_list}=    Get Sorted Or Not Sorted Items From List    ${observation_stations_distance_list}    sorted
        RETURN    ${observation_stations_text_list}    ${sorted_observation_stations_distance_list}
    ELSE IF    '${sort_type}'=='Unsorted'
        @{unsorted_observation_stations_distance_list}=    Get Sorted Or Not Sorted Items From List    ${observation_stations_distance_list}    unsorted
        RETURN    ${observation_stations_text_list}    ${unsorted_observation_stations_distance_list}
    END

Verify Observation Stations Are Active Stations
    ${observation_stations_text_list}    ${sorted_observation_stations_distance_list}    Return Observation Station Sorted Distance List
    FOR    ${km}    IN    @{sorted_observation_stations_distance_list}
        ${km}=    Return Even Number As Integer If Float Is Even    ${km}
        ${station_text}    Get Item From List If Item Contains Str    ${observation_stations_text_list}    ${km}
        Wait Until Element Is Visible    xpath=//android.view.ViewGroup[contains(@content-desc,"distance ${{str(${km})}} km")]
        ${is_selected}=    Get Element Attribute    xpath=//android.view.ViewGroup[contains(@content-desc,"distance ${{str(${km})}} km")]    selected
        IF    '${is_selected}'=='false'
            Click Element    xpath=//android.view.ViewGroup[contains(@content-desc,"distance ${{str(${km})}} km")]
        ELSE
            Click Close Observation Stations List Button
        END
        Wait Until Page Contains Element    xpath=//android.view.View[@content-desc="Observation station: ${station_text}"]/following-sibling::android.view.ViewGroup/android.widget.TextView[@text="Latest weather observation"]    timeout=10
        Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id='observation_list_button']/following-sibling::android.widget.HorizontalScrollView//android.widget.Button[last()]    timeout=10
        ${xpath_count}=    Get Matching Xpath Count    //android.widget.Button[@resource-id='observation_list_button']/following-sibling::android.widget.HorizontalScrollView//android.widget.Button
        Should Be True    ${xpath_count} >= 1
        Open Observation Stations Dropdown List
    END

Verify Observation Stations Are Once In A Day Reporting Stations
    ${observation_stations_text_list}    ${observation_stations_distance_list}    Return Observation Station Unsorted Distance List
    FOR    ${km}    IN    @{observation_stations_distance_list}
        ${km}=    Return Even Number As Integer If Float Is Even    ${km}
        ${station_text}    Get Item From List If Item Contains Str    ${observation_stations_text_list}    ${km}
        Wait Until Element Is Visible    xpath=//android.view.ViewGroup[contains(@content-desc,"distance ${{str(${km})}} km")]
        ${is_selected}=    Get Element Attribute    xpath=//android.view.ViewGroup[contains(@content-desc,"distance ${{str(${km})}} km")]    selected
        IF    '${is_selected}'=='false'
            Click Element    xpath=//android.view.ViewGroup[contains(@content-desc,"distance ${{str(${km})}} km")]
        ELSE
            Click Close Observation Stations List Button
        END
        Page Should Not Contain Element    xpath=//android.view.View[@content-desc="Observation station: ${station_text}"]/following-sibling::android.view.ViewGroup/android.widget.TextView[@text="Latest weather observation"]
        Page Should Not Contain Element    xpath=//android.widget.Button[@content-desc="Parameter: Weather"]
        Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id='observation_list_button']/following-sibling::android.widget.HorizontalScrollView//android.widget.Button
        Xpath Should Match X Times    //android.widget.Button[@resource-id='observation_list_button']/following-sibling::android.widget.HorizontalScrollView//android.widget.Button    2
        Open Observation Stations Dropdown List
    END

Verify Once A Day Reporting Station List View Date
    [Arguments]    ${date_format}=%A %-d %b
    ${is_ci_env}=    Verify Environment
    ${date_format}=    Set Variable If    ${is_ci_env}==${FALSE}    ${date_format.replace('-', '#')}    ${date_format}
    ${current_date}=    Get Current Date    ${date_format}
    Wait Until Element Is Visible    xpath=//android.view.ViewGroup[contains(@resource-id,"observation_list_header")]/preceding-sibling::android.widget.TextView[@text='${current_date}']
    
Verify Active Station List View Date
    [Arguments]    ${date_format}=%a %-d.%-m.
    ${is_ci_env}=    Verify Environment
    ${date_format}=    Set Variable If    ${is_ci_env}==${FALSE}    ${date_format.replace('-', '#')}    ${date_format}
    ${current_date}=    Get Current Date    ${date_format}
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text="Latest weather observation"]/following-sibling::android.widget.TextView[contains(@text,"${current_date} at ")]

Set Default Weather View
    Swipe Down    ${5}    start_y=300    end_y=700
    Open Weather View
    Swipe Down    ${1}    start_y=300    end_y=700
    Click Table Button
    Verify Table View Is Active
    Set New Location From Search View    Helsinki

Set Default Weather View After Observation Station Test
    Click Close Observation Stations List Button
    Click Observation Station Graph View Button
    Swipe Down    ${5}    start_y=300    end_y=700
    Open Weather View
    Swipe Down    ${1}    start_y=300    end_y=700
    Click Table Button
    Verify Table View Is Active
    Set New Location From Search View    Helsinki