//
//  GetWeatherView.swift
//  WeatherApp
//
//  Created by Abhay Pansora on 23/05/23.
//

import UIKit
import WeatherKit

class GetWeatherView: UIView {
    
    //MARK: - Outlets
    
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var lblAnsOfFirst: UILabel!
    @IBOutlet weak var lblAnsOfSecond: UILabel!
    @IBOutlet weak var txtEnterNoOfDays: UITextField!
    @IBOutlet weak var lblAnsOfThird: UILabel!
    @IBOutlet weak var lblAnsOfFourth: UILabel!
    
    //MARK: - Setup UIs
    
    func setupUI(delegates:GetWeatherVC){
        [txtEnterNoOfDays,txtEnterNoOfDays].forEach { txt in
            txt?.delegate = delegates
        }
    }
    
}
