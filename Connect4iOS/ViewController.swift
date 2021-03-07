//
//  ViewController.swift
//  Connect4iOS
//
//  Created by Silver-Ed Sillaots on 24.11.2020.
//

import UIKit
import QuartzCore

class MainMenuController: UIViewController {

    @IBOutlet weak var mainMenu: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func humanVsAiButton(_ sender: Any) {
        alert()
    }
    
    @IBAction func aiVsAiButton(_ sender: Any) {
        alert()
    }
    
    func alert() {
        let alert = UIAlertController(title: "Not implemented yet!", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            NSLog("OK Pressed") }
        
        alert.view.tintColor = UIColor.orange
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        for subview in mainMenu.subviews {
            let button = subview as? UIButton
            button?.layer.masksToBounds = true
            button?.layer.cornerRadius = 10
        }
        
    }
    
    


}

