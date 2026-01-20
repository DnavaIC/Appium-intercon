# Appium installation - IC Security App

This repository is an initiative to kickstart the mobile automation of testing processes at Inter-Con Security, a company that previously had no automation in this area. It also serves as a proposal for adopting automation practices. Please note that all the work here is currently under development.

## Set up your project and start scripting. (recommended)

In case this is your first time automating cases in icsecurity mobile, it is highly recommended that you take a look at the complete guide found in the getting started guide. It will save you a lot of research, trial and error. 
Please go to [IC security - mobile automation wiki](https://github.com/DnavaIC/STD-Appium-intercon/wiki)

## Quick run setup (Advanced)


### 1. with Node and Python pre-installed


```
npm i --location=global appium
```
```
appium driver install uiautomator2
```
```
pip install robotframework robotframework-appiumlibrary robotframework-browser
```

### 2. (only for mobile testing) Install Android Studio, which includes SDK and install JDK binarie.

Once you install your tools and extract the corresponding path, create new system variables.

SDK (Android)
```
Name: ANDROID_HOME
path: C:\Users<your username>\AppData\Local\Android\Sdk\platform-tools
```

JDK (Java)
```
Name: JAVA_HOME
path: C:\java\jdk-23.0.2\bin
```

Don't forget to add the same two variables in path system variables

### 3. (only for mobile testing) Initialize appium server

run appium command 
```
appium
```
Connect your hardware device / turn on your emulation device. 

### 4. Run your test

#### For web testing
clone the repository and run 
```
npm run demo-web
```

#### For mobile testing
```
npm run demo-mobile
```
#### Intalation on Mac

### Tech Stack

Robot Framework
Appium
Python 3.11+
Poetry (dependency management)
Android Emulator or Physical Device
UiAutomator2
Node.js

### System requirements

## Make sure you have the following installed:

brew install node
brew install python@3.11
brew install openjdk
brew install android-platform-tools

## Verify:

node -v
python3 --version
java -version
adb version

## Install Appium globally
npm install -g appium
appium driver install uiautomator2

## Verify:

appium -v
appium driver list

## Install Android Studio and ensure:

Android SDK
Platform Tools
At least one emulator (Pixel recommended)

## Environment variables (add to ~/.zprofile or ~/.zshrc):

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH
export JAVA_HOME=$(/usr/libexec/java_home)

## Reload:

source ~/.zprofile

## Clone repository
git clone https://github.com/DnavaIC/STD-Automation-testing-icsecurity.git
cd STD-Automation-testing-icsecurity

## Install Python dependencies with Poetry (recommended)
pip install poetry
poetry install
poetry shell

## Start Appium server

appium

## Start Android emulator or connect device

adb devices

## You should see something like:

emulator-5554    device

## Run entire mobile suite:

poetry run robot --outputdir ./output/reports tests/inter-con-app/demo-mobile.robot

## Run single test case:

poetry run robot --outputdir ./output/reports --test "Input Wrong Phone Number" tests/inter-con-app/demo-mobile.robot

poetry run robot --outputdir ./output/reports --test "Verify No picture error message is displayed in Vehicle Inspection" tests/inter-con-app/demo-mobile.robot

poetry run robot --outputdir ./output/reports --test "Verify No picture error message is displayed in Weapon Inventory" tests/inter-con-app/demo-mobile.robot

poetry run robot --outputdir ./output/reports --test "Check user with no equipment assigned" tests/inter-con-app/demo-mobile.robot

poetry run robot --outputdir ./output/reports --test "Verify remaining time in Early Clock-Out" tests/inter-con-app/demo-mobile.robot


## Contributing

Please note that all the work here is currently under development.
You are welcome to contribute to the project; just send your PR.

- Diego E. Nava – Project author & maintainer, dnava@icsecurity.com  
- Sergio Ávila Espinosa – Mobile automation improvements, savila@icsecurity.com 


