//
//  ViewController.swift
//  Scene-Trans02
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

    @IBAction func movePresent(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        self.present(uvc, animated: true)
    }
    
    @IBAction func moveByNavy(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
        return
        }
    self.navigationController?.pushViewController(uvc, animated: true)
    
    }
}

