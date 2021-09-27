//
//  ViewController.swift
//  EasyRequest
//
//  Created by Nidhal Messaoudi on 9/22/21.
//  Copyright © 2021 Nidhal Messaoudi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var requestMethodPicker: UIPickerView!
    @IBOutlet weak var requestUrlTextField: UITextField!
    
    let requestMethods = ["GET", "POST", "PATCH", "PUT", "DELETE"]
    var selectedMethod: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedMethod = requestMethods[0]
        requestMethodPicker.dataSource = self
        requestMethodPicker.delegate = self
        requestUrlTextField.delegate = self
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        requestUrlTextField.endEditing(true)
        let url = URL(string: requestUrlTextField.text!)!
        var request = URLRequest(url: url)
        request.httpMethod = selectedMethod!
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
        }
        
        task.resume()
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return requestMethods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return requestMethods[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMethod = requestMethods[row]
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
}

