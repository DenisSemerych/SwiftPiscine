//
//  Model.swift
//  ex02
//
//  Created by Denis SEMERYCH on 4/1/19.
//  Copyright © 2019 Denis SEMERYCH. All rights reserved.
//

class Calculator {
    var arguments = [Int]()
    var operators = [Int]()

    func save(numbers: String, mod: Int) -> String {
        var num = Int(numbers)
        arguments.append(num!)
        opPreority(of: mod, to: &operators, result: &num!)
        for i in arguments {
            print(i);
        }
        return String(num!)
    }
    func saveLastOp (_ op: Int) {
        operators.removeLast()
        operators.append(op)
    }
    func opPreority (of op: Int, to prevOp: inout [Int], result: inout Int) {
        switch op {
        case 17:
            if prevOp.count != 0 {performCalculations(operator: prevOp.removeLast(), result: &result)}
        case 13 where prevOp.count > 1:
            performCalculations(operator: prevOp.removeLast(), result: &result)
            opPreority(of: op, to: &prevOp, result: &result)
        case 13:
            if arguments.count >= 2 {performCalculations(operator: op, result: &result)} else {prevOp.append(op)}
        case 14 where prevOp.count > 1:
            performCalculations(operator: prevOp.removeLast(), result: &result)
            opPreority(of: op, to: &prevOp, result: &result)
        case 14:
            if arguments.count >= 2 {performCalculations(operator: op, result: &result)} else {prevOp.append(op)}
        case 15 where (prevOp.last == 15 || prevOp.last == 16):
            performCalculations(operator: prevOp.removeLast(), result: &result)
            opPreority(of: op, to: &prevOp, result: &result)
        case 15:
            if arguments.count >= 2 {performCalculations(operator: op, result: &result)} else {prevOp.append(op)}
        case 16 where (prevOp.last == 15 || prevOp.last == 16):
            performCalculations(operator: prevOp.removeLast(), result: &result)
            opPreority(of: op, to: &prevOp, result: &result)
        case 16:
            if arguments.count > 2 {performCalculations(operator: op, result: &result)} else {prevOp.append(op)}
        default:
            break
        }
    }
    func performCalculations(operator op: Int, result: inout Int)
    {
        switch op {
        case 13:
            result = operate{$1 + $0}
        case 14:
            result = operate{$1 - $0}
        case 15:
            result = operate{$1 * $0}
        case 16:
            result = operate{$1 / $0}
        default:
            break
        }
    }
    func operate (_ op :(Int, Int) -> Int) -> Int {
        let num = op(arguments.remove(at: arguments.endIndex - 1), arguments.removeLast())
        return num
    }
}
