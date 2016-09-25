//: Playground - noun: a place where people can play

import UIKit

var firstMin = 0
var secondMin = 0
var firstMax = 100
var secondMax = 100
var newTargetValue = 7
var currentScore = 0
var currentRound = 0
var randomOperator = ""
let operationSigns = ["+", "-", "x", "÷"]

func randomValues () {
    firstMin = Int(arc4random_uniform(51))
    secondMin = Int(arc4random_uniform(51))
    firstMax = Int(arc4random_uniform(51)) + 50
    secondMax = Int(arc4random_uniform(51)) + 50
    randomOperator = operationSigns[Int(arc4random_uniform(4))]

}

randomValues()

