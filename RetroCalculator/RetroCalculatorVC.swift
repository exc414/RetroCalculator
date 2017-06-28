//
//File name    : RetroCalculatorVC.swift
//Project Name : RetroCalculator
//Created by   : Carlos Perez
//Create on    : 6/24/17
//

import UIKit
import AVFoundation

class RetroCalculatorVC: UIViewController
{
    @IBOutlet weak var lblOutput: UILabel!;
    
    private var presenter: CalcPresenter!;
    fileprivate var runningNumber: String = "";
    fileprivate var operation: Operation = Operation.Empty;
    private var leftValue = "";
    private var rightValue = "";
    
    //18 digits represents about the full range of a signed Int.
    //But could be higher so we use UInt if this is the case.
    private let maxNumberOfDigits: Int = 19;
    
    //Error messages
    private let exceededDigits: String = "Max number of digits exceeded!";
    private let operandsMsg: String = "Operands are needed!";
    private let needOperator: String = "Need operator to perform operation.!";
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        presenter = CalcPresenter(presenter: self);
        PlaySound.prepareSound();
    }
    
    @IBAction func onAddPressed(sender: AnyObject)
    {
        prep(operation: .Add, value: runningNumber);
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject)
    {
        prep(operation: .Subtract, value: runningNumber);
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject)
    {
        prep(operation: .Multiply, value: runningNumber);
    }
    
    @IBAction func onDividePressed(sender: AnyObject)
    {
        prep(operation: .Divide, value: runningNumber);
    }
    
    @IBAction func onPowerPressed(sender: AnyObject)
    {
        prep(operation: .Power, value: runningNumber);
    }
    
    //TODO check that the user inputted an value
    @IBAction func onSquareRootPressed(sender: AnyObject)
    {
        prep(operation: .SquareRoot, value: runningNumber);
        
        //Check to make sure we have a number to work with.
        if(leftValue == "")
        {
            toast(message: operandsMsg);
            return;
        }
        else
        {
            presenter.calculate(leftValue: leftValue,
                                rightValue: "0",
                                operation: operation);
        }
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject)
    {
        PlaySound.play();
        process(leftValue: leftValue, rightValue: runningNumber);
    }
    
    @IBAction func onClearPressed(sender: AnyObject)
    {
        PlaySound.play();
        clear();
    }
    
    //Append pressed button number to the runningNumber
    @IBAction func btnPressed(sender: UIButton)
    {
        PlaySound.play();
        
        //Check to make sure that the number will fit into 
        //an Int64 (19) we take 18 digits.
        if(runningNumber.characters.count < maxNumberOfDigits)
        {
            //The tag was setup in the main storyboard under
            //the view properties. += works just as String.append().
            runningNumber += "\(sender.tag)";
            lblOutput.text = runningNumber;
        }
        else
        {
            //The use of _ = allows to ignore the result 
            //threfore swift wont show warning.
            toast(message: exceededDigits);
        }
    }
    
    private func process(leftValue: String, rightValue: String)
    {
        if(operation != .Empty && operation != .SquareRoot)
        {
            //Check to make sure that both operands have values.
            if(leftValue == "" || rightValue == "")
            {
                toast(message: operandsMsg);
                clear();
            }
            else
            {
                presenter.calculate(leftValue: leftValue,
                                    rightValue: rightValue,
                                    operation: operation);
            }
        }
        else
        {
            //User pressed equals before selecting an operator.
            toast(message: needOperator);
        }
    }
    
    //Set left value, operation and reset the running number
    fileprivate func prep(operation: Operation, value: String)
    {
        PlaySound.play();
        leftValue = value;
        runningNumber = "";
        self.operation = operation;
    }
    
    //Set all vars back to default
    private func clear()
    {
        runningNumber = "";
        lblOutput.text = "0";
        leftValue = "";
        rightValue = "";
        operation = Operation.Empty;
    }
    
    //Create a toast
    fileprivate func toast(message: String)
    {
        _ = Toast(message: message, view: view);
    }
}

//Implementation of protocol
extension RetroCalculatorVC: CalcPresenterProtocol
{
    func postResult(result: String)
    {
        lblOutput.text = result;
        runningNumber = result;
    }
    
    func error(error: String) { toast(message: error); }
}
