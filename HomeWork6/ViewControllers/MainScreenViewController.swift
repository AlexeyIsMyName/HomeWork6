//
//  MainScreenViewController.swift
//  HomeWork6
//
//  Created by ALEKSEY SUSLOV on 12.02.2021.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    var mainColor: UIColor = .white
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        refreshViewBGColor()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension MainScreenViewController {
    private func refreshViewBGColor() {
        view.backgroundColor = mainColor
    }
}
