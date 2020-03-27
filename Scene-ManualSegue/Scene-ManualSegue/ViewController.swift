//
//  ViewController.swift
//  Scene-ManualSegue
//
//  Created by Anna Lee on 27/03/2020.
//  Copyright © 2020 Anna Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func wind(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualWind", sender: self)
    }
    
}

