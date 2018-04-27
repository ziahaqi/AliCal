//
//  ViewController.swift
//  Alien Cal
//
//  Created by zia ulhaq on 4/24/18.
//  Copyright © 2018 Date Stack. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation = Operation.Empty
    
    
    @IBOutlet weak var labelCounter: UILabel!
    
    enum Operation: String {
        case Divider = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let pathUrl = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: pathUrl, fileTypeHint: "wav")
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction
    func buttonNumberPressed(sender: UIButton){
        playSound();
        
        runningNumber += "\(sender.tag)"
        labelCounter.text = runningNumber
        
    }
    
    func playSound(){
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        if currentOperation != Operation.Empty{
            if runningNumber != ""{
                rightValue = runningNumber
                runningNumber = ""
                
                if(currentOperation == Operation.Add){
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                } else if(currentOperation == Operation.Subtract){
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                }else if(currentOperation == Operation.Multiply){
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                }else if(currentOperation == Operation.Divider){
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                
                leftValue = result
                labelCounter.text = result
            }
            
            currentOperation = operation
        }else{
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }
    
    @IBAction
    func buttonAddPressed(sender: AnyObject){
        processOperation(operation: Operation.Add)
    }
    
    @IBAction
    func buttonSubstructPressed(sender: AnyObject){
        processOperation(operation: Operation.Subtract)
    }
    
    @IBAction
    func buttonDividerPressed(sender: AnyObject){
        processOperation(operation: Operation.Divider)
    }
    
    @IBAction
    func buttonMultiplyPressed(sender: AnyObject){
        processOperation(operation: Operation.Multiply)
    }
    
    @IBAction
    func buttonEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation)
    }

}

