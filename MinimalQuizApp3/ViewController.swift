//
//  ViewController.swift
//  MinimalQuizApp
//
//  Created by 竹村信一 on 2021/02/01.
//

import UIKit

class ViewController: UIViewController {
    
    // 正しい答えの番号
    var correctAnswer:Int?
    
    // ボタンによって画像を変化させたいのでlazyを使って設定している
    //lazy var iv = setUpJudgmentImage()
    
    // ボタンによって画像を変化させたいのでプロパティにしておく必要がある
    var iv:UIImageView?
    
    var buttonList:[UIButton] = []
    var questionView = UITextView()
    var quizList:[Quiz] = Array(Quiz.defQuizzes)
    var num = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        iv = setUpJudgmentImage()
        
        // 問題文の作成
        self.questionView = setUpQuestion(contents: quizList[num].question)
        // 正解の選択肢の設定
        correctAnswer = quizList[num].answer
        // 選択肢の作成
        let c = setUpChoices(c1: quizList[num].choices[0], c2: quizList[num].choices[1], c3: quizList[num].choices[2])
        buttonList.append(c.0)
        buttonList.append(c.1)
        buttonList.append(c.2)
        
        
        
        
    }
    
    // 問題文のUIを設定
    // 引数は問題文
    func setUpQuestion(contents:String) -> UITextView{
        let question = UITextView()
        question.isEditable = false // 入力を不可に
        question.isSelectable = false
        question.font = UIFont.systemFont(ofSize: 23)
        question.textColor = .systemGray
        question.textAlignment = .center
        question.text = contents
        question.sizeToFit()
        question.center = view.center
        view.addSubview(question)
        return question
    }
    
    func modQuestion(view:UITextView,contents:String){
        view.text = contents
        view.sizeToFit()
    }
    
    
    // ボタンをセットする
    // 引数はボタンに表示する文字列
    func setUpChoices(c1:String,c2:String,c3:String) -> (UIButton,UIButton,UIButton){
        let button1 = UIButton()
        button1.setTitle(c1, for: .normal)
        button1.sizeToFit()
        button1.setTitleColor(.systemBlue, for: .normal)
        button1.center = CGPoint(x: view.bounds.width/4, y: view.bounds.height*3/4)
        button1.tag = 0
        button1.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(button1)
        
        let button2 = UIButton()
        button2.setTitle(c2, for: .normal)
        button2.sizeToFit()
        button2.setTitleColor(.systemBlue, for: .normal)
        button2.center = CGPoint(x: view.bounds.width/2, y: view.bounds.height*3/4)
        button2.tag = 1
        button2.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(button2)
        
        let button3 = UIButton()
        button3.setTitle(c3, for: .normal)
        button3.sizeToFit()
        button3.setTitleColor(.systemBlue, for: .normal)
        button3.center = CGPoint(x: view.bounds.width*3/4, y: view.bounds.height*3/4)
        button3.tag = 2
        button3.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(button3)
        
        return (button1,button2,button3)
        
    }
    
    
    func modButton(button:UIButton,str:String){
        button.setTitle(str, for: .normal)
        button.sizeToFit()
    }
    
    
    
    
    // 選択肢のボタンによって処理を分ける
    @objc func buttonAction(_ sender:UIButton){
        if let ansNum = correctAnswer{
            if sender.tag == ansNum{
                // 正解処理
                print("正解")
                judgementImage(bool: true)
            }else{
                // 不正解処理
                print("不正解")
                judgementImage(bool: false)
            }
        }else{
            // エラーメッセージ
            print("エラー")
            judgementImage(bool: nil)
        }
        
        num += 1
        
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            // 0.5秒後に実行したい処理
            // 問題文の作成
            self.modQuestion(view: self.questionView, contents: self.quizList[self.num].question)
            
            // 正解の選択肢の設定
            self.correctAnswer = self.quizList[self.num].answer
            
            // 選択肢の作成
            self.modButton(button: self.buttonList[0], str: self.quizList[self.num].choices[0])
            self.modButton(button: self.buttonList[1], str: self.quizList[self.num].choices[1])
            self.modButton(button: self.buttonList[2], str: self.quizList[self.num].choices[2])
        }
        
        
        
    }
    
    // マルバツ画像の設定
    func setUpJudgmentImage() -> UIImageView{
        let imageView = UIImageView(image: nil)
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width/2, height: view.bounds.width/2)
        imageView.center = CGPoint(x: view.bounds.width/2, y: view.bounds.width/2)
        view.addSubview(imageView)
        return imageView
    }
    
    // 引数の値によって画像を設定する（判定するときに使用）
    func judgementImage(bool:Bool?){
        if let b = bool{
            if b {
                iv?.image = UIImage(named: "mark_maru")
            }else{
                iv?.image = UIImage(named: "mark_batsu")
            }
        }else{
            iv?.image = nil
        }
        
    }


}

