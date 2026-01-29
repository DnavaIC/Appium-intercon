*** Settings ***
Documentation  steps for home menu page
Library    AppiumLibrary  timeout=10
Library    ../Library/DemoLibrary.py

*** Variables ***
# HEADER
${STARS_CORNER}                  xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.view.View[1]
${PENDING_SHIFTS_TITLE}          xpath=//*[contains(@text,'PENDING SHIFTS') or contains(@content-desc,'PENDING SHIFTS')]
${PENDING_SHIFTS_SCHEDULE}       xpath=//*[@text='SCHEDULE' or @content-desc='SCHEDULE']
${PENDING_SHIFTS_CLOSE_X}        xpath=(//*[@clickable='true' and (@class='android.widget.ImageButton' or @class='android.widget.Button')])[last()]
${HOME_TAB}                      xpath=//*[@content-desc='Home' or @text='Home']
${BTN_CLOCK_IN}                  accessibility_id=CLOCK IN
${MODAL_START_SHIFT}             xpath=//*[contains(@content-desc,'STARTING NEW SHIFT') or contains(@text,'STARTING NEW SHIFT')]
${MODAL_CLOCK_IN_BTN}            path=//*[@content-desc='CLOCK IN' or @text='CLOCK IN' or @content-desc='Clock In' or @text='Clock In']
${STATUS_CLOCKED_IN}             xpath=//*[contains(@content-desc,'CLOCKED IN') or contains(@text,'CLOCKED IN')]
${BTN_CLOCK_OUT}                 xpath=//*[@content-desc='CLOCK OUT' or @text='CLOCK OUT' or contains(@content-desc,'CLOCK OUT') or contains(@text,'CLOCK OUT')]
${HOME_TITLE}                    accessibility_id=Home
${PENDING_SHIFTS_MODAL}          xpath=//*[contains(@content-desc,'PENDING SHIFT') or contains(@text,'PENDING SHIFT')]
${PENDING_SHIFTS_CLOSE_BTN}      xpath=//*[@content-desc='CLOSE' or @text='CLOSE' or @content-desc='Close' or @text='Close']
${PENDING_SHIFTS_CANCEL_BTN}     xpath=//*[@content-desc='CANCEL' or @text='CANCEL' or @content-desc='Cancel' or @text='Cancel']
${PENDING_SHIFTS_X_BTN}          xpath=(//*[@clickable='true' and (@class='android.widget.Button' or @class='android.widget.ImageButton')])[1]


# PROFILE
${ASSIGNED_EQUIPMENT_BTN}     accessibility_id=Assigned\nEquipment
${ASSIGNED_EQUIPMENT_SCREEN}  xpath=//android.view.View[@content-desc]

# SHIFT
${REMAINING_TIME}            //android.view.View[@content-desc][11]
${CLOCK_OUT}                 accessibility_id=CLOCK OUT

# FOOTER
${TOOLS}                    xpath=//android.widget.Button[@content-desc][5]

*** Keywords ***
Verify CLOCK_IN status
    ${is_clocked_in}=    Run Keyword And Return Status    Page Should Contain Text    CLOCKED IN
    Capture Page Screenshot
    IF    not ${is_clocked_in}
        Skip    Status is not CLOCKED IN
    END

Close Pending Shifts Popup If Present
    ${present}=    Run Keyword And Return Status    Page Should Contain Element    ${PENDING_SHIFTS_MODAL}
    Run Keyword If    not ${present}    Return From Keyword

    # Try to close with "CLOSE" (if exists)
    Run Keyword And Ignore Error    Click Element    ${PENDING_SHIFTS_CLOSE_BTN}
    Sleep    1s

    # if the modal still showed and try with "X" button
    ${still}=    Run Keyword And Return Status    Page Should Contain Element    ${PENDING_SHIFTS_MODAL}
    Run Keyword If    ${still}    Run Keyword And Ignore Error    Click Element    ${PENDING_SHIFTS_X_BTN}
    Sleep    1s

    # if the modal still showed , use "CANCEL" button
    ${still}=    Run Keyword And Return Status    Page Should Contain Element    ${PENDING_SHIFTS_MODAL}
    Run Keyword If    ${still}    Run Keyword And Ignore Error    Click Element    ${PENDING_SHIFTS_CANCEL_BTN}
    Sleep    1s


Close Pending Shifts Modal If Present
    ${present}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//*[contains(@content-desc,'PENDING SHIFTS') or contains(@text,'PENDING SHIFTS')]
    Run Keyword If    ${present}    Click Element    accessibility_id=CANCEL
    Run Keyword If    ${present}    Sleep    1s   

Go To Home Tab If Present
    ${present}=    Run Keyword And Return Status    Page Should Contain Element    ${HOME_TAB}
    Run Keyword If    ${present}    Click Element    ${HOME_TAB}
    Run Keyword If    ${present}    Sleep    1s

Home menu is displayed
    Close Pending Shifts Popup If Present
    Run Keyword And Ignore Error    Click Element    xpath=//*[@content-desc='Home' or @text='Home']
    Close Pending Shifts Popup If Present
    Wait Until Element Is Visible    accessibility_id=Home    timeout=20s
    Capture Page Screenshot    

    
Go to Assigned Equipment
    [Documentation]    Go to profile > click assigned equipment
    Click Element    ${STARS_CORNER}
    Wait Until Element Is Visible    ${ASSIGNED_EQUIPMENT_BTN}    timeout=10
    Click Element    ${ASSIGNED_EQUIPMENT_BTN}
    Capture Page Screenshot

Check user with no equipment assigned
    [Documentation]    Check empty list message
    Sleep    10s
    Capture Page Screenshot
    Wait Until Element Is Visible    ${ASSIGNED_EQUIPMENT_SCREEN}    timeout=10
    Get Element Attribute    ${ASSIGNED_EQUIPMENT_SCREEN}    attribute=content-desc
    Page Should Contain Text    No equipment assigned

# Get remaining time
#     [Documentation]    Get home screen remaining time of the shift
#     ${TIME_STRING}=    Get Element Attribute    ${REMAINING_TIME}    content-desc
#     ${TOTAL_MINUTES}=    Get Total Minutes    ${TIME_STRING}    # Custom Library
#     Set Suite Variable    ${TOTAL_MINUTES}
#     Capture Page Screenshot

Get remaining time
    [Documentation]    Get home screen remaining time of the shift
    ${TIME_STRING}=    Get Element Attribute    ${REMAINING_TIME}    content-desc
    Set Suite Variable    ${TIME_STRING}
    ${TOTAL_MINUTES}=    Get Total Minutes    ${TIME_STRING}
    Set Suite Variable    ${TOTAL_MINUTES}

Verify early Clock-Out time
    Wait Until Element Is Visible    ${CLOCK_OUT}    timeout=10
    Click Element    ${CLOCK_OUT}
    Page Should Contain Text    ${TOTAL_MINUTES}
    Capture Page Screenshot

Navigate to Tools Section
    [Documentation]    Navigate to Tools section from home menu
    Click Element    ${TOOLS}
    Sleep    3s
    Capture Page Screenshot


# apartide de aqui modifique 
Start Shift From Home
    [Documentation]    Navigate to Home, close popups, and clock in if not already clocked in.

    Close Pending Shifts Popup If Present
    ${on_home}=    Run Keyword And Return Status    Page Should Contain Element    ${HOME_TITLE}
    Run Keyword If    not ${on_home}    Go To Home Tab If Present
    Close Pending Shifts Popup If Present

    Wait Until Element Is Visible    ${HOME_TITLE}    timeout=20s
    Capture Page Screenshot

    ${already_in}=    Run Keyword And Return Status    Page Should Contain Element    ${BTN_CLOCK_OUT}
    Run Keyword If    ${already_in}    Return From Keyword

    Wait Until Page Contains Element    ${BTN_CLOCK_IN}    timeout=20s
    Click Element    ${BTN_CLOCK_IN}
    Capture Page Screenshot

    Run Keyword And Ignore Error    Wait Until Page Contains Element
    ...    xpath=//*[contains(@content-desc,'STARTING NEW SHIFT') or contains(@text,'STARTING NEW SHIFT')]
    ...    5s
    Run Keyword And Ignore Error    Click Element
    ...    xpath=//*[@content-desc='CLOCK IN' or @text='CLOCK IN' or @content-desc='Clock In' or @text='Clock In']
    Capture Page Screenshot


Verify user is Clocked In
    [Documentation]    Verify user is successfully clocked in from Home screen
    Wait Until Page Contains Element
    ...    xpath=//*[contains(@content-desc,'CLOCKED IN') or contains(@text,'CLOCKED IN')]
    ...    timeout=20s

    Capture Page Screenshot
