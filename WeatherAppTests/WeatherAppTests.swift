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
    func testGetTodayWeather() {
        let expectation = self.expectation(description: "Get today's weather")
        
        weatherSDK.getTodayWeather(for: "London") { weatherData, error in
            XCTAssertNil(error, "Error should be nil")
            XCTAssertNotNil(weatherData, "Weather data should not be nil")
            
            if let weatherData = weatherData {
                print("Today's Temperature: \(weatherData.temperature)°")
                print("Today's Wind Speed: \(weatherData.windSpeed) m/s")
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetWindSpeed() {
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
    
    func testGetWeatherForFutureDays() {
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
    
}
