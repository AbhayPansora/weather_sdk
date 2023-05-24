//
//  WeatherFunctionality.swift
//  WeatherKit
//
//  Created by Abhay Pansora on 22/05/23.
//

import Foundation
import CoreLocation


public typealias WeatherCompletion = (WeatherData?, Error?) -> Void

public struct TemperatureData {
    // Define properties for hold the day, minimum, and maximum temperatures for a specific day
    public let day: Double
    public let min: Double
    public let max: Double
}
public struct DayWiseWeatherData {
    // Define properties for hold the day, minimum, and maximum temperatures for a specific day, wind speed, etc.
    public let temperature: TemperatureData
    public let windSpeed: Double
}
public struct WeatherData {
    // Define properties for the weather data, such as temperature, wind speed, etc.
    // You can add more properties based on the data you want to retrieve
    public let temperature: Double
    public let windSpeed: Double
    
}

public enum TemperatureUnit: String {
    case fahrenheit = "imperial"
    case celsius = "metric"
}

public class WeatherKit {
    //MARK: - Declaration
    var strAPIKey = "ae1c4977a943a50eaa7da25e6258d8b2"
    var strBaseURL = "https://api.openweathermap.org/data/2.5"
    
    //MARK: - Intialization
    public init() {
        // Initialization, if needed
    }
    
    //MARK: - 1. To get Weather for today for a given location.
    public func getTodayWeather(for location: String, completion: @escaping (WeatherData?, Error?) -> Void) {
        guard let url = URL(string: "\(strBaseURL)/weather?q=\(location)&appid=\(strAPIKey)") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Parse the JSON response and extract the required weather data
                    // Adjust the parsing logic based on the structure of the OpenWeatherMap API response
                    
                    // Extract the temperature
                    if let main = json["main"] as? [String: Any], let temperature = main["temp"] as? Double {
                        // Adjust the temperature value based on the API response
                        let convertedTemperature = temperature - 273.15 // Converting from Kelvin to Celsius
                        var windSpeeds = Double()
                        // Extract the wind speed
                        if let wind = json["wind"] as? [String: Any], let windSpeed = wind["speed"] as? Double {
                            // Adjust the wind speed value based on the API response
                            windSpeeds = windSpeed
                        }
                        let weatherData = WeatherData(temperature: convertedTemperature, windSpeed: windSpeeds)
                        completion(weatherData, nil)
                    } else {
                        completion(nil, NSError(domain: "Invalid response", code: 0, userInfo: nil))
                    }
                } else {
                    completion(nil, NSError(domain: "Invalid response", code: 0, userInfo: nil))
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    //MARK: - 2. To get wind speed.
    public func getWindSpeed(for location: String, completion: @escaping (Double?, Error?) -> Void) {
        // Implement network request to fetch wind speed using the provided location
        // Parse the response and extract the wind speed value
        // Call the completion handler with the wind speed or an error, if any
        guard let url = URL(string: "\(strBaseURL)/weather?q=\(location)&appid=\(strAPIKey)") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Parse the JSON response and extract the required weather data
                    // Adjust the parsing logic based on the structure of the OpenWeatherMap API response
                    // Extract the temperature
                    var atemperature = Double()
                    if let main = json["main"] as? [String: Any], let temperature = main["temp"] as? Double {
                        // Adjust the temperature value based on the API response
                        atemperature = temperature
                    }
                    // Extract the wind speed
                    if let wind = json["wind"] as? [String: Any], let windSpeed = wind["speed"] as? Double {
                        // Adjust the wind speed value based on the API response
                        let weatherData = WeatherData(temperature: atemperature, windSpeed: windSpeed)
                        //print("weatherData->",weatherData)
                        completion(windSpeed, nil)
                    } else {
                        completion(nil, NSError(domain: "Invalid response", code: 0, userInfo: nil))
                    }
                } else {
                    completion(nil, NSError(domain: "Invalid response", code: 0, userInfo: nil))
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    //MARK: - 3.To get weather for a specified future timeframe (1-7) days.
    public func getWeatherForFutureDays(for location: String, numberOfDays: Int, completion: @escaping ([DayWiseWeatherData]?, Error?) -> Void) {
        // Implement network request to fetch weather data for the specified future timeframe using the provided location and number of days
        // Parse the response and create an array of WeatherData objects
        // Call the completion handler with the weather data array or an error, if any
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let placemark = placemarks?.first,
                  let location = placemark.location else {
                      completion(nil, NSError(domain: "Invalid location", code: 0, userInfo: nil))
                      return
                  }
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            guard let url = URL(string: "\(self.strBaseURL)/onecall?lat=\(latitude)&lon=\(longitude)&exclude=current,minutely,hourly&appid=\(self.strAPIKey)") else {
                completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let data = data else {
                    completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                    return
                }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // Parse the JSON response and extract the required weather data
                        // Adjust the parsing logic based on the structure of the One Call API response
                        var weatherDataArray: [DayWiseWeatherData] = []
                        if let daily = json["daily"] as? [[String: Any]] {
                            for index in 0..<numberOfDays {
                                let day = daily[index]
                                // Extract the temperature and wind speed for each day
                                if let temperature = day["temp"] as? [String: Double],
                                   let windSpeed = day["wind_speed"] as? Double {
                                    let temperatureData = TemperatureData(day: temperature["day"] ?? 0.0, min: temperature["min"] ?? 0.0, max: temperature["max"] ?? 0.0)
                                    let weatherData = DayWiseWeatherData(temperature: temperatureData, windSpeed: windSpeed)
                                    weatherDataArray.append(weatherData)
                                }
                            }
                            completion(weatherDataArray, nil)
                        }  else {
                            completion(nil, NSError(domain: "Invalid response", code: 0, userInfo: nil))
                        }
                    } else {
                        completion(nil, NSError(domain: "Invalid response", code: 0, userInfo: nil))
                    }
                } catch {
                    completion(nil, error)
                }
            }
            
            task.resume()
        }
    }
    //MARK: - 4. To retrieve the temperature in F/C.
    public func getTemperature(for location: String, unit: TemperatureUnit, completion: @escaping (Double?, Error?) -> Void) {
        // Implement network request to fetch temperature using the provided location
        // Parse the response and extract the temperature value
        // Convert the temperature to the requested unit (Fahrenheit or Celsius)
        // Call the completion handler with the converted temperature or an error, if any
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(location)&units=\(unit.rawValue)&appid=\(self.strAPIKey)") else {
                completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
                return
            }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Parse the JSON response and extract the required weather data
                    // Adjust the parsing logic based on the structure of the OpenWeatherMap API response
                    
                    if let main = json["main"] as? [String: Any],
                       let temperature = main["temp"] as? Double {
                        completion(temperature, nil)
                    } else {
                        completion(nil, NSError(domain: "Invalid response", code: 0, userInfo: nil))
                    }
                } else {
                    completion(nil, NSError(domain: "Invalid response", code: 0, userInfo: nil))
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
