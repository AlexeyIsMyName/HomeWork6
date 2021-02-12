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
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    }
    
    // MARK: - IB Actions
    @IBAction func colorSliderAction(_ sender: UISlider) {
        mainColor = UIColor(red: CGFloat(redColorSlider.value),
                            green: CGFloat(greenColorSlider.value),
                            blue: CGFloat(blueColorSlider.value),
                            alpha: 1.0)
        
        refreshColorPresenterViewColor()
        
        switch sender.tag {
        case 0: redColorTextField.text = getShortString(from: redColorSlider.value)
        case 1: greenColorTextField.text = getShortString(from: greenColorSlider.value)
        case 2: blueColorTextField.text = getShortString(from: blueColorSlider.value)
        default: break
        }
    }
    
    @IBAction func doneButtonPressed() {
        let color = UIColor(red: getCGFloat(from: redColorTextField.text),
                            green: getCGFloat(from: greenColorTextField.text),
                            blue: getCGFloat(from: blueColorTextField.text),
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
        redColorSlider.value = Float(getRGBColor(from: colorPresenterView).red)
        greenColorSlider.value = Float(getRGBColor(from: colorPresenterView).green)
        blueColorSlider.value = Float(getRGBColor(from: colorPresenterView).blue)
    }
    
    private func refreshDataOnLabels() {
        let colors = getRGBColor(from: colorPresenterView)
        
        redColorTextField.text = getShortString(from: colors.red)
        greenColorTextField.text = getShortString(from: colors.green)
        blueColorTextField.text = getShortString(from: colors.blue)
    }

    private func getRGBColor(from view: UIView) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var red: CGFloat = 0.5
        var green: CGFloat = 0.5
        var blue: CGFloat = 0.5
        
        guard let colors = view.backgroundColor?.cgColor.components else { return (red, green, blue) }
        
        if colors.count == 4 {
            red = colors[0]
            green = colors[1]
            blue = colors[2]
        }
        
        return (red, green, blue)
    }
    
    private func getShortString(from value: Float) -> String {
        return String(format: "%.2f", value)
    }
    
    private func getShortString(from numberOFcolor: CGFloat) -> String {
        return String(format: "%.2f", numberOFcolor)
    }
    
    private func getCGFloat(from text: String?) -> CGFloat {
        guard let number = Float(text ?? "") else {return 0.5}
        return CGFloat(number)
    }
}
