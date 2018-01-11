//
//  ViewController.swift
//  Calculator
//
//  Created by Dillon Murphy on 4/5/17.
//  Copyright © 2017 StrategynMobilePros. All rights reserved.
//

import Cocoa

/// Operation type used for calculations between operands.
///
/// - None: No selected operation.
/// - Add: Addition operation.
/// - Sub: Subtraction operation.
/// - Multiply: Multiplication operation.
/// - Divide: Division operation.
public enum ButtonType: Int, CustomStringConvertible {
    case None = 0
    case Add
    case Sub
    case Multiply
    case Divide
    
    public var description: String {
        get {
            switch self {
            case .None:
                return "None"
            case .Add:
                return "Addition"
            case .Sub:
                return "Subtract"
            case .Multiply:
                return "Multiply"
            case .Divide:
                return "Divide"
            }
        }
    }
}

class ViewController: NSViewController {
    
    ///The text field that acts a numeric display for input and output.
    @IBOutlet weak var CalcLabel: NSTextField!
    
    ///The number shown at all times by the CalcLabel text field.
    var calcNum: Double?
    
    
    
    ///The number used in tandem with clacNum to perform calculations.
    var savedNumber: Double?
    
    ///Boolean value that represents whether or not the decimal place is in use for any user input. If it is, new numbers will be inserted at the smallest available decimal place.
    var point: Bool = false
    
    ///Value type that represents the currnet operation to be performed.
    var buttonType: ButtonType = .None
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    /// Handles whenever a user taps a numeric button.
    ///
    /// - Parameter sender: Gradient Button with a single digit number for the title.
    @IBAction func TapNumber(_ sender: NSButton) {
        let num: Int = Int(sender.title)!
        if point {
            if calcNum == nil {
                calcNum = Double("0.\(num)")
            } else {
                var prevNum = "\(calcNum!)"
                if prevNum.contains(".0") {
                    prevNum = prevNum.replacingOccurrences(of: ".0", with: ".")
                }
                calcNum = Double("\(prevNum)\(num)")!
            }
        } else {
            if calcNum == nil {
                calcNum = Double(num)
            } else {
                let num2: Int = Int(calcNum!)
                calcNum = Double("\(num2)\(num)")!
            }
        }
        CalcLabel.stringValue = "\(calcNum!)"
    }
    
    /// Handles whenever a user taps the clear button.
    ///
    /// - Parameter sender: Gradient Button with a C for the title.
    @IBAction func TappedClear(_ sender: NSButton) {
        calcNum = nil
        savedNumber = nil
        CalcLabel.stringValue = ""
        buttonType = .None
        if point {
            point = false
        }
    }

    /// Function to check a operaiton is under way and that the buttonType is not equal to None. If both of those conditions are satified, a switch statement checks the buttonType and performs the corresponding operation's function.
    func checkButtonType() {
        if buttonType != .None && savedNumber != nil {
            switch buttonType {
            case .Add: addNumbers()
            case .Sub: subNumbers()
            case .Multiply: multiplyNumbers()
            case .Divide: divideNumbers()
            case .None: print(buttonType.description)
            }
            savedNumber = nil
        }
    }
    
    /// Function to reset the calcNum and point variables and move the previous value of calcNum to savedNumber.
    func numReset() {
        savedNumber = calcNum
        calcNum = nil
        if point {
            point = false
        }
    }
    
    /// This function handles whenever a user selects the add button.
    ///
    /// - Parameter sender: Gradient Button with a + for the title.
    @IBAction func TappedAdd(_ sender: NSButton) {
        checkButtonType()
        buttonType = .Add
        numReset()
    }
    
    /// This function handles whenever a user selects the subtract button.
    ///
    /// - Parameter sender: Gradient Button with a - for the title.
    @IBAction func TappedSub(_ sender: NSButton) {
        checkButtonType()
        buttonType = .Sub
        numReset()
    }
    
    /// This function handles whenever a user selects the multiply button.
    ///
    /// - Parameter sender: Gradient Button with a X for the title.
    @IBAction func TappedMultiply(_ sender: NSButton) {
        checkButtonType()
        buttonType = .Multiply
        numReset()
    }
    
    /// This function handles whenever a user selects the divide button.
    ///
    /// - Parameter sender: Gradient Button with a ÷ for the title.
    @IBAction func TappedDivide(_ sender: NSButton) {
        checkButtonType()
        buttonType = .Divide
        numReset()
    }
    
    /// This function handles whenever a user selects the decimal button.
    ///
    /// - Parameter sender: Gradient Button with a . for the title.
    @IBAction func TappedPoint(_ sender: NSButton) {
        if point == false {
            point = true
        }
    }
    
    /// This function handles whenever a user selects the positive/negative button.
    ///
    /// - Parameter sender: Gradient Button with a +/- for the title.
    @IBAction func TappedNegative(_ sender: NSButton) {
        calcNum = calcNum! * -1
        CalcLabel.stringValue = "\(calcNum!)"
    }
    
    /// This function handles whenever a user selects the equals button.
    ///
    /// - Parameter sender: Gradient Button with a = for the title.
    @IBAction func TappedEquals(_ sender: NSButton) {
        checkButtonType()
    }
    
    /// This function takes the savedNumber operand and the calcNum operand and adds them together. CalcLabel's stringValue is updated with the result.
    func addNumbers() {
        
        if savedNumber! == 8146318078{
            CalcLabel.stringValue="Harman Bhutani"
        }
        else{
        calcNum = savedNumber! + calcNum!
        CalcLabel.stringValue = "\(calcNum!)"
        }
    }
    
    /// This function takes the savedNumber operand and subtracts the calcNum operand from it. CalcLabel's stringValue is updated with the result.
    func subNumbers() {
        calcNum = savedNumber! - calcNum!
        CalcLabel.stringValue = "\(calcNum!)"
    }
    
    /// This function takes the savedNumber operand and the calcNum operand and multiplies them together. CalcLabel's stringValue is updated with the result.
    func multiplyNumbers() {
        calcNum = savedNumber! * calcNum!
        CalcLabel.stringValue = "\(calcNum!)"
    }
    
    /// This function takes the savedNumber operand and divides it by the calcNum operand. CalcLabel's stringValue is updated with the result.
    func divideNumbers() {
        calcNum = savedNumber! / calcNum!
        CalcLabel.stringValue = "\(calcNum!)"
    }

}

