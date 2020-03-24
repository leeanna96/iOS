//
//  ViewController.swift
//  HelloWorld
//
//  Created by Anna Lee on 24/03/2020.
//  Copyright © 2020 Anna Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var uiTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func sayHello(_ sender: Any) {
        self.uiTitle.text="Hello, World!"
    }
}

