//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Matthew Ngo on 11/12/17.
//  Copyright © 2017 Matthew Ngo. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var correctnessLabel: UILabel!
    var question: String = ""
    var correctAnswer: String = ""
    var correct: String = ""
    var scoreNum: Int = 0
    var scoreDenom: Int = 0
    var quizSize: Int = 0
    var type: String = ""
    var quiz: [String] = []
    var quizAnswers: [Int] = []
    var scores: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = question
        answerLabel.text = "Correct Answer: \(correctAnswer)"
        correctnessLabel.text = correct
        scoreDenom += 1
        if correct == "Right" {
            scoreNum += 1
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func segueAction(_ sender: Any) {
        if scoreDenom * 5 == quizSize {
            performSegue(withIdentifier: "FinishSegue", sender: nil)
        } else {
            performSegue(withIdentifier: "ContinueSegue", sender: nil)
        }
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
        if segue.destination is FinishedViewController {
            let vc = segue.destination as! FinishedViewController
            vc.scoreNum = scoreNum
            vc.scoreDenom = scoreDenom
            vc.type = type
            vc.scores = scores
        } else if segue.destination is QuestionViewController {
            let vc = segue.destination as! QuestionViewController
            vc.scoreNum = scoreNum
            vc.scoreDenom = scoreDenom
            vc.type = type
            vc.quizAnswers = quizAnswers
            vc.quiz = quiz
            vc.scores = scores
        }
        
    }
    
}
