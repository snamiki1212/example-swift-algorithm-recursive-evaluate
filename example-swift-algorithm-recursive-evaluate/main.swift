//
//  main.swift
//  example-swift-algorithm-recursive-evaluate
//
//  Created by shunnamiki on 2021/07/27.
//

import Foundation

enum MyError: Error {
    case InvalidCalculator;
    case InvalidExpression;
}

public func evaluate(_ expr: String) -> Int {
    if( canBeNum(expr) ) { return Int(expr) ?? -1}
    let (
        calcIdx,
        startIdxOfA,
        endIdxOfA,
        startIdxOfB,
        endIdxOfB:endIdxOfB
    ) = getIndex(expr);
    
    let left = evaluate(expr[startIdxOfA, endIdxOfA + 1])
    let right = evaluate(expr[startIdxOfB, endIdxOfB + 1])
    return try! calc(expr[calcIdx], left, right);
}

func canBeNum(_ str: String) -> Bool {
    return !str.contains("+") && !str.contains("*")
}

func calc(_ calculator: String, _ left: Int, _ right: Int) throws -> Int {
    if(calculator == "+") {return left + right;}
    if(calculator == "*") {return left * right;}
    
    throw MyError.InvalidCalculator;
}

func isCalculator(_ str: String) -> Bool {
    return str == "+" || str == "*"
}
    
func getCalcIdx(_ expr: String) throws -> Int{
    var i = 0;
    var deep = 0;
    while(i < expr.count){
        let isTopCalculator = deep == 1 && isCalculator(expr[i])
        if(isTopCalculator) { return i; }
        if(expr[i] == "(") { deep+=1; }
        if(expr[i] == ")") { deep-=1; }
        i+=1;
    }
    
    throw MyError.InvalidExpression;
}

func getIndex(_ expr: String)  -> (calcIdx: Int, startIdxOfA: Int, endIdxOfA: Int, startIdxOfB: Int, endIdxOfB: Int) {
    let calcIdx = try! getCalcIdx(expr);
    let startIdxOfA = 1;
    let endIdxOfA = calcIdx - 1
    let startIdxOfB = calcIdx + 1;
    let endIdxOfB = expr.count - 2;
    return (calcIdx: calcIdx, startIdxOfA: startIdxOfA, endIdxOfA: endIdxOfA, startIdxOfB:startIdxOfB, endIdxOfB:endIdxOfB)
}


//----------------
//var expr: String;
//expr = "7";
////expr = "(2+2)";
////expr = "((1+3)+((1+10)*5))";
//
//let result = evaluate(expr)
//print(result);
//
//
//
//
//
