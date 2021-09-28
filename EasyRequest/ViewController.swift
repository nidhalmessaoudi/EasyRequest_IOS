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
    @IBOutlet weak var requestUrlView: UIView!
    
    let requestMethods = ["GET", "POST", "PATCH", "PUT", "DELETE"]
    var selectedMethod: String?
    
    var lastErrorLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedMethod = requestMethods[0]
        requestMethodPicker.dataSource = self
        requestMethodPicker.delegate = self
        requestUrlTextField.delegate = self
    }
    
    func isValidUrl(url: String) -> Bool {
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: url)
        return result
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if requestUrlTextField.isFocused {
            requestUrlTextField.endEditing(true)
        }
        
        clearErrors()
        
        let requestUrlTextFieldValue = requestUrlTextField.text
        
        if requestUrlTextFieldValue == "" {
                renderError(withValue: "Missing the request Url!")
            return
        }
        
        if isValidUrl(url: requestUrlTextFieldValue!) {
            let url = URL(string: requestUrlTextFieldValue!)
            var request = URLRequest(url: url!)
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
        } else {
            renderError(withValue: "Invalid Url!")
        }
    }
    
    func renderError(withValue value: String) {
        let errorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 92, height: 40))
        errorLabel.text = value
        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont.systemFont(ofSize: 18)
        requestUrlView.addSubview(errorLabel)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerXAnchor.constraint(equalTo: requestUrlView.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: requestUrlView.centerYAnchor, constant: -50).isActive = true
        
        lastErrorLabel = errorLabel
    }
    
    func clearErrors() {
        lastErrorLabel?.removeFromSuperview()
        lastErrorLabel = nil
    }
        
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    //MARK: - Picker View Extension
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
    
    //MARK: - Text Field Extension
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        clearErrors()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
}

