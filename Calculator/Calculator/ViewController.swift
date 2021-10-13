//
//  ViewController.swift
//  Calculator
//
//  Created by nju on 2021/10/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.displayLabel.text! = ""
    }

    @IBOutlet weak var displayLabel: UILabel!
    
    var digitOnDisplay: String {
        get {
            return self.displayLabel.text!
        }
        set {
            self.displayLabel.text! = newValue
        }
    }
    
    var inTypingMode = false
    
    @IBAction func numberTouched(_ sender: UIButton) {
        print("number \(sender.currentTitle!) touched")
        if inTypingMode {
            digitOnDisplay += sender.currentTitle!
        }
        else {
            digitOnDisplay = sender.currentTitle!
            inTypingMode = true
        }
    }
    
    let calculator = Calculator()
     
    @IBAction func operatorTouched(_ sender: UIButton) {
        print("operator \(sender.currentTitle!) touched")
        if sender.currentTitle! == "Clear" {
            self.displayLabel.text! = ""
            inTypingMode = false
            return
        }
        else if sender.currentTitle! == "(" ||
            sender.currentTitle! == ")" {
            return
        }
        else if sender.currentTitle! == "pi" {
            digitOnDisplay = "3.142"
        }
        else if sender.currentTitle! == "e" {
            digitOnDisplay = "2.718"
        }
        
        if let op = sender.currentTitle {
            print("digitOndisplay: \(digitOnDisplay)")
            if let result = calculator.performOperation(operation: op, operand: Double(digitOnDisplay)!) {
                self.displayLabel.text! = String(result)
            }
            
            inTypingMode = false
        }
    }
}

