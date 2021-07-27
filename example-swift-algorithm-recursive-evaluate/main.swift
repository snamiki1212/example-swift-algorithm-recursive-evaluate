//
//  main.swift
//  example-swift-algorithm-recursive-evaluate
//
//  Created by shunnamiki on 2021/07/27.
//

import Foundation




func evaluate(_ expr: String) -> Int {
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
    return calc(expr[calcIdx], left, right);
}

func canBeNum(_ str: String) -> Bool {
    return !str.contains("+") && !str.contains("*")
}

func calc(_ calculator: String, _ left: Int, _ right: Int) -> Int{
    if(calculator == "+") {return left + right;}
    if(calculator == "*") {return left * right;}
    
    print("[Error]Invalid calcolator")
    return -1
//    throw Error("Invalid calculator")
}

func isCalculator(_ str: String) -> Bool {
    return str == "+" || str == "*"
}

func getIndex(_ expr: String) -> (calcIdx: Int, startIdxOfA: Int, endIdxOfA: Int, startIdxOfB: Int, endIdxOfB: Int) {
    
    let (calcIdx, endIdxOfA, startIdxOfB): (Int, Int, Int) = {
        var calcIdx: Int, endIdxOfA: Int, startIdxOfB: Int;

        var i = 0;
        var deep = 0;
        while(i < expr.count){
            let isCenterCalculator = deep == 1 && isCalculator(expr[i])
            if(isCenterCalculator) {
                endIdxOfA = i - 1
                calcIdx = i
                startIdxOfB = i + 1;
                return(calcIdx, endIdxOfA, startIdxOfB)
            }
            if(expr[i] == "(") { deep+=1; }
            if(expr[i] == ")") { deep-=1; }
            i+=1;
        }
        
        //        throw Error("Invalid data. it's not full-parenthesis.")
        print("[Error]Invalid data.", i, deep)
        return (-1, -1, -1)
    }()
        
    let startIdxOfA = 1;
    let endIdxOfB = expr.count - 2;
    return (calcIdx: calcIdx, startIdxOfA: startIdxOfA, endIdxOfA: endIdxOfA, startIdxOfB:startIdxOfB, endIdxOfB:endIdxOfB)
}


//----------------
var expr: String;
//expr = "7";
expr = "(2+2)";
expr = "((1+3)+((1+10)*5))";

let result = evaluate(expr)
print(result);




