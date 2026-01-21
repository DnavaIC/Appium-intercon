*** Settings ***
Documentation  Steps for Tools section Page
Library    AppiumLibrary

*** Variables ***
${SHIFT_TAB}              xpath=//*[@content-desc='Shift' or @text='Shift']
${VEHICLE_INSPECTION}     xpath=//*[contains(@content-desc,'Vehicle Inspection')]
${EQUIPMENT_ID}           xpath=(//android.widget.EditText)[1]
${MILEAGE_AT_START}       xpath=(//android.widget.EditText)[2]
${GAS_AT_START}           accessibility_id=Gas at Start
${EXTERIOR_APPEARANCE}    accessibility_id=Exterior Appearance
${INTERIOR_APPEARANCE}    accessibility_id=Interior Appearance
${ADDITIONAL_NOTES}       xpath=(//android.widget.EditText)[1]
${WEAPONS_INVENTORY}      //*[contains(@content-desc, 'Weapons Inventory')]
${INCIDENTS}              //*[contains(@content-desc, 'Incidents')]
${SERIAL_NUMBER_INPUT}    android=new UiSelector().className("android.widget.EditText").instance(0)
${DESCRIPTION_INPUT}      android=new UiSelector().className("android.widget.EditText").instance(1)
${NO_PICTURE_ERROR}       xpath=//*[contains(@text,'Please upload') or contains(@content-desc,'Please upload')]
${REPORT_INCIDENT_BTN}    xpath=//*[@content-desc='REPORT INCIDENT' or @text='REPORT INCIDENT']
${SUBMIT_BTN}             xpath=//*[@content-desc='SUBMIT' or @text='SUBMIT' or contains(@content-desc,'SUBMIT') or contains(@text,'SUBMIT')]


*** Keywords ***

# SHIFT TOOLS SECTION
Navigate to Shift tools section
    Wait Until Element Is Visible    ${SHIFT_TAB}   timeout=20s
    Click Element    ${SHIFT_TAB}
    Capture Page Screenshot

Click Vehicle Inspection
    Wait Until Element Is Visible    ${VEHICLE_INSPECTION}    timeout=10s
    Click Element    ${VEHICLE_INSPECTION}
    Capture Page Screenshot 

Click Weapon Inventory
    Wait Until Element Is Visible    ${WEAPONS_INVENTORY}   timeout=10s
    Click Element    ${WEAPONS_INVENTORY}
    Capture Page Screenshot     

Click Incidents
    Wait Until Element Is Visible    ${INCIDENTS}   timeout=10s
    Click Element    ${INCIDENTS}
    Capture Page Screenshot       


Fill all Weapons inputs
    Click Element    ${SERIAL_NUMBER_INPUT}
    Input Text    ${SERIAL_NUMBER_INPUT}    QA Automated test
    Go Back
    Click Element    ${DESCRIPTION_INPUT}
    Input Text    ${DESCRIPTION_INPUT}    Lorem ipsum dolor sit amet consectetur adipiscing elit.
    Go Back
    Capture Page Screenshot

Fill all Vehicle inputs
    Wait Until Page Contains Element    ${EQUIPMENT_ID}    20s
    Click Element    ${EQUIPMENT_ID}
    Run Keyword And Ignore Error    Clear Text    ${EQUIPMENT_ID}
    Input Text    ${EQUIPMENT_ID}    1234455678
    Run Keyword And Ignore Error    Hide Keyboard

    Click Element    ${MILEAGE_AT_START}
    Run Keyword And Ignore Error    Clear Text    ${MILEAGE_AT_START}
    Input Text    ${MILEAGE_AT_START}    23
    Run Keyword And Ignore Error    Hide Keyboard

    Click Element    ${GAS_AT_START}
    Wait Until Page Contains Element    xpath=//*[@text='Full' or @content-desc='Full']    10s
    Click Element    xpath=//*[@text='Full' or @content-desc='Full']

    Swipe    540    1900    540    700    800
    Click Element  ${EXTERIOR_APPEARANCE}
    Wait Until Page Contains Element    xpath=//*[@text='Good' or @content-desc='Good']    10s
    Click Element    xpath=//*[@text='Good' or @content-desc='Good']

    Click Element    ${INTERIOR_APPEARANCE}
    Wait Until Page Contains Element    xpath=//*[@text='Good' or @content-desc='Good']    10s
    Click Element    xpath=//*[@text='Good' or @content-desc='Good']

   Swipe    540    1900    540    700    800
    Click Element  ${ADDITIONAL_NOTES}
    Run Keyword And Ignore Error    Clear Text    ${ADDITIONAL_NOTES}
    Input Text    ${ADDITIONAL_NOTES}    test
    Run Keyword And Ignore Error    Hide Keyboard

    Capture Page Screenshot

Tap Report incident button
    Wait Until Element Is Visible    ${REPORT_INCIDENT_BTN}    
    Click Element    ${REPORT_INCIDENT_BTN}
    Capture Page Screenshot


Tap Submit button
    [Documentation]    Scrolls down until SUBMIT is visible and taps it

    FOR    ${i}    IN RANGE    0    8
        ${found}=    Run Keyword And Return Status    Page Should Contain Element    ${SUBMIT_BTN}
        IF    ${found}
            Wait Until Element Is Visible    ${SUBMIT_BTN}    timeout=5s
            Click Element    ${SUBMIT_BTN}
            Capture Page Screenshot
            Return From Keyword
        END
        Swipe    540    2000    540    700    800
        Sleep    1s
    END

    Log Source
    Capture Page Screenshot
    Fail    SUBMIT button not found after scrolling


Validate error message when subitting without picture
    [Documentation]    Validate banner/toast error when submitting without photos
    Wait Until Page Contains Element    ${NO_PICTURE_ERROR}    timeout=10s
    Capture Page Screenshot
    Page Should Contain Text    Please upload
