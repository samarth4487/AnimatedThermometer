//
//  ViewController.swift
//  AnimatedThermometer
//
//  Created by Samarth Paboowal on 06/05/20.
//  Copyright © 2020 Samarth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thermoView = ThermometerView(frame: CGRect(x: view.frame.width/2 - 50, y: view.frame.height/2 - 150, width: 100, height: 300))
        view.addSubview(thermoView)
    }


}

