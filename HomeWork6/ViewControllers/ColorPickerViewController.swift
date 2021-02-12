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
        refreshAllOnScreen()
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
        let color = UIColor(red: CGFloat(redColorTextField.text),
                            green: CGFloat(greenColorTextField.text),
                            blue: CGFloat(blueColorTextField.text),
                            alpha: 1.0)
        
        delegate.setNewValues(for: color)
        dismiss(animated: true)
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
            self = 1.0
            return
        }
        
        self = CGFloat(number)
    }
}
