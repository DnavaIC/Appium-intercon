*** Settings ***
Library    Browser   
Library    ../Library/AuthHelpers.py
Library    Collections
Library    Dialogs

*** Variables ***
${SECRET_NAME}      offboarding_active_directory
${AWS_REGION}       us-east-1
${URL_LOGIN_PAGE}   https://gantt-qa.bubo.io/#/login
${URL_APP_ROOT}     https://gantt-qa.bubo.io/#/

*** Test Cases ***
Login Bypassing UI With AWS Credentials
    [Documentation]    Obtains credentials from AWS, generates MSAL token, and injects it into LocalStorage to bypass login.

    Log    Starting Authentication Flow...    console=True

    # 1. Get secrets and Token
    ${creds_dict}=    Get Aws Secret    ${SECRET_NAME}    ${AWS_REGION}
    ${token}=         Get Microsoft Access Token    ${creds_dict['tenant_id']}    ${creds_dict['client_id']}    ${creds_dict['new_client_secret']}
    
    # 2. init browser
    New Browser    chromium    headless=False
    New Context
    New Page       ${URL_LOGIN_PAGE}

    # 3. inject Token
    LocalStorage Set Item    token    ${token}
    LocalStorage Set Item    refreshToken    ${token}
    
    Log    Token injected. Navigating to application...    console=True

    # 4. force navigation to app root
    Go To    ${URL_APP_ROOT}

    # 5. Validación
    Wait For Condition    Url    !=    ${URL_LOGIN_PAGE}
    Get Url    contains    gantt-qa.bubo.io
    Pause Execution    message=wait for token check