*** Keywords ***
Start Mock Server
    [Arguments]    ${mock_server_dir}
    Start Process    yarn server    shell=True    cwd=${mock_server_dir}    stdout=${CURDIR}/../stdout/mock_debug.txt    alias=mock_server_process

Open Fmi Application With Mock Server
    Run Process    adb    shell    am    start    --es    config    'http://${CONFIG_MOCK_SERVER_DOMAIN}:${CONFIG_MOCK_SERVER_PORT}/config'    -S    -D    fi.fmi.mobileweather/.MainActivity    stdout=${CURDIR}/../stdout/stdout_mock.txt
    ${stdout_file_content}=    Get File    ${CURDIR}/../stdout/stdout_mock.txt
    
Set Mock Server Geolocation
    [Arguments]    ${geolocation}
    ${set_mock_geo_resp}=    PUT    http://localhost:${CONFIG_MOCK_SERVER_PORT}/setup/geolocation/${geolocation}    expected_status=200
    
Set Mock Server Forecast
    [Arguments]    ${forecast}
    ${set_mock_forecast_resp}=    PUT    http://localhost:${CONFIG_MOCK_SERVER_PORT}/setup/forecast/${forecast}    expected_status=200

Stop Mock Server
    ${quit_mock_resp}=    GET    http://localhost:${CONFIG_MOCK_SERVER_PORT}/quit    expected_status=200
    ${terminate_result}=    Terminate Process    mock_server_process
    Process Should Be Stopped    mock_server_process