## Pre-Requisites:

If you have different versions of Xcode locally installed, you need to switch to Xcode 8.x. to use Swift 3.1

```sh
rm -rf ~/Library/Developer/Xcode/DerivedData/
sudo xcode-select -switch ~/PATH_TO_YOUR_XCODE_8/Xcode.app/
```

#### Install the Swift Server Generator:

1 . Ensure that you have Node.js 8.0 installed:

`node —v`

2 . Install Yeoman:

`npm install -g yo`

3 . Install Swift Server Generator:

`npm install -g generator-swiftserver`

#### Ensure you have CocoaPods installed

`pod --version`

## Generate server template
`yo swiftserver`

## Generate model
`yo swiftserver:model`

Create a model called "Creature" with the following attributes

| attribute        | type       |
| ------------- |:-------------:|
| name          | string        |
| picture       | string        |



## Open generated server project
`open server_app.xcodeproj`

- target settings : Run -> select 'server_app'
- start the server locally

## Generated webpages
- http://localhost:8080/
- http://localhost:8080/swiftmetrics-dash/
- http://localhost:8080/explorer/

## Use the generated iOS SDK in the iOS app
###(not mandatory)
- unzip `server_app_iOS_SDK.zip` and put it in the iOS app directory.
- Init cocoapod

`pod init`

- Edit the podfile :

```
# Uncomment the next line to define a global platform for your project# platform :ios, '9.0'

target 'theServerSideSwift' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for theServerSideSwift
	pod 'Server_app_iOS_SDK', :path => "../server_app/Server_app_iOS_SDK"
end
```

- install Pods :

`pod install`


## Generate the heroku app

`heroku create --buildpack https://github.com/kylef/heroku-buildpack-swift.git`

## Deploy the server

Dont forget to create a **Procfile** in the root directory of the server_app

```
git init
heroku git:remote -a john-do-4242
git add .
git commit -am "deploy"
git push heroku master
```

## Open you app

`heroku open`


Thanks [ianpartridge](https://github.com/ianpartridge) and [seabaylea](https://github.com/seabaylea)
