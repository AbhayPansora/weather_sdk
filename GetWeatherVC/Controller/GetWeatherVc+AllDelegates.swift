//
//  GetWeatherVc+AllDelegates.swift
//  WeatherApp
//
//  Created by Abhay Pansora on 23/05/23.
//

import Foundation
import UIKit
import WeatherKit

extension GetWeatherVC:UITextFieldDelegate{
    //MARK - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.mainView.txtEnterNoOfDays {
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            // Check if the updated text is a single digit between 1 and 7
            if let digit = Int(updatedText), (1...7).contains(digit) {
                // Valid input
                return true
            } else {
                // Invalid input, clear the text field
                textField.text = ""
                return false
            }
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
