//
//  ViewController.swift
//  BetterRest
//
//  Created by Prudhvi Gadiraju on 4/14/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var wakeUpTitle: UILabel = {
        let label = UILabel()
        label.text = "When do you want to wake up?"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    lazy var wakeUpTime: UIDatePicker = {
        let dp = UIDatePicker()
        return dp
    }()
    
    lazy var sleepAmountTime: UIStepper = {
        let s = UIStepper()
        return s
    }()
    
    lazy var sleepAmountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var coffeeAmountTime: UIStepper = {
        let s = UIStepper()
        return s
    }()
    
    lazy var coffeeAmountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        let mainStackView = UIStackView(arrangedSubviews: [wakeUpTitle, wakeUpTime, sleepAmountTime, sleepAmountLabel, coffeeAmountTime, coffeeAmountLabel])
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.distribution = .fillProportionally
        
        view.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

