//
//  calculatorBrain.swift
//  SwiftCalculator
//
//  Created by Appsbee on 31/07/17.
//  Copyright © 2017 Appsbee. All rights reserved.
//

import Foundation



func changeSign (operand :Double)->Double {
    return -operand
}



struct CalculatorBrain {
    
    
    enum Operation {
        case Constant(Double)
        case UneryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equels
    }
    
    var Operations : Dictionary <String,Operation> = [
        "Pi":Operation.Constant(Double.pi),
        "e":Operation.Constant(M_E),
        "sqrt":Operation.UneryOperation(sqrt),
        "cos":Operation.UneryOperation(cos),
        "sin":Operation.UneryOperation(sin),
        "tan":Operation.UneryOperation(tan),
        "±":Operation.UneryOperation(changeSign)
    ]
    
    
    
    
    
    var accumulator : Double = 0.0
    
    mutating func performOperation(symbol : String)  {
        if let operation = Operations[symbol] {
            switch operation {
            case .Constant(let selValue):
                accumulator = selValue
                break
            case .UneryOperation(let function):
                accumulator = function(accumulator)
                break
            default:
                accumulator = 0.0
            }
        }
        
    }
    
    
    mutating func setOperand(operand : Double) {
        accumulator = operand
    }
    
    
    var result : Double? {
        get {
            return accumulator
        }
    }
    
    
    
}
