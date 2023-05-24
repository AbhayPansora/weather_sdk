## Table of content
* Complete Task
* Apply Architecture & Techniques
* Applied Project structure
* Setup project
* Requisites

## Complete Task
*Features:*

* The application will retrieve the weather information using the OpenWeatherMaps API in side WeatherKit Freamwork.
* The application allows users to input top of the searching textfeild.
* The application can proceed searching loation with a condition of the search term length must be non emptry textfeild.
* The application can proceed number of days with a condition of the textfeild length must be 1 and between 1 to 7  digists.
* The application can render the searched results to the particuler task 1 to 4 respectively.
* The application can handle failures if something wrng happed.

Technical requirements:
* iOS Swift
* App's architecture: MVVMC
* Apply LiveData mechanism
* Unit Tests
* Exception handling

## Apply Architecture & Techniques
* Architecture: Clean Architecture
* Main principles: SOLID principles
* Pattern: MVVMC, Repository

## Applied Project structure
WeatherApp:

* WeatherKit: the custom freamwork of the app in this freamwork manages all OpenWeatherMaps API will return weatherData.
* GetWeatherVC: the main folder of the gethering weather data with MVVMC condding structure including:(MVVMC)

* Model: It's entity or data of the response and it will appear on UI.
* View: the all view's require outpets and all UI related files
* ViewModel: it's contains the business logic of the app, e.g. all APIs must be define in file
* Controller: the bridge between view and view model and retrive the data particuler requiest wise


## Setup project
To run the app

* Clone or download the repository from Github.
* Open project from 'WatherApp.xcodeproj'folder with XCode.
* Clean and rebuild project.
* Run the app on your device or simulator.
To run the unit tests with the name 'WeatherAppTests'

* Open the project WeatherAppTests.swift files inside WeatherAppTests.
* Clean and rebuild project.
* Choose "Run 'Tests Class 'eatherAppTests'to run all test cases.

## Requisites
* This app requires XCode 12 or Latest
* You must have internet connection.
