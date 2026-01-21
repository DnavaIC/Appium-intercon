*** Settings ***
# Pages
Resource        ../../resource/mobile-pages/login-kiosk-NA.robot
Resource        ../../resource/mobile-pages/home-menu.robot
Resource        ../../resource/mobile-pages/Tools-section.robot
Resource        ../../resource/utils/appiumDriver.robot

Test Teardown   Shut down App


*** Test Cases ***
Input Wrong Phone Number
    [Documentation]    Input wrong phone number from environment variables
    ...    Pre-conditions: Android Inter-con security Application KIOSK-NA
    [Tags]    test
    GIVEN Android Inter-con security Application KIOSK-NA
    AND Accept android location permission
    AND Accept android activity permission
    AND Accept notifications permission if present
    AND Configure all time location
    WHEN Input WRONG phone number
    AND Tap continue login button
    THEN Verify error message when wrong number is input
    

Verify No picture error message is displayed in Vehicle Inspection
    [Documentation]    Submit weapon form without picture
    ...    Pre-conditions: No preconditions
    [Tags]    demo    mobile
    GIVEN Android Inter-con security Application KIOSK-NA
    AND Login to Inter-Con App
    WHEN Home menu is displayed
    AND Close Pending Shifts Popup If Present
    AND Navigate to Tools Section
    AND Navigate to Shift tools section
    AND Click Vehicle Inspection
    AND Fill all Vehicle inputs
    AND Tap Submit button
    THEN Validate error message when subitting without picture

Verify No picture error message is displayed in Weapon Inventory
    [Documentation]    Submit weapon form without picture
    ...    Pre-conditions: No preconditions
    [Tags]    demo    mobile
    GIVEN Android Inter-con security Application KIOSK-NA
    AND Login to Inter-Con App
    WHEN Home menu is displayed
    AND Close Pending Shifts Popup If Present
    AND Navigate to Tools Section
    AND Navigate to Shift tools section
    AND Click Weapon Inventory
    AND Fill all Weapons inputs
    AND Tap Submit button
    THEN Validate error message when subitting without picture 


Verify error message is displayed in Incidents
    [Documentation]    Submit weapon form without picture
    ...    Pre-conditions: No preconditions
    [Tags]    demo    mobile
    GIVEN Android Inter-con security Application KIOSK-NA
    AND Login to Inter-Con App
    WHEN Home menu is displayed
    AND Close Pending Shifts Popup If Present
    AND Navigate to Tools Section
    AND Navigate to Shift tools section
    AND Click Incidents
    AND Tap Report incident button
    # AND Fill all Weapons inputs
    AND Tap Submit button
    # THEN Validate error message when subitting without picture     

Check user with no equipment assigned
    [Documentation]    Validate user with empty items assigned
    ...    Pre-conditions: User phone number with no equipment assigned
    [Tags]    demo    mobile
    GIVEN Android Inter-con security Application KIOSK-NA
    AND Login to Inter-Con App
    WHEN Home menu is displayed
    AND Close Pending Shifts Popup If Present
    AND Go to Assigned Equipment
    THEN Check user with no equipment assigned

Verify user can start shift from Home screen
    [Documentation]    Validate user can clock in from Home screen
    [Tags]    demo    mobile
    GIVEN Android Inter-con security Application KIOSK-NA
    AND Login to Inter-Con App
    WHEN Home menu is displayed
    AND Close Pending Shifts Popup If Present
    AND Start Shift From Home
    THEN Verify user is Clocked In

Verify remaining time in Early Clock-Out
    [Documentation]    Validate clock out remain minutes message
    ...    Pre-conditions: User with clocked in status
    [Tags]    demo    mobile
    GIVEN Android Inter-con security Application KIOSK-NA
    AND Login to Inter-Con App
    WHEN Home menu is displayed
    AND Close Pending Shifts Popup If Present
    AND Verify CLOCK_IN status
    AND Get remaining time
    THEN Verify early Clock-Out time
