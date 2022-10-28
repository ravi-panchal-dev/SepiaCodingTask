# Sepia Coding Task - iOS

This repository contains the Sepia Coding Task iOS app.

## Deliverables
Create an iOS application to load the pets data from the local JSON file and show in list view and when we click on any of them load the details of the pets from the content url which has WIKIPEDIA link.

## Descripation
I created an app that will load the pets list from the JSON file and also every second it check the timer that app has valid hours to access from another JSON, if time expire so it will display on alert that working time is over.

Also when you click on any of the pet from the list it will redirect to next screen which has internal web view that will load the URL which contain the pet details.

In App there is no third party library or any pods also for the image cache I manage it locally so when app is in foreground and once is downloaded from the url so next time when you put app in background and app come in foreground images will load from cache.


## Setup
- [Clone Challenge Repo](https://github.com/ravi-panchal-dev/SepiaCodingTask) - github

## Minimum Reqirement
- iOS 13
- Orientation - Portrait

## Language and Pods
- Language - Swift
- Cocoapods - None

## Tool required to run
- Xcode 



