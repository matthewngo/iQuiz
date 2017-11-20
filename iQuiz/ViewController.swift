//
//  ViewController.swift
//  iQuiz
//
//  Created by Matthew Ngo on 11/6/17.
//  Copyright © 2017 Matthew Ngo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var fileData: URL = URL(fileURLWithPath: "")
    var scoreNum: Int = 0
    var scoreDenom: Int = 0
    var dataUrl: String = "http://tednewardsandbox.site44.com/questions.json"
    var jsonDataFromURL: NSData = NSData()
    var image : [UIImage] = []
    var selected = ""
    var map: [[String:Any]] = []
    var nextQuestions: [String] = []
    var nextAnswers: [Int] = []
    var scores: [String] = []
    var scoreString: String = ""
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = map[indexPath.row]["title"]! as? String
        cell.detailTextLabel?.text = map[indexPath.row]["desc"]! as? String
        cell.imageView?.image = image[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return map.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (NSData(contentsOf: fileData) == nil) {
            getJSON()
        }
        do {
            jsonDataFromURL = try NSData(contentsOf: fileData)
            let parsedData = try JSONSerialization.jsonObject(with: jsonDataFromURL as Data, options: []) as! [[String:Any]]
            map = parsedData
        } catch let error as NSError {
            print(error)
        }

        let len: Int = map.count
        var temp = Array(repeating: UIImage(), count: len)
        for i in 0 ... map.count-1 {
            temp[i] = (UIImage(named: "Unknown"))!
        }
        image = temp
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = (map[indexPath.row]["title"]! as? String)!
        let questions = map[indexPath.row]["questions"]! as! [Any] //change subject
        for i in 0 ... questions.count-1 {
            let question = questions[i] as! [String:Any]
            nextQuestions.append(question["text"] as! String)
            let answers = question["answers"] as! [String]
            for j in 0 ... answers.count-1 {
                nextQuestions.append(answers[j])
            }
            let correct = question["answer"] as! NSString
            nextAnswers.append(correct.integerValue)
        }
        self.performSegue(withIdentifier: "QuestionSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SettingsSegue") {
            //print(table)
            let popover = segue.destination
            popover.modalPresentationStyle = UIModalPresentationStyle.popover
            popover.popoverPresentationController?.delegate = self
        } else if (segue.identifier == "ScoreSegue") {
            let popover = segue.destination as! ViewController
            popover.modalPresentationStyle = UIModalPresentationStyle.popover
            popover.popoverPresentationController?.delegate = self
            popover.scores = scores
        } else if segue.destination is QuestionViewController {
            let vc = segue.destination as! QuestionViewController
            vc.type = selected
            vc.scoreNum = scoreNum
            vc.scoreDenom = scoreDenom
            vc.quiz = nextQuestions
            vc.quizAnswers = nextAnswers
            vc.scores = scores
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

    @IBAction func clickToGetScores(_ sender: Any) {
        for s in scores {
            scoreString = "\(scoreString) [\(s)]"
        }
        scoreLabel.text = scoreString
    }
    @IBOutlet weak var textField: UITextField!
    @IBAction func refreshData(_ sender: Any) {
        dataUrl = textField.text!
        viewDidLoad()
    }
    
    func getJSON() {
        do {
            let dir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            fileData = dir.appendingPathComponent("fileData").appendingPathExtension("json")
            jsonDataFromURL = try NSData(contentsOf: URL(string: dataUrl)!)
            let jsonString = String(data: jsonDataFromURL as Data, encoding: String.Encoding.utf8)!
            try jsonString.write(to: fileData, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print(error)
        }
    }
}

