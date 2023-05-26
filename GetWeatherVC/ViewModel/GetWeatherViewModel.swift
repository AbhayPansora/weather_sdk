//
//  GetWeatherViewModel.swift
//  WeatherApp
//
//  Created by Abhay Pansora on 23/05/23.
//

import Foundation
import UIKit
import WeatherKit

class GetWeatherViewModel {
    
    //#MARK: - Declarations
    fileprivate weak var theController:GetWeatherVC!
    init(theController:GetWeatherVC) {
        self.theController = theController
    }
    let weatherKit = WeatherKit()
    var futureDayData = [DayWiseWeatherData]()
    var dismissKeyboardGestureRecognizer = UITapGestureRecognizer()
    
    //MARK: - Implementation Methods
    func getTodaysWeatherByLocation(location:String){
        self.weatherKit.getTodayWeather(for: location) { weatherData, error in
            if let error = error {
                print("Error: \(error)")
            } else if let weatherData = weatherData {
                //print("Temperature: \(weatherData.temperature)°")
                //print("Wind Speed: \(weatherData.windSpeed) m/s")
                DispatchQueue.main.async {
                    self.theController.mainView.lblAnsOfFirst.text = "Temperature: \(weatherData.temperature.round(to:2))°\nWind Speed: \(weatherData.windSpeed) m/s"
                }
            } else {
                print("Unable to fetch today's weather.")
            }
        }
    }
    
    func getWindSpeed(location:String){
        self.weatherKit.getWindSpeed(for: "London") { windSpeed, error in
            if let error = error {
                print("Error: \(error)")
            } else if let windSpeed = windSpeed {
                DispatchQueue.main.async {
                    self.theController.mainView.lblAnsOfSecond.text = "WindSpeed is \(windSpeed) m/s"
                }
            } else {
                print("Unable to fetch future days data.")
            }
        }
    }
    func getWeatherForFutureDays(location:String,NoOfDays:Int){
        self.weatherKit.getWeatherForFutureDays(for: location, numberOfDays: NoOfDays) { allDaysData, error in
            if let error = error {
                print("Error: \(error)")
            } else if let allDaysData = allDaysData {
                self.futureDayData = allDaysData
                DispatchQueue.main.async {
                    var futureDaysData = ""
                    for (ind,weatherData) in allDaysData.enumerated() {
                        //print("Temperature: \(weatherData.temperature.day)°")
                        //print("Wind Speed: \(weatherData.windSpeed) m/s")
                        //print("----------------------")
                        futureDaysData += "D\(ind+1)- \(weatherData.temperature.day.round(to:2))°, "
                    }
                    self.theController.mainView.lblAnsOfThird.text = futureDaysData
                }
            } else {
                print("Unable to fetch future days data.")
            }
        }
    }
    func getTemperatureUnitWise(location:String,tempUnit:TemperatureUnit){
        self.weatherKit.getTemperature(for: location, unit: tempUnit) { temperature, error in
            if let error = error {
                print("Error: \(error)")
            } else if let temperature = temperature {
                print("Temperature: \(temperature)°")
                DispatchQueue.main.async {
                    self.theController.mainView.lblAnsOfFourth.text = "Temperature: \(temperature.round(to:2))°"
                }
            } else {
                print("Unable to fetch temperature.")
            }
        }
    }
}
