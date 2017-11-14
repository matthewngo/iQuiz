//
//  ViewController.swift
//  iQuiz
//
//  Created by Matthew Ngo on 11/6/17.
//  Copyright © 2017 Matthew Ngo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var scoreNum: Int = 0
    var scoreDenom: Int = 0
    
    var titles : [String] = ["Mathematics", "Marvel Superheroes", "Science"]
    var descriptions : [String] = ["A math quiz", "A Marvel's superheroes quiz", "A science quiz"]
    var image : [UIImage] = [(UIImage(named: "Unknown"))!, (UIImage(named: "Unknown"))!, (UIImage(named: "Unknown"))!]
    var selected = ""
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = titles[indexPath.row]
        cell.detailTextLabel?.text = descriptions[indexPath.row]
        cell.imageView?.image = image[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func settingsAlert(sender: AnyObject) {
        let alertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = titles[indexPath.row]
        self.performSegue(withIdentifier: "QuestionSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is QuestionViewController {
            let vc = segue.destination as! QuestionViewController
            vc.type = selected
            vc.scoreNum = scoreNum
            vc.scoreDenom = scoreDenom
        }
        
    }
}

