//
//  ViewController.swift
//  Calculator
//
//  Created by Soeng Saravit on 10/25/17.
//  Copyright © 2017 Soeng Saravit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var zeroButton:UIButton!
    @IBOutlet weak var oneButton:UIButton!
    @IBOutlet weak var twoButton:UIButton!
    @IBOutlet weak var threeButton:UIButton!
    @IBOutlet weak var fourButton:UIButton!
    @IBOutlet weak var fiveButton:UIButton!
    @IBOutlet weak var sixButton:UIButton!
    @IBOutlet weak var sevenButton:UIButton!
    @IBOutlet weak var eightButton:UIButton!
    @IBOutlet weak var nineButton:UIButton!
    @IBOutlet weak var pointButton:UIButton!
    @IBOutlet weak var plusButton:UIButton!
    @IBOutlet weak var minusButton:UIButton!
    @IBOutlet weak var multButton:UIButton!
    @IBOutlet weak var divButton:UIButton!
    @IBOutlet weak var remainderButton:UIButton!
    @IBOutlet weak var signButton:UIButton!
    @IBOutlet weak var clearButton:UIButton!
    @IBOutlet weak var equalButton:UIButton!
    
    @IBOutlet weak var firstOperandLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var firstOperand:String = ""
    var secondOperand:String = ""
    var calOperator:String = ""
    var signOperator = "+"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // --- Number Pad ---
        self.oneButton.addTarget(self, action: #selector(self.setResultValue(_:)), for: .touchUpInside)
        self.twoButton.addTarget(self, action: #selector(self.setResultValue(_:)), for: .touchUpInside)
        self.threeButton.addTarget(self, action: #selector(self.setResultValue(_:)), for: .touchUpInside)
        self.fourButton.addTarget(self, action: #selector(self.setResultValue(_:)), for: .touchUpInside)
        self.fiveButton.addTarget(self, action: #selector(self.setResultValue(_:)), for: .touchUpInside)
        self.sixButton.addTarget(self, action: #selector(self.setResultValue(_:)), for: .touchUpInside)
        self.sevenButton.addTarget(self, action: #selector(self.setResultValue(_:)), for: .touchUpInside)
        self.eightButton.addTarget(self, action: #selector(self.setResultValue(_:)), for: .touchUpInside)
        self.nineButton.addTarget(self, action: #selector(self.setResultValue(_:)), for: .touchUpInside)
        self.zeroButton.addTarget(self, action: #selector(self.setResultValue(_:)), for: .touchUpInside)
        self.pointButton.addTarget(self, action: #selector(self.setResultValue(_:)), for: .touchUpInside)
        
        // --- Sign Pad ---
        self.plusButton.addTarget(self, action: #selector(self.setOperator(_:)), for: .touchUpInside)
        self.minusButton.addTarget(self, action: #selector(self.setOperator(_:)), for: .touchUpInside)
        self.multButton.addTarget(self, action: #selector(self.setOperator(_:)), for: .touchUpInside)
        self.divButton.addTarget(self, action: #selector(self.setOperator(_:)), for: .touchUpInside)
        self.remainderButton.addTarget(self, action: #selector(self.setOperator(_:)), for: .touchUpInside)
        self.equalButton.addTarget(self, action: #selector(self.showResult(_:)), for: .touchUpInside)
        self.clearButton.addTarget(self, action: #selector(self.clear(_:)), for: .touchUpInside)
        self.signButton.addTarget(self, action: #selector(self.setSignOperator(_:)), for: .touchUpInside)
        
    }
    
    @objc func setResultValue(_ sender: UIButton) {
        if calOperator == "" {
            if resultLabel.text == "0" && (sender.titleLabel?.text)! == "." {
                self.firstOperand = "0\((sender.titleLabel?.text)!)"
            }else {
                self.firstOperand += (sender.titleLabel?.text)!
            }
            self.resultLabel.text = firstOperand
        }else {
            if resultLabel.text == "0" && (sender.titleLabel?.text)! == "." {
                self.secondOperand = "0\((sender.titleLabel?.text)!)"
            }else {
                self.secondOperand += (sender.titleLabel?.text)!
            }
            self.resultLabel.text = secondOperand
        }
    }
    
    @objc func setOperator(_ sender: UIButton) {
        calOperator = (sender.titleLabel?.text)!
        if firstOperand == "" {
            firstOperand = "0"
        }
        self.firstOperandLabel.text = "\(firstOperand) \(calOperator)"
        self.resultLabel.text = "0"
    }
    
    @objc func showResult(_ sender: UIButton){
        var firstValue = 0.0
        var secondValue = 0.0
        var result = 0.0
        
        if firstOperand != "" {
            firstValue = Double(self.firstOperand)!
        }
        if secondOperand != "" {
            secondValue = Double(self.secondOperand)!
        }else {
            secondOperand = "0"
        }
        
        switch calOperator {
        case "+":
            result = firstValue + secondValue
        case "-":
            result = firstValue - secondValue
        case "×":
            result = firstValue * secondValue
        case "÷":
            result = firstValue / secondValue
        case "%":
            result = firstValue.truncatingRemainder(dividingBy: secondValue)
        default:
            fatalError("Wrong Operand")
        }
        self.firstOperandLabel.text = "\(firstOperand) \(calOperator) \(secondOperand)"
        self.resultLabel.text = String(format: "%g", result)
        if resultLabel.text! == "0" {
            firstOperand = ""
        }else {
           self.firstOperand = resultLabel.text!
        }
        self.calOperator = ""
        self.secondOperand = ""
    }
    
    @objc func clear(_ sender:UIButton){
        self.firstOperand = ""
        self.secondOperand = ""
        self.resultLabel.text = "0"
        self.calOperator = ""
        self.firstOperandLabel.text = ""
    }
    
    @objc func setSignOperator(_ sender:UIButton) {
        if calOperator == "" {
            let fo = Double(firstOperand)
            if let value = fo {
                var result = 0.0
                if value > 0.0 {
                    result = 0 - value
                }else if value < 0.0 {
                    result = 0 - value
                }
                firstOperand = "\(result)"
                self.resultLabel.text = firstOperand
            }
        }else {
            let so = Double(secondOperand)
            if let value = so {
                var result = 0.0
                if value > 0.0 {
                    result = 0 - value
                }else if value < 0.0 {
                    result = 0 - value
                }
                secondOperand = "\(result)"
                self.resultLabel.text = secondOperand
            }
        }
    }
}

@IBDesignable class customButton: UIButton {
    
    @IBInspectable
    public var cornerRadius: CGFloat = 2.0 {
        didSet {
           self.layer.cornerRadius = self.cornerRadius
        }
    }
}
