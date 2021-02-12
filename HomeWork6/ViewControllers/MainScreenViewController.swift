//
//  MainScreenViewController.swift
//  HomeWork6
//
//  Created by ALEKSEY SUSLOV on 12.02.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewValues(for mainColor: UIColor)
}

class MainScreenViewController: UIViewController {
    
    var mainColor: UIColor = .white
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        refreshViewBGColor()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorPickerVC = segue.destination as? ColorPickerViewController else { return }
        colorPickerVC.mainColor = mainColor
        colorPickerVC.delegate = self
    }
}

extension MainScreenViewController {
    private func refreshViewBGColor() {
        view.backgroundColor = mainColor
    }
}

extension MainScreenViewController: SettingsViewControllerDelegate {
    func setNewValues(for mainColor: UIColor) {
        self.mainColor = mainColor
        refreshViewBGColor()
    }
}
