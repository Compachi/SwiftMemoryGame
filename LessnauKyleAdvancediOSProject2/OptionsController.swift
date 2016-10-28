//
//  ViewController.swift
//  LessnauKyleAdvancediOSProject2
//
//  Created by Kyle Lessnau on 10/16/16.
//  Copyright © 2016 Kyle Lessnau. All rights reserved.
//

import UIKit

class OptionsController: UIViewController {
    
    let optionModel = OptionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //2x2 game
    @IBAction func twoXtwoPressed(_ sender: UIButton) {
        optionModel.cardCount = 4
        performSegue(withIdentifier: "GameSegue", sender: MatchGameController())
    }
   
    //4x4 game (default)
    @IBAction func fourXfourPressed(_ sender: AnyObject) {
        optionModel.cardCount = 16
        performSegue(withIdentifier: "GameSegue", sender: MatchGameController())
    }
   
    //6x6 game
    @IBAction func sixXsixPressed(_ sender: UIButton) {
        optionModel.cardCount = 36
        performSegue(withIdentifier: "GameSegue", sender: MatchGameController())
    }
    
    //Passes card count to MatchGameController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? MatchGameController {
            destinationVC.gameCardCount = optionModel.cardCount
        }
    }
}
    


