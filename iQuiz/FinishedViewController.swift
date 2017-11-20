//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Matthew Ngo on 11/12/17.
//  Copyright © 2017 Matthew Ngo. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {

    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var scoreNum: Int = 0
    var scoreDenom: Int = 0
    var type: String = ""
    var scores: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(scoreNum)/\(scoreDenom)"
        scores.append(scoreLabel.text!)
        if scoreNum == scoreDenom {
            desLabel.text = "Perfect Job!"
        } else {
            desLabel.text = "You can do better..."
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController {
            let vc = segue.destination as! ViewController
            vc.scoreNum = 0
            vc.scoreDenom = 0
            vc.scores = scores
        }
    }
}
