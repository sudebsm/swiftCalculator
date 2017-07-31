//
//  ViewController.swift
//  SwiftCalculator
//
//  Created by Appsbee on 31/07/17.
//  Copyright © 2017 Appsbee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userTypeIsMiddle : Bool = false
    
    @IBOutlet var lblFld : UILabel?
    
    
    
    
    
    var displayValue :Double {
        
        get{
            return Double((lblFld?.text)!)!
        }
        set{
            lblFld?.text = String(newValue)
        }
    }
    
    
    @IBAction func pressDigit (sender :UIButton) {
        
        let digit = sender.currentTitle
        if userTypeIsMiddle {
            lblFld?.text = (lblFld?.text)! + digit!
        }else{
            lblFld?.text =  digit
            userTypeIsMiddle = true
        }
    }
    
    var Brain : CalculatorBrain = CalculatorBrain()
    
    @IBAction func performOperation(sender :UIButton){
        
        if userTypeIsMiddle {
            userTypeIsMiddle = false
            Brain.setOperand(operand: displayValue)
        }
        
        if let mathematicalSymbol = sender.currentTitle  {
            Brain.performOperation(symbol: mathematicalSymbol)
        }
        
        if let result = Brain.result {
            displayValue = result
        }
        
        
    }
    
}

