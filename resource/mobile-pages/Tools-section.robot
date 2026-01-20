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
${SERIAL_NUMBER_INPUT}    android=new UiSelector().className("android.widget.EditText").instance(0)
${DESCRIPTION_INPUT}      android=new UiSelector().className("android.widget.EditText").instance(1)
${SUBMIT_BTN}             accessibility_id=SUBMIT
${NO_PICTURE_ERROR}       xpath=//*[contains(@text,'Please upload') or contains(@content-desc,'Please upload')]

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

Tap Submit button
    Click Element    accessibility_id=SUBMIT
    Sleep    1s
    Log Source
    Capture Page Screenshot


Validate error message when subitting without picture
    [Documentation]    Validate banner/toast error when submitting without photos
    Wait Until Page Contains Element    ${NO_PICTURE_ERROR}    timeout=10s
    Capture Page Screenshot
    Page Should Contain Text    Please upload
