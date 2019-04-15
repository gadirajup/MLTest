//
//  ViewController.swift
//  BetterRest
//
//  Created by Prudhvi Gadiraju on 4/14/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let wakeUpTitle: UILabel = {
        let label = UILabel()
        label.text = "When do you want to wake up?"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    let wakeUpTime: UIDatePicker = {
        let dp = UIDatePicker()
        
        var components = Calendar.current.dateComponents([.hour, .minute], from: Date())
        components.hour = 8
        components.minute = 0
        
        dp.date = Calendar.current.date(from: components) ?? Date()
        dp.datePickerMode = .time
        dp.minuteInterval = 15
        return dp
    }()
    
    let sleepAmountTitle: UILabel = {
        let label = UILabel()
        label.text = "How much sleep do you need?"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    let sleepAmountTime: UIStepper = {
        let s = UIStepper()
        s.stepValue = 0.25
        s.value = 8
        s.minimumValue = 4
        s.maximumValue = 12
        s.addTarget(self, action: #selector(handleTimeStepper), for: .valueChanged)
        return s
    }()
    
    let sleepAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "8"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    let coffeeAmountTitle: UILabel = {
        let label = UILabel()
        label.text = "How many cups of coffee did you have?"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    let coffeeAmountTime: UIStepper = {
        let s = UIStepper()
        s.stepValue = 1
        s.value = 1
        s.minimumValue = 1
        s.maximumValue = 20
        s.addTarget(self, action: #selector(handleCoffeeStepper(_:)), for: .valueChanged)
        return s
    }()
    
    let coffeeAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    override func loadView() {
        // View
        view = UIView()
        view.backgroundColor = .white
        
        let sleepAmountStackView = UIStackView(arrangedSubviews: [sleepAmountTime, sleepAmountLabel])
        sleepAmountStackView.axis = .horizontal
        sleepAmountStackView.spacing = 20
        sleepAmountStackView.distribution = .fillProportionally
        
        let coffeeAmountStackView = UIStackView(arrangedSubviews: [coffeeAmountTime, coffeeAmountLabel])
        coffeeAmountStackView.axis = .horizontal
        coffeeAmountStackView.spacing = 20
        coffeeAmountStackView.distribution = .fillProportionally
        
        // Main Stack View
        let mainStackView = UIStackView(arrangedSubviews: [wakeUpTitle, wakeUpTime, sleepAmountTitle, sleepAmountStackView, coffeeAmountTitle, coffeeAmountStackView])
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

        title = "Better Rest"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Calculate", style: .plain, target: self, action: #selector(calculateBedtime))
    }

    @objc fileprivate func handleTimeStepper(_ sender: UIStepper) {
        sleepAmountLabel.text = String(format: "%g hours", sleepAmountTime.value)
    }
    
    @objc fileprivate func handleCoffeeStepper(_ sender: UIStepper) {
        coffeeAmountLabel.text = String(format: "%i cup(s)", Int(coffeeAmountTime.value))
    }
    
    @objc fileprivate func calculateBedtime() {
        let model = SleepCalculator()
        
        var title = ""
        var message = ""
        
        do {
            let prediction = try model.prediction(coffee: coffeeAmountTime.value, estimatedSleep: sleepAmountTime.value, wake: Double(getWake()))
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            let wakeDate = wakeUpTime.date - prediction.actualSleep
            message = formatter.string(from: wakeDate)
            title = "Sleep @: "
        } catch {
            title = "Error"
            message = "Sorry :("
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    fileprivate func getWake() -> Int {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime.date)
        let hour = (components.hour ?? 0) * 60 * 60
        let minutes = (components.minute ?? 0) * 60
        
        return hour + minutes
    }
}

