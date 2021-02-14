//
//  ViewController.swift
//  HomeWork6
//
//  Created by ALEKSEY SUSLOV on 31.01.2021.
//

import UIKit

class ColorPickerViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var colorPresenterView: UIView!
    
    @IBOutlet var redColorTextField: UITextField!
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    // MARK: - Public Properties
    var mainColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Private Properties
    private let defaultColorNumber: CGFloat = 0
    
    // MARK: - Life Cyrcle Methods
    override func viewWillLayoutSubviews() {
        colorPresenterView.layer.cornerRadius = view.frame.height * 0.02
    }
    
    override func viewDidLoad() {
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self
        addBtnInKeyboard()
        refreshAllOnScreen()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction func colorSliderAction(_ sender: UISlider) {
        mainColor = UIColor(red: CGFloat(redColorSlider.value),
                            green: CGFloat(greenColorSlider.value),
                            blue: CGFloat(blueColorSlider.value),
                            alpha: 1.0)
        
        refreshColorPresenterViewColor()
        
        switch sender.tag {
        case 0: redColorTextField.text = redColorSlider.value.getShortString()
        case 1: greenColorTextField.text = greenColorSlider.value.getShortString()
        case 2: blueColorTextField.text = blueColorSlider.value.getShortString()
        default: break
        }
    }
    
    @IBAction func doneButtonPressed() {
        updateMainColorWithDataFromTextFields()
        delegate.setNewValues(for: mainColor)
        dismiss(animated: true)
    }
    
    @IBAction func colorTFEditingDidEnd() {
        updateMainColorWithDataFromTextFields()
        refreshAllOnScreen()
    }
    
    // MARK: - Private Methods
    // #1
    private func refreshAllOnScreen() {
        refreshColorPresenterViewColor()
        refreshDataOnSliders()
        refreshDataOnLabels()
    }
    
    // #2
    private func refreshColorPresenterViewColor() {
        colorPresenterView.backgroundColor = mainColor
    }
    
    // #3
    private func refreshDataOnSliders() {
        redColorSlider.setValue(Float(getCGFloatColors(from: mainColor).red),
                                animated: true)
        greenColorSlider.setValue(Float(getCGFloatColors(from: mainColor).green),
                                  animated: true)
        blueColorSlider.setValue(Float(getCGFloatColors(from: mainColor).blue),
                                 animated: true)
    }
    
    // #4
    private func refreshDataOnLabels() {
        let color = getCGFloatColors(from: mainColor)
        
        redColorTextField.text = color.red.getShortString()
        greenColorTextField.text = color.green.getShortString()
        blueColorTextField.text = color.blue.getShortString()
    }
    
    // #5
    private func updateMainColorWithDataFromTextFields() {
        let redColor = CGFloat(getRightFloat(from: redColorTextField.text))
        let greenColor = CGFloat(getRightFloat(from: greenColorTextField.text))
        let blueColor = CGFloat(getRightFloat(from: blueColorTextField.text))
        
        // checking if the numbers is not appropriate for CGColor Format
        mainColor = UIColor(red: redColor <= 1 ? redColor : showWrongColorAlarm(),
                            green: greenColor <= 1 ? greenColor : showWrongColorAlarm(),
                            blue: blueColor <= 1 ? blueColor : showWrongColorAlarm(),
                            alpha: 1.0)
    }
    
    private func getCGFloatColors(from color: UIColor) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        return (red: color.cgColor.components?[0] ?? defaultColorNumber,
                green: color.cgColor.components?[1] ?? defaultColorNumber,
                blue: color.cgColor.components?[2] ?? defaultColorNumber)
    }
    
    // HOTFIX to replace comma to dot for the reason to be readable in Float Format then
    private func getRightFloat(from text: String?) -> Float {
        guard let unwrapedText = text else {
            return Float(showWrongColorAlarm())
        }
        
        var string = ""
        
        for char in unwrapedText {
            if char == "," {
                string.append(".")
            } else {
                string.append(char)
            }
        }
        
        return Float(string) ?? Float(showWrongColorAlarm())
    }
    
    // Alarm
    private func showWrongColorAlarm() -> CGFloat {
        let alert = UIAlertController(title: "Wrong Format of color number",
                                      message: "Color number must be from 0 to 1 (example: 0.50). \nColor is set by default (\(defaultColorNumber))",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))
        present(alert, animated: true, completion: nil)
        
        return defaultColorNumber
    }
}

// MARK: - Extension Done Buttom for keyboard
extension ColorPickerViewController {
    private func addBtnInKeyboard() {
        let toolBar = UIToolbar()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                     style: .done,
                                     target: self,
                                     action: #selector(dismissKB))
        
        let cleartButton = UIBarButtonItem(title: "Clear",
                                           style: .done,
                                           target: self,
                                           action: #selector(clearCurrentTF))
        
        toolBar.setItems([doneButton, cleartButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        redColorTextField.inputAccessoryView = toolBar
        greenColorTextField.inputAccessoryView = toolBar
        blueColorTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKB() {
        view.endEditing(true)
    }
    
    @objc func clearCurrentTF() {
        if redColorTextField.isEditing {
            redColorTextField.text = nil
        }
        
        if greenColorTextField.isEditing {
            greenColorTextField.text = nil
        }
        
        if blueColorTextField.isEditing {
            blueColorTextField.text = nil
        }
    }
}

// MARK: - Extension UITextFieldDelegate
extension ColorPickerViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        colorTFEditingDidEnd()
    }
}

// MARK: - Extensions for Float/CGFloat
extension Float {
    func getShortString() -> String {
        return String(format: "%.2f", self)
    }
}

extension CGFloat {
    func getShortString() -> String {
        return String(format: "%.2f", self)
    }
}
