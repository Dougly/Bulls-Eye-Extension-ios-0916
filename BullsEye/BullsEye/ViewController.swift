//
//  ViewController.swift
//  BullsEye
//
//  Created by Douglas Galante on 9/24/16.
//  Copyright © 2016 Douglas Galante. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var targetValue: UILabel!
    @IBOutlet weak var topMin: UILabel!
    @IBOutlet weak var topMax: UILabel!
    @IBOutlet weak var botMin: UILabel!
    @IBOutlet weak var botMax: UILabel!
    @IBOutlet weak var operationSign: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var topSliderObject: UISlider!
    @IBOutlet weak var bottomSliderObject: UISlider!
    @IBOutlet weak var infoTextBox: UITextView!
    
    @IBAction func infoButton(_ sender: AnyObject) {
        if infoTextBox.isHidden == true {
            infoTextBox.isHidden = false
        } else if infoTextBox.isHidden == false {
            infoTextBox.isHidden = true
        }
    }
    @IBAction func restart(_ sender: AnyObject) {
        currentScore = 0.0
        currentRound = 1
        viewDidLoad()
    }
    @IBAction func hitMe(_ sender: AnyObject) {
        determineScoreAndRound()
        updateBoardForScoreAndRound()
        assignRandomValues()
        checkIfTargetValueIsUsable()
        assignRandomValuesToSliderBars()
        updateBoardForGame()
    }
    
    var firstMin = 0
    var secondMin = 0
    var firstMax = 100
    var secondMax = 100
    var newTargetValue = 7
    var currentScore: Float = 0.0
    var currentRound = 1
    var randomOperationSign = ""
    let operationSigns = ["+", "-", "x", "÷"]

    override func viewDidLoad() {
        infoTextBox.isHidden = true
        assignRandomValues()
        assignRandomValuesToSliderBars()
        updateBoardForGame()
        checkIfTargetValueIsUsable()
        updateBoardForScoreAndRound()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //helper methods
    func assignRandomValues () {
        firstMin = Int(arc4random_uniform(51))
        secondMin = Int(arc4random_uniform(51))
        firstMax = Int(arc4random_uniform(51)) + 50
        secondMax = Int(arc4random_uniform(51)) + 50
        randomOperationSign = operationSigns[Int(arc4random_uniform(4))]
        newTargetValue = Int(arc4random_uniform(101))
    }
    
    func checkIfTargetValueIsUsable () {
        switch randomOperationSign {
        case "+":
            if firstMin + secondMin > newTargetValue {
                newTargetValue = firstMin + secondMin
            }
            break
        case "-":
            if firstMax - secondMax > newTargetValue {
                newTargetValue = firstMax - secondMax
            }
            break
        case "x":
            if firstMin * secondMin > newTargetValue {
                newTargetValue = firstMin * secondMin
            }
            break
        case "÷":
            if firstMax / secondMin < newTargetValue {
                newTargetValue = firstMax / secondMin
            }
            break
        default:
            break
        }
    }
    
    func assignRandomValuesToSliderBars () {
        topSliderObject.minimumValue = Float(firstMin)
        topSliderObject.maximumValue = Float(firstMax)
        bottomSliderObject.minimumValue = Float(secondMin)
        bottomSliderObject.maximumValue = Float(secondMax)
    }
    
    func determineScoreAndRound () {
        var roundScore: Float = 0.0
        switch randomOperationSign {
        case "+":
            roundScore = (topSliderObject.value + bottomSliderObject.value) - Float(newTargetValue)
            roundScore = avoidNegativeScore(score: roundScore)
            break
        case "-":
            roundScore = (topSliderObject.value - bottomSliderObject.value) - Float(newTargetValue)
            roundScore = avoidNegativeScore(score: roundScore)
            break
        case "x":
            roundScore = (topSliderObject.value * bottomSliderObject.value) - Float(newTargetValue)
            roundScore = avoidNegativeScore(score: roundScore)
            break
        case "÷":
            roundScore = (topSliderObject.value / bottomSliderObject.value) - Float(newTargetValue)
            roundScore = avoidNegativeScore(score: roundScore)
            break
        default:
            break
        }
        currentScore += roundScore
        currentRound += 1
    }
    
    func avoidNegativeScore (score: Float) -> Float{
        if score < 0 {
            return score * -1
        } else {
            return score
        }
    }
    
    func updateBoardForGame () {
        targetValue.text = String(newTargetValue)
        topMin.text = String(firstMin)
        topMax.text = String(firstMax)
        botMin.text = String(secondMin)
        botMax.text = String(secondMax)
        operationSign.text = randomOperationSign
    }
    
    func updateBoardForScoreAndRound () {
        score.text = String(Int(currentScore))
        round.text = String(currentRound)
    }

}

