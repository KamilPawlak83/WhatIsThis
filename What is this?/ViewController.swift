//
//  ViewController.swift
//  What is this?
//
//  Created by Kamil Pawlak on 07/09/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var answerNameLabel: UILabel!
    var answerPercentLabel: UILabel!
    
    override func loadView() {
        view = UIView()
        
        answerNameLabel = UILabel()
        answerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        answerNameLabel.font = UIFont.systemFont(ofSize: 24)
        answerNameLabel.textAlignment = .center
        answerNameLabel.text = "Name"
        answerNameLabel.isHidden = false
        answerNameLabel.backgroundColor = UIColor.systemPurple
        answerNameLabel.layer.masksToBounds = true
        answerNameLabel.layer.cornerRadius = 8
        answerNameLabel.layer.borderWidth = 1
        answerNameLabel.layer.borderColor = UIColor.black.cgColor
        view.addSubview(answerNameLabel)
        
        
        answerPercentLabel = UILabel()
        answerPercentLabel.translatesAutoresizingMaskIntoConstraints = false
        answerPercentLabel.font = UIFont.systemFont(ofSize: 24)
        answerPercentLabel.textAlignment = .center
        answerPercentLabel.text = "Percent"
        answerPercentLabel.isHidden = false
        answerPercentLabel.backgroundColor = UIColor.systemPurple
        answerNameLabel.layer.masksToBounds = true
        answerPercentLabel.layer.cornerRadius = 8
        answerPercentLabel.layer.borderWidth = 1
        answerPercentLabel.layer.borderColor = UIColor.black.cgColor
        view.addSubview(answerPercentLabel)
        
        //temporary
        
//        answerNameLabel.backgroundColor = .blue
//        answerPercentLabel.backgroundColor = .green
//
        NSLayoutConstraint.activate([
            
            answerNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            answerNameLabel.bottomAnchor.constraint(equalTo: answerPercentLabel.topAnchor, constant: -20),
            answerNameLabel.heightAnchor.constraint(equalToConstant: 30),
           
            answerPercentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerPercentLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            answerPercentLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            answerPercentLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

