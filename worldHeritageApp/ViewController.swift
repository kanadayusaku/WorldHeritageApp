//
//  ViewController.swift
//  worldHeritageApp
//
//  Created by 金田祐作 on 2019/08/13.
//  Copyright © 2019 金田祐作. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var quizNumber: Int = 0
    var results = [Bool]()
   
   
    @IBOutlet weak var quizLabel: UINavigationItem!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var choice1: UIView!
    @IBOutlet weak var choice2: UIView!
    @IBOutlet weak var choice3: UIView!
    @IBOutlet weak var choice4: UIView!
    
    @IBAction func button1(_ sender: UIButton) {
        checkAnswer(1)
    }
    @IBAction func button2(_ sender: UIButton) {
        checkAnswer(2)
    }
    @IBAction func button3(_ sender: UIButton) {
        checkAnswer(3)
    }
    @IBAction func button4(_ sender: UIButton) {
        checkAnswer(4)
    }
    
    func checkAnswer(_ answer: Int) {
        if (answer == questions[quizNumber].answer) {
            // Correct
            let alertController = UIAlertController(title: "Correct", message: "Go to next quiz", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Next", style: .default, handler: {
                (action: UIAlertAction) in
                self.results.append(true)
                self.quizNumber += 1
                self.updateView()
            })
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            // Wrong
            let alertController = UIAlertController(title: "Wrong", message: "Go to next quiz?", preferredStyle: .alert)
            let goNext = UIAlertAction(title: "Next", style: .default, handler: {
                (action: UIAlertAction!) in
                self.results.append(false)
                self.quizNumber += 1
                self.updateView()
            })
            let goBack = UIAlertAction(title: "Back", style: .default, handler: nil)
            alertController.addAction(goBack)
            alertController.addAction(goNext)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func showTest() {
        questionTextView.text += "\n -----this is for testing-----\n"
        questionTextView.text += "\(results)"
        
    }
    
    class Question: NSObject {
        let choiceNumber: Int
        let sentence: String
        let answer: Int
        init(choiceNumber: Int, sentence: String, answer: Int) {
            self.choiceNumber = choiceNumber
            self.sentence = sentence
            self.answer = answer
        }
    }
    
    // Question instances
    let q1 = Question(
        choiceNumber: 4,
        sentence:
        "日本の世界遺産『富士山－信仰の対象と芸術の源泉』は、2013年に（ ）として世界遺産登録されました。\n\n1. 文化遺産 \n2. 自然遺産 \n3. 山岳遺産 \n4. 伝統遺産",
        answer: 1
    )
    
    
    let q2 = Question(
        choiceNumber: 3,
        sentence:
        "イタリア共和国の世界遺産『フィレンツェの歴史地区』のあるフィレンツェを中心に、17世紀に栄えた芸術運動は何でしょうか。\n\n1. シュルレアリスム \n2. アバンギャルド \n3. ルネサンス",
        answer: 3
    )
    
    let q3 = Question(
        choiceNumber: 2,
        sentence:
        "2016年のオリンピック開催地であるリオ・デ・ジャネイロで、ブラジル独立100周年を記念して作られたキリスト像が立つ場所として、正しいものはどれか。 \n\n1.コパカバーナの山 \n2.コルコバードの丘",
        answer: 2
    )
    
    lazy var questions: Array<Question> = [q1, q2, q3]
    
    func showQuestion(question: Question) {
        questionTextView.text =
        " \n\(question.sentence)"
    }
    
    func showChoices(number: Int) {
        switch (number) {
        case 4:
            choice1.isHidden = false
            choice2.isHidden = false
            choice3.isHidden = false
            choice4.isHidden = false
            
        case 3:
            choice1.isHidden = false
            choice2.isHidden = false
            choice3.isHidden = false
            choice4.isHidden = true
            
        case 2:
            choice1.isHidden = false
            choice2.isHidden = false
            choice3.isHidden = true
            choice4.isHidden = true
            
        default:
            choice1.isHidden = false
            choice2.isHidden = false
            choice3.isHidden = false
            choice4.isHidden = false
        }
    }
    
    func showView() {
        self.quizLabel.title = "No.\(quizNumber + 1)"
        showQuestion(question: questions[quizNumber])
        showChoices(number: questions[quizNumber].choiceNumber)
    }
    
    func updateView() {
        if (quizNumber < questions.count) {
            showView()
        } else {
            performSegue(withIdentifier: "showResult", sender: nil)
            self.results = []
            quizNumber = 0
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.showView()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //var questions: Array<Question> = [q1, q2, q3]
        showView()
      
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            let rvc = segue.destination as! ResultViewController
            rvc.results = self.results
        }
    }

}

/*
 問１ 日本の世界遺産『富士山－信仰の対象と芸術の源泉』は、2013年に（ ）として世界遺産登録されました。 1. 文化遺産 2. 自然遺産 3. 山岳遺産 4. 伝統遺産
 
 
 問2 イタリア共和国の世界遺産『フィレンツェの歴史地区』のあるフィレンツェを中心に、17世紀に栄えた芸術運動は何でしょうか。
 1. シュルレアリスム 2. アバンギャルド 3. ルネサンス
 
 
 問3 2016年のオリンピック開催地であるリオ・デ・ジャネイロで、ブラジル独立100周年を記念して作られたキリスト像が立つ場所として、正しいものはどれ
 
 */
