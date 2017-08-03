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
        "±":Operation.UneryOperation({ -$0 }),
        "+":Operation.BinaryOperation({ $0 + $1}),
        "-":Operation.BinaryOperation({ $0 - $1}),
        "*":Operation.BinaryOperation({ $0 * $1}),
        "/":Operation.BinaryOperation({ $0 / $1}),
        "=":Operation.Equels
    ]
    
    
    
    
    
    var accumulator : Double?
    
    mutating func performOperation(symbol : String)  {
        if let operation = Operations[symbol] {
            switch operation {
            case .Constant(let selValue):
                accumulator = selValue
                break
            case .UneryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
                break
            case .BinaryOperation(let function):
                if accumulator != nil {
                    pbo=PendingBinaryOperation(function:function, firstOperand:accumulator!)
                    accumulator = nil
                }
                break
            case .Equels:
                performPendingBinaryOperation()
                break
            default:
                break
            }
        }
        
    }
    
    
    private mutating func performPendingBinaryOperation()  {
        if pbo != nil && accumulator != nil {
            accumulator = pbo!.perform(with: accumulator!)
            pbo = nil
        }
    }
    
    
    
    var pbo:PendingBinaryOperation?
    
    
    struct PendingBinaryOperation {
        
        let function:(Double,Double)->Double
        let firstOperand:Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand,secondOperand)
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
