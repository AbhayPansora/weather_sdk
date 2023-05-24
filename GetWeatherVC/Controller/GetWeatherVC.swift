//
//  GetWeatherVC.swift
//  WeatherApp
//
//  Created by Abhay Pansora on 23/05/23.
//

import UIKit
import WeatherKit

class GetWeatherVC: UIViewController {

    //MARK: - Declaration
    lazy var mainView: GetWeatherView = { [unowned self] in
        return self.view as! GetWeatherView
    }()
    
    lazy var mainModelView: GetWeatherViewModel = {
        return GetWeatherViewModel(theController: self)
    }()
    
    //MARK: - Views Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.mainView.setupUI(delegates:self)
        //Setup dismiss keyboard gesture
        self.mainModelView.dismissKeyboardGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //Add Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name:UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name:UIResponder.keyboardDidHideNotification, object: nil)
    }
    @objc func keyboardDidShow() {
        self.mainModelView.dismissKeyboardGestureRecognizer.cancelsTouchesInView = true
        view.addGestureRecognizer(self.mainModelView.dismissKeyboardGestureRecognizer)
    }
    @objc func keyboardDidHide() {
        self.mainModelView.dismissKeyboardGestureRecognizer.cancelsTouchesInView = false
        view.removeGestureRecognizer(self.mainModelView.dismissKeyboardGestureRecognizer)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    //MARK: - All Buttons Actions
    
    @IBAction func btnGetTodaysWeatherActions(_ sender: Any) {
        dismissKeyboard()
        self.mainModelView.getTodaysWeatherByLocation(location: "London")
    }
    @IBAction func btnWindSpeedAction(_ sender: Any) {
        dismissKeyboard()
        self.mainModelView.getWindSpeed(location:"London")
    }
    @IBAction func btnGetFutherDaysWeather(_ sender: Any) {
        dismissKeyboard()
        guard self.mainView.txtLocation.text != "" && self.mainView.txtEnterNoOfDays.text?.isEmpty == false else{ return }
        self.mainModelView.getWeatherForFutureDays(location:self.mainView.txtLocation.text!,NoOfDays:Int(self.mainView.txtEnterNoOfDays.text!)!)
    }
    @IBAction func btnFahrenheitWeatherAction(_ sender: Any) {
        dismissKeyboard()
        guard self.mainView.txtLocation.text != "" else{ return }
        self.mainModelView.getTemperatureUnitWise(location:self.mainView.txtLocation.text!,tempUnit:.fahrenheit)
    }
    @IBAction func btnCelsiusWeatherAction(_ sender: Any) {
        dismissKeyboard()
        guard self.mainView.txtLocation.text != "" else{ return }
        self.mainModelView.getTemperatureUnitWise(location:self.mainView.txtLocation.text!,tempUnit:.celsius)
    }
}
