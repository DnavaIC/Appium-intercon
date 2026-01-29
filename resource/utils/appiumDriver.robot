*** Settings ***
Documentation  Mobile driver inicialization
Library    AppiumLibrary
Library    Process


# Maybe hardcode the values here is not the best approach, but for this example is ok
*** Variables ***
${ANDROID_DEVICE_NAME}                Android
${ANDROID_AUTOMATION_NAME}            UiAutomator2
${ANDROID_PLATFORM_NAME}              Android
${ANDROID_APP_PACKAGE_KIOSKNA}        com.icsecurity.noakiosk
${ANDROID_APP_ACTIVITY_KIOSKNA}       com.icsecurity.fieldOfficerApp.MainActivity
${ANDROID_APP_WAIT_ACTIVITY}          com.icsecurity.fieldOfficerApp.MainActivity

*** Keywords ***

Android Inter-con security Application KIOSK-NA
  Open Application   http://localhost:4723    
  ...  automationName=${ANDROID_AUTOMATION_NAME}
  ...  platformName=${ANDROID_PLATFORM_NAME}
  ...  deviceName=${ANDROID_DEVICE_NAME}
  ...  appPackage=${ANDROID_APP_PACKAGE_KIOSKNA}
  ...  appActivity=${ANDROID_APP_ACTIVITY_KIOSKNA}
  ...  appWaitActivity=${ANDROID_APP_WAIT_ACTIVITY}
  ...  appWaitDuration=30000
  ...  newCommandTimeout=300
  ...  uiautomator2ServerInstallTimeout=120000
  ...  uiautomator2ServerLaunchTimeout=120000
  ...  noReset=false
  ...  autoGrantPermissions=true
  ...  udid=emulator-5554


Reset App State
    Run Keyword And Ignore Error    Run Process    adb    -s    emulator-5554    shell    pm    clear    ${ANDROID_APP_PACKAGE_KIOSKNA}


Shut down App
    Run Keyword And Ignore Error    Terminate Application    ${ANDROID_APP_PACKAGE_KIOSKNA}
    Run Keyword And Ignore Error    Close Application
    
Clean Teardown
    Reset App State
    Shut down App
    
