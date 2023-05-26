//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Abhay Pansora on 23/05/23.
//

import XCTest
@testable import WeatherApp
@testable import WeatherKit

class WeatherAppTests: XCTestCase {
    
    var weatherSDK: WeatherKit!
    
    override func setUp() {
        super.setUp()
        weatherSDK = WeatherKit()
        weatherSDK.strAPIKey = "ae1c4977a943a50eaa7da25e6258d8b2"
    }
    
    override func tearDown() {
        weatherSDK = nil
        super.tearDown()
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetTodayWeather_Success() {
        let expectation = self.expectation(description: "Get today's weather")
        
        weatherSDK.getTodayWeather(for: "Surat") { weatherData, error in
            XCTAssertNotNil(weatherData, "Weather data should not be nil")
            XCTAssertNil(error, "Error should be nil")
            
            if let weatherData = weatherData {
                // Additional assertions to validate the weather data properties
                XCTAssertNotNil(weatherData.temperature, "Temperature should not be nil")
                XCTAssertNotNil(weatherData.windSpeed, "Wind speed should not be nil")
                
                // Fulfill the expectation to indicate a successful test
                expectation.fulfill()
            }
        }
        
        // Wait for the expectation to be fulfilled or timeout after a certain interval
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetTodayWeather_InvalidLocations() {
        let expectation = self.expectation(description: "Get today's weather with invalid location")
        
        weatherSDK.getTodayWeather(for: "InvalidLocation") { weatherData, error in
            XCTAssertNil(weatherData, "Weather data should be nil for invalid location")
            XCTAssertNotNil(error, "Error should not be nil for invalid location")
            
            // Additional assertions to validate the error message or error type
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetTodayWeather_Error() {
        let expectation = self.expectation(description: "Get today's weather with error")
        
        // Invalid API key to trigger an error
        weatherSDK.strAPIKey = "InvalidAPIKey"
        
        weatherSDK.getTodayWeather(for: "Surat") { weatherData, error in
            XCTAssertNil(weatherData, "Weather data should be nil for error")
            XCTAssertNotNil(error, "Error should not be nil")
            
            // Additional assertions to validate the error message or error type
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetWindSpeed_Success() {
        let expectation = self.expectation(description: "Get wind speed")
        
        weatherSDK.getWindSpeed(for: "London") { windSpeed, error in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(windSpeed, "Wind speed should not be nil")
            
            if let windSpeed = windSpeed {
                print("Wind Speed: \(windSpeed) m/s")
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testGetWindSpeed_InvalidLocation() {
        let expectation = self.expectation(description: "Get wind speed with invalid location")
        
        weatherSDK.getWindSpeed(for: "InvalidLocation") { windSpeed, error in
            XCTAssertNil(windSpeed, "Wind speed should be nil for invalid location")
            XCTAssertNotNil(error, "Error should not be nil for invalid location")
            
            // Additional assertions to validate the error message or error type for invalid location
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testGetWeatherForFutureDays_Success() {
        let expectation = self.expectation(description: "Get weather for future days")
        
        weatherSDK.getWeatherForFutureDays(for: "London", numberOfDays: 7) { weatherDataArray, error in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(weatherDataArray, "Weather data array should not be nil")
            
            if let weatherDataArray = weatherDataArray {
                for weatherData in weatherDataArray {
                    print("Temperature: \(weatherData.temperature.day)°")
                    print("Wind Speed: \(weatherData.windSpeed) m/s")
                    print("----------------------")
                }
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testGetWeatherForFutureDays_InvalidLocation() {
        let expectation = self.expectation(description: "Get weather for future days with invalid location")
        
        weatherSDK.getWeatherForFutureDays(for: "InvalidLocation", numberOfDays: 3) { weatherData, error in
            XCTAssertNil(weatherData, "Weather data should be nil for invalid location")
            XCTAssertNotNil(error, "Error should not be nil for invalid location")
            
            // Additional assertions to validate the error message or error type for invalid location
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetTemperature_Success() {
        let expectation = self.expectation(description: "Get temperature")
        
        weatherSDK.getTemperature(for: "Surat", unit: .celsius) { temperature, error in
            XCTAssertNotNil(temperature, "Temperature should not be nil")
            XCTAssertNil(error, "Error should be nil")
            
            // Additional assertions to validate the temperature value or range in Celsius
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetTemperature_InvalidLocation() {
        let expectation = self.expectation(description: "Get temperature with invalid location")
        
        weatherSDK.getTemperature(for: "InvalidLocation", unit: .celsius) { temperature, error in
            XCTAssertNil(temperature, "Temperature should be nil for invalid location")
            XCTAssertNotNil(error, "Error should not be nil for invalid location")
            
            // Additional assertions to validate the error message or error type for invalid location
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetTemperature_InvalidUnit() {
        let expectation = self.expectation(description: "Get temperature with invalid unit")
        
        weatherSDK.getTemperature(for: "Surat", unit: .kelvin) { temperature, error in
            XCTAssertNil(temperature, "Temperature should be nil for invalid unit")
            XCTAssertNotNil(error, "Error should not be nil for invalid unit")
            
            // Additional assertions to validate the error message or error type for invalid unit
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    // MARK: - Networking Tests
    
    func testGetTodayWeather_SuccessfulRequest() {
        let expectation = XCTestExpectation(description: "Get today's weather")
        
        weatherSDK.getTodayWeather(for: "Surat") { weatherData, error in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(weatherData, "Weather data should not be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testGetTodayWeather_InvalidLocation() {
        let expectation = XCTestExpectation(description: "Get today's weather with invalid location")
        
        weatherSDK.getTodayWeather(for: "InvalidLocation") { weatherData, error in
            XCTAssertNotNil(error, "Error should not be nil")
            XCTAssertNil(weatherData, "Weather data should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    // MARK: - Model Tests
    
    func testWeatherData_InitWithValidJSON() {
        let json: [String: Any] = [
            "main": [
                "temp": 289.5
            ],
            "wind": [
                "speed": 4.2
            ]
        ]
        if let main = json["main"] as? [String: Any], let temperature = main["temp"] as? Double,
           let wind = json["wind"] as? [String: Any], let windSpeed = wind["speed"] as? Double {
            let weatherData = WeatherData(temperature: temperature, windSpeed: windSpeed)
            
            XCTAssertNotNil(weatherData, "Weather data should not be nil")
            XCTAssertEqual(weatherData.temperature, 289.5, accuracy: 0.001, "Incorrect temperature value")
            XCTAssertEqual(weatherData.windSpeed, 4.2, accuracy: 0.001, "Incorrect wind speed value")
        } else {
            // Handle the case when the required data is missing or not in the expected format
        }
    }
    
    func testWeatherData_InitWithInvalidJSON() {
        let json: [String: Any] = [
            "main": [
                "temp": "InvalidTemperature"
            ],
            "wind": [
                "speed": 4.2
            ]
        ]
        
        if let main = json["main"] as? [String: Any], let temperature = main["temp"] as? Double,
           let wind = json["wind"] as? [String: Any], let windSpeed = wind["speed"] as? Double {
            let weatherData = WeatherData(temperature: temperature, windSpeed: windSpeed)
            XCTAssertNil(weatherData, "Weather data should be nil")
        } else {
            // Handle the case when the required data is missing or not in the expected format
        }
        
        
    }
    
    // MARK: - View Model Tests
    
    func testWeatherViewModel_TemperatureInCelsius() {
        let weatherData = WeatherData(temperature: 25.5, windSpeed: 3.8)
        let viewModel = WeatherViewModel(weatherData: weatherData, unit: .celsius)
        
        XCTAssertEqual(viewModel.temperature, "25.5°C", "Incorrect temperature format")
    }
    
    func testWeatherViewModel_TemperatureInFahrenheit() {
        let weatherData = WeatherData(temperature: 68.9, windSpeed: 3.8)
        let viewModel = WeatherViewModel(weatherData: weatherData, unit: .fahrenheit)
        
        XCTAssertEqual(viewModel.temperature, "68.9°F", "Incorrect temperature format")
    }
    
    func testWeatherViewModel_WindSpeed() {
        let weatherData = WeatherData(temperature: 25.5, windSpeed: 3.8)
        let viewModel = WeatherViewModel(weatherData: weatherData, unit: .celsius)
        XCTAssertEqual(viewModel.windSpeed, "3.8 m/s", "Incorrect wind speed format")
    }
    
}
