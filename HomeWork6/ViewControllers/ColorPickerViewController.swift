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
    
    // MARK: - Life Cycles Methods
    override func viewWillLayoutSubviews() {
        colorPresenterView.layer.cornerRadius = view.frame.height * 0.02
        refreshAllOnScreen()
    }
    
    // MARK: - IB Actions
    @IBAction func colorSliderAction(_ sender: UISlider) {
        refreshColorPresenterViewColor()
        
        switch sender.tag {
        case 0: redColorTextField.text = getColorString(from: redColorSlider.value)
        case 1: greenColorTextField.text = getColorString(from: greenColorSlider.value)
        case 2: blueColorTextField.text = getColorString(from: blueColorSlider.value)
        default: break
        }
    }
    
    // MARK: - Private Methods
    private func refreshAllOnScreen() {
        refreshColorPresenterViewColor()
        refreshDataOnLabels()
    }
    
    private func refreshColorPresenterViewColor() {
        colorPresenterView.backgroundColor = UIColor(red: CGFloat(redColorSlider.value),
                                                     green: CGFloat(greenColorSlider.value),
                                                     blue: CGFloat(blueColorSlider.value),
                                                     alpha: 1.0)
    }
    
    private func refreshDataOnLabels() {
        let colors = getRGBColor(from: colorPresenterView)
        let red = getShortString(from: colors.red)
        let green = getShortString(from: colors.green)
        let blue = getShortString(from: colors.blue)
        
        redColorTextField.text = red
        greenColorTextField.text = green
        blueColorTextField.text = blue
    }
    
    private func getColorString(from value: Float) -> String {
        return String(format: "%.2f", value)
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
    
    private func getShortString(from numberOFcolor: CGFloat) -> String {
        return String(format: "%.2f", numberOFcolor)
    }
}
