//
//  Model.swift
//  ex02
//
//  Created by Denis SEMERYCH on 4/1/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

class Calculator {
    static var arguments = [Int]()
    static var operators = [Int]()

    func save(numbers: String, mod: Int) -> String {
        var num = Int(numbers)
        Calculator.arguments.append(num!)
        opPreority(of: mod, to: &Calculator.operators, result: &num!, arguments: &Calculator.arguments)
        giveResult(result: &num!, arguments: &Calculator.arguments, operators: &Calculator.operators)
        if (Calculator.operators.count == 0) {Calculator.operators.append(mod)}
        return String(num!)
    }
    
    func opPreority (of op: Int, to prevOp: inout [Int], result: inout Int, arguments: inout [Int]) {
        if (prevOp.count == 0) {
            prevOp.append(op)
        } else {
            switch op {
            case 17:
                performCalculations(operator: prevOp.removeLast(), result: &result, arguments: &arguments)
                giveResult(result: &result, arguments: &arguments, operators: &prevOp)
            case 13:
                performCalculations(operator: prevOp.removeLast(), result: &result, arguments: &arguments)
            case 14:
                performCalculations(operator: prevOp.removeLast(), result: &result, arguments: &arguments)
            case 15 where prevOp.last! != 15 && prevOp.last! != 16,
                 16 where prevOp.last! != 15 && prevOp.last! != 16:
                prevOp.append(op)
            case 15, 16:
                performCalculations(operator: prevOp.removeLast(), result: &result, arguments: &arguments)
            default:
                break
            }
        }
    }
    
    func performCalculations(operator op: Int, result: inout Int, arguments: inout [Int]) {
        switch op {
        case 13:
            result = operate({$1 + $0}, arguments: &arguments)
        case 14:
            result = operate({$1 - $0}, arguments: &arguments)
        case 15:
            result = operate({$1 * $0}, arguments: &arguments)
        case 16:
            result = operate({if $0 == 0 || $1 == 0 {
                return 0
            }else{
                return $1 / $0}
            }, arguments: &arguments)
        default:
            break
        }
    }
    
    func operate (_ op :(Int, Int) -> Int, arguments: inout [Int]) -> Int {
        let num = op(arguments.remove(at: arguments.endIndex - 1), arguments.removeLast())
        arguments.append(num)
        return num
    }
    
    func giveResult(result: inout Int, arguments: inout [Int], operators: inout [Int]){
        if (arguments.count == 2 && operators.count == 1) {
            performCalculations(operator: operators.removeLast(), result: &result, arguments: &arguments)
        }
    }
}
