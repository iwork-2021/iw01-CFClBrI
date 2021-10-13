//
//  Calculator.swift
//  Calculator
//
//  Created by nju on 2021/10/10.
//

import UIKit

class Calculator: NSObject {
    enum Operation {
        case UnaryOp((Double)->Double)
        case BinaryOp((Double, Double)->Double)
        case EqualOp
        case Constant(Double)
    }
    
    var operations = [
        "+": Operation.BinaryOp {
            (op1, op2) in
            return op1 + op2
        },
        
        "-": Operation.BinaryOp {
            (op1, op2) in
            return op1 - op2
        },
        
        "*": Operation.BinaryOp {
            (op1, op2) in
            return op1 * op2
        },
        
        "/": Operation.BinaryOp {
            (op1, op2) in
            return op1 / op2
        },
        
        "x^y": Operation.BinaryOp {
            (op1, op2) in
            return pow(op1, op2)
        },
        
        "%": Operation.UnaryOp {
            op in
            return op / 100.0
        },
        
        "+/-": Operation.UnaryOp {
            op in
            return -op
        },
        
        "x^2": Operation.UnaryOp {
            op in
            return op * op
        },
        
        "√": Operation.UnaryOp {
            op in
            return sqrt(op)
        },
         
        "ln": Operation.UnaryOp {
            op in
            return log(op) / log(2.718)
        },
        
        "x!": Operation.UnaryOp {
            op in
            var res = 1
            for i in 1 ... Int(op) {
                res *= i
            }
            return Double(res)
        },
        
        "sin": Operation.UnaryOp {
            op in
            return sin(op)
        },
        
        "cos": Operation.UnaryOp {
            op in
            return cos(op)
        },
        
        "tan": Operation.UnaryOp {
            op in
            return tan(op)
        },
        
        "=": Operation.EqualOp,
        
        "pi": Operation.Constant(3.142),
        
        "e": Operation.Constant(2.718)
    ]
    
    struct Intermediate {
        var firstOp: Double
        var waitingOp: (Double, Double)->Double
    }
    var pendingOp: Intermediate? = nil
    
    func performOperation(operation: String, operand: Double)->Double? {
        if let op = operations[operation] {
            switch op {
            case Operation.BinaryOp(let function):
                pendingOp = Intermediate(firstOp: operand, waitingOp: function)
                return nil
            case Operation.UnaryOp(let function):
                return function(operand)
            case Operation.Constant(let value):
                return value
            case Operation.EqualOp:
                return pendingOp!.waitingOp(pendingOp!.firstOp, operand)
            }
        }
        return nil
    }
}
