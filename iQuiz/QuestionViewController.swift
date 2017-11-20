//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Matthew Ngo on 11/12/17.
//  Copyright © 2017 Matthew Ngo. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    var type: String = ""
    var question: String = ""
    var selected: String = ""
    var correctAnswer: String = ""
    var scoreNum: Int = 0
    var scoreDenom: Int = 0
    var quizSize: Int = 0
    var quiz: [String] = []
    var quizAnswers: [Int] = []
    var scores: [String] = []
    
    var mathQuiz = ["1 + 2 = ?", "3", "4", "5", "6"]
    
    var heroQuiz = ["Which superhero has a robot suit?", "Superman", "Ironman", "Batman", "Spiderman"]
    
    var scienceQuiz = ["What is the formula for force?", "f=m", "f=10", "f=g", "f=ma"]
    
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = quiz[5*scoreDenom]
        Button1.setTitle(quiz[5*scoreDenom+1], for: .normal)
        Button2.setTitle(quiz[5*scoreDenom+2], for: .normal)
        Button3.setTitle(quiz[5*scoreDenom+3], for: .normal)
        Button4.setTitle(quiz[5*scoreDenom+4], for: .normal)
        correctAnswer = quiz[5*scoreDenom + quizAnswers[scoreDenom]]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func pressButton(_ sender: UIButton) {
        let buttons: [UIButton] = [Button1, Button2, Button3, Button4]
        for button in buttons {
            if button == sender {
                selected = (button.titleLabel?.text!)!
                button.backgroundColor = UIColor.green
            } else {
                button.backgroundColor = UIColor.lightGray
            }
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
        if segue.destination is AnswerViewController {
            let vc = segue.destination as! AnswerViewController
            vc.question = quiz[5*scoreDenom]
            vc.correctAnswer = correctAnswer
            vc.scoreNum = scoreNum
            vc.scoreDenom = scoreDenom
            vc.type = type
            vc.quizSize = quiz.count
            vc.quiz = quiz
            vc.quizAnswers = quizAnswers
            vc.scores = scores
            if selected == correctAnswer {
                vc.correct = "Right"
            } else {
                vc.correct = "Wrong"
            }
        }
        
    }

}
