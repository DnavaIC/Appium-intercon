*** Settings ***
Documentation  steps for login page
Library  AppiumLibrary  timeout=10
Resource    ../utils/appiumDriver.robot
Resource    ../mobile-pages/home-menu.robot

*** Variables ***
${WHILE_USING_APP}         //*[contains(@resource-id, 'permission_allow_foreground_only_button')]
${ALLOW_ALERT}             //*[contains(@resource-id, 'permission_allow_button')]
${CONFIGURE_LOCATION}      //*[contains(@resource-id, 'btn_positive_action')]
${ALLOW_ALL_TIME}          //*[contains(@resource-id, 'allow_always_radio_button')]
${ANDROID_BACK}            //*[contains(@class, 'ImageButton')]
${PHONE_INPUT_EDITTEXT}    xpath=(//android.widget.EditText | //android.widget.AutoCompleteTextView)[1]
${PHONE_INPUT_TEXT}        xpath=//*[@text='(987) 654-3111']
${PHONE_INPUT_CLICKABLE}   xpath=//*[@focusable='true' and (@clickable='true' or @long-clickable='true')][1]
${NOTIF_ALLOW_TEXT}        xpath=//*[@text='Allow' or @text='ALLOW']
${NOTIF_DENY_TEXT}         xpath=//*[@text="Don't allow" or @text="DON'T ALLOW" or @text="Don’t allow"]
${NOTIF_ALLOW_ID}          xpath=//*[contains(@resource-id,'permission_allow_button')]
${NOTIF_DENY_ID}           xpath=//*[contains(@resource-id,'permission_deny_button')]
${CONTINUE_LOGIN}          xpath=//*[@content-desc='CONTINUE' or @text='CONTINUE' or @text='Continue' or @content-desc='Continue']
${LABEL_HOME}              accessibility_id=Home
${CLOSE_WINDOW}            //android.view.View[@content-desc="CONFIRM SHIFT"]/android.widget.Button
${INVALID_NUMBER}          //android.view.View[@content-desc="Invalid phone number"]
${CALLS_ALLOW_TEXT}        xpath=//*[@text='Allow' or @content-desc='Allow']
${CALLS_DENY_TEXT}        xpath=//*[@text="Don't allow" or @content-desc="Don't allow"]

*** Keywords ***
Accept android location permission
  ${present}=    Run Keyword And Return Status    Page Should Contain Element    ${WHILE_USING_APP}
  Run Keyword If    ${present}    Click Element  ${WHILE_USING_APP}

Accept android activity permission
  ${present}=    Run Keyword And Return Status    Page Should Contain Element    ${ALLOW_ALERT}
  Run Keyword If    ${present}    Click Element  ${ALLOW_ALERT}


Configure all time location
  ${present}=    Run Keyword And Return Status    Page Should Contain Element    ${CONFIGURE_LOCATION}
  Run Keyword If    not ${present}    Return From Keyword
  Wait Until Element Is Visible    ${CONFIGURE_LOCATION}    timeout=5s
  Capture Page Screenshot
  Click Element  ${CONFIGURE_LOCATION}
  ${all_time_present}=    Run Keyword And Return Status    Page Should Contain Element    ${ALLOW_ALL_TIME}
  Run Keyword If    ${all_time_present}    Click Element    ${ALLOW_ALL_TIME}
  Run Keyword And Ignore Error    Click Element  ${ANDROID_BACK}
  Capture Page Screenshot

Get Phone Input Locator
  ${has_edit}=    Run Keyword And Return Status    Page Should Contain Element    ${PHONE_INPUT_EDITTEXT}
  Run Keyword If    ${has_edit}    Return From Keyword    ${PHONE_INPUT_EDITTEXT}
  ${has_text}=    Run Keyword And Return Status    Page Should Contain Element    ${PHONE_INPUT_TEXT}
  Run Keyword If    ${has_text}    Return From Keyword    ${PHONE_INPUT_TEXT}
  Return From Keyword    ${PHONE_INPUT_CLICKABLE}

Accept notifications permission if present
  Run Keyword And Ignore Error    Wait Until Page Contains Element    ${NOTIF_ALLOW_TEXT}    3s
  Run Keyword And Ignore Error    Click Element    ${NOTIF_ALLOW_TEXT}
  Run Keyword And Ignore Error    Wait Until Page Contains Element    ${NOTIF_ALLOW_ID}      3s
  Run Keyword And Ignore Error    Click Element    ${NOTIF_ALLOW_ID}

Input VALID phone number
  [Documentation]    Input valid phone number from environment variables
  Accept notifications permission if present
  ${phone}=    Get Phone Input Locator
  Wait Until Element Is Visible    ${phone}    timeout=30s
  Click Element    ${phone}
  Run Keyword And Ignore Error    Clear Text    ${phone}
  Input Text       ${phone}    %{PHONE_NUMBER}
  Run Keyword And Ignore Error    Hide Keyboard
  Capture Page Screenshot
  Click Element    ${CONTINUE_LOGIN}
  # this permission sometimes shows it is optional
  Run Keyword And Ignore Error    Wait Until Element Is Visible    ${ALLOW_ALERT}    timeout=3s
  Run Keyword And Ignore Error    Click Element    ${ALLOW_ALERT}


Open App And Dismiss Permissions
  Android Inter-con security Application KIOSK-NA
  Accept android location permission
  Accept android activity permission
  Accept notifications permission if present
  Configure all time location


Input WRONG phone number
  [Documentation]    Input wrong phone number from environment variables
  Accept notifications permission if present

  ${phone}=    Get Phone Input Locator
  Wait Until Element Is Visible    ${phone}    timeout=30s
  Click Element    ${phone}
  Run Keyword And Ignore Error    Clear Text    ${phone}
  Input Text       ${phone}    %{WRONG_PHONE_NUMBER}
  Run Keyword And Ignore Error    Hide Keyboard
  Capture Page Screenshot

Tap continue login button
  Wait Until Element Is Visible    ${CONTINUE_LOGIN}    timeout=30s
  Click Element    ${CONTINUE_LOGIN}

Allow calls alert
  Run Keyword And Ignore Error    Wait Until Element Is Visible    ${ALLOW_ALERT}    timeout=3s
  Run Keyword And Ignore Error    Click Element    ${ALLOW_ALERT}

Verify error message when wrong number is input
  [Documentation]    Verify error message when wrong phone number is input
  Wait Until Element Is Visible    ${INVALID_NUMBER}    timeout=30s
  Capture Page Screenshot
  Page Should Contain Text    Invalid phone number

Close confirm shift notification
  Sleep    5s
  Run Keyword And Ignore Error    Wait Until Element Is Visible    ${CLOSE_WINDOW}    timeout=5s
  Run Keyword And Ignore Error    Click Element    ${CLOSE_WINDOW}
  
Login to Inter-Con App
    Accept android location permission
    Accept android activity permission
    Accept notifications permission if present
    Configure all time location
    Input VALID phone number
    Tap continue login button
    Allow calls alert
    Close Pending Shifts Modal If Present
    Close confirm shift notification