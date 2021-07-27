//
//  main.swift
//  example-swift-algorithm-recursive-evaluate
//
//  Created by shunnamiki on 2021/07/27.
//

import Foundation

enum MyError: Error {
    case InvalidOperation;
    case InvalidExpression;
}

public func evaluate(_ expr: String) -> Int {
    if( canBeNum(expr) ) { return Int(expr) ?? -1}
    let (operation, leftStr, rightStr) = getTopEachElement(expr);
    let leftNum = evaluate(leftStr)
    let rightNum = evaluate(rightStr)
    return try! calc(operation, leftNum, rightNum);
}

func canBeNum(_ str: String) -> Bool {
    return !str.contains("+") && !str.contains("*")
}

func calc(_ operation: String, _ left: Int, _ right: Int) throws -> Int {
    if(operation == "+") {return left + right;}
    if(operation == "*") {return left * right;}
    
    throw MyError.InvalidOperation;
}

func isOperation(_ str: String) -> Bool {
    return str == "+" || str == "*"
}

func getTopEachElement(_ expr: String) -> (operation: String, leftStr: String, rightStr: String) {
    let (
        calcIdx,
        startIdxOfLeft,
        endIdxOfLeft,
        startIdxOfRight,
        endIdxOfRight
    ) = getIndex(expr);
    
    return (
        operation: expr[calcIdx],
        leftStr: expr[startIdxOfLeft, endIdxOfLeft + 1],
        rightStr: expr[startIdxOfRight, endIdxOfRight + 1]
    )
}
    
func getCalcIdx(_ expr: String) throws -> Int{
    var i = 0;
    var deep = 0;
    while(i < expr.count){
        let isTopOperation = deep == 1 && isOperation(expr[i])
        if(isTopOperation) { return i; }
        if(expr[i] == "(") { deep+=1; }
        if(expr[i] == ")") { deep-=1; }
        i+=1;
    }
    
    throw MyError.InvalidExpression;
}

func getIndex(_ expr: String)  -> (calcIdx: Int, startIdxOfLeft: Int, endIdxOfLeft: Int, startIdxOfRight: Int, endIdxOfRight: Int) {
    let calcIdx = try! getCalcIdx(expr);
    let startIdxOfLeft = 1;
    let endIdxOfLeft = calcIdx - 1
    let startIdxOfRight = calcIdx + 1;
    let endIdxOfRight = expr.count - 2;
    return (
        calcIdx: calcIdx,
        startIdxOfLeft: startIdxOfLeft,
        endIdxOfLeft: endIdxOfLeft,
        startIdxOfRight: startIdxOfRight,
        endIdxOfRight: endIdxOfRight
    )
}


//----------------
//var expr: String;
//expr = "7";
//expr = "(2+2)";
//expr = "((1+3)+((1+10)*5))";
//let result = evaluate(expr)
//print(result);
