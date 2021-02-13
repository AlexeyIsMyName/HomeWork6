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
    
    var mainColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Life Cycles Methods
    override func viewWillLayoutSubviews() {
        colorPresenterView.layer.cornerRadius = view.frame.height * 0.02
    }
    
    override func viewDidLoad() {
        refreshAllOnScreen()
        addBtnInKeyboard()
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self
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
        mainColor = UIColor(red: CGFloat(redColorTextField.text),
                            green: CGFloat(greenColorTextField.text),
                            blue: CGFloat(blueColorTextField.text),
                            alpha: 1.0)
        
        delegate.setNewValues(for: mainColor)
        dismiss(animated: true)
    }
    
    @IBAction func colorTFEditingDidEnd() {
//        let redColor = CGFloat(redColorTextField.text)
        
        let redColor = CGFloat(getRightFloat(from: redColorTextField.text))
        let greenColor = CGFloat(getRightFloat(from: greenColorTextField.text))
        let blueColor = CGFloat(getRightFloat(from: blueColorTextField.text))
        
        mainColor = UIColor(red: redColor <= 1 ? redColor : showWrongColorAlarm(),
                            green: greenColor <= 1 ? greenColor : showWrongColorAlarm(),
                            blue: blueColor <= 1 ? blueColor : showWrongColorAlarm(),
                            alpha: 1.0)
        
        refreshAllOnScreen()
    }
    
    // MARK: - Private Methods
    private func refreshAllOnScreen() {
        refreshColorPresenterViewColor()
        refreshDataOnLabels()
        refreshDataOnSliders()
    }
    
    private func refreshColorPresenterViewColor() {
        colorPresenterView.backgroundColor = mainColor
    }
    
    private func refreshDataOnSliders() {
        redColorSlider.value = Float(getFloatColor(from: mainColor).red)
        greenColorSlider.value = Float(getFloatColor(from: mainColor).green)
        blueColorSlider.value = Float(getFloatColor(from: mainColor).blue)
    }
    
    private func refreshDataOnLabels() {
        let color = getFloatColor(from: mainColor)
        
        redColorTextField.text = color.red.getShortString()
        greenColorTextField.text = color.green.getShortString()
        blueColorTextField.text = color.blue.getShortString()
    }

    private func getFloatColor(from color: UIColor) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        return (red: color.cgColor.components?[0] ?? 1,
                green: color.cgColor.components?[1] ?? 1,
                blue: color.cgColor.components?[2] ?? 1)
    }
    
    private func getRightFloat(from text: String?) -> Float {
        
        guard let unwrapedtext = text else { return 1 }
        
        var string = ""
        
        for char in unwrapedtext {
            if char == "," {
                string.append(".")
            } else {
                string.append(char)
            }
        }
        
        return Float(string) ?? 1
    }
    
    private func showWrongColorAlarm() -> CGFloat {
        let alert = UIAlertController(title: "Wrong Format",
                                      message: "Please write color as float number like 0.50 and number must be less or equal to 1 Color is set by 1",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))
        present(alert, animated: true, completion: nil)
        
        return 1
    }
}

// MARK: - Extensions
extension Float {
    func getShortString() -> String {
        return String(format: "%.2f", self)
    }
}

extension CGFloat {
    func getShortString() -> String {
        return String(format: "%.2f", self)
    }
    
    init(_ text: String?) {
        guard let number = Float(text ?? "") else {
            self = 1
            return
        }
        
        self = CGFloat(number)
    }
}

extension ColorPickerViewController {
    private func addBtnInKeyboard() {
        
        let toolBar = UIToolbar()
        
        let button = UIBarButtonItem(title: "Done",
                                     style: .done,
                                     target: self,
                                     action: #selector(dismissKB))
        
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        redColorTextField.inputAccessoryView = toolBar
        greenColorTextField.inputAccessoryView = toolBar
        blueColorTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKB() {
       view.endEditing(true)
     }
}

extension ColorPickerViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        colorTFEditingDidEnd()
    }
}
