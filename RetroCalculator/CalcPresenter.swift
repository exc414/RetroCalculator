//
//File name     : Presenter.swift
//Project name  : RetroCalculator
//Created by    : Carlos Perez 
//Created on    : 6/25/17.
//

import Foundation

//Contract
protocol CalcPresenterProtocol
{
    func postResult(result: String);
    func error(error: String);
}

class CalcPresenter: NSObject
{
    private var presenter: CalcPresenterProtocol!;
    private var result: String!;
    
    init(presenter: CalcPresenterProtocol)
    {
        self.presenter = presenter;
    }
    
    func calculate(leftValue: String, rightValue: String, operation: Operation)
    {
        
        //If either one of these fails. The statements inside of the block wont
        //be execute it. Important so as to not have type mismatch.
        //We try for Int first and then UInt.
        if let leftValueInt = Int(leftValue), let rightValueInt = Int(rightValue)
        {
            result = CalcService.process(leftValue: leftValueInt,
                                         rightValue: rightValueInt,
                                         operation: operation);
            
            presenter.postResult(result: result);
        }
        else if let leftValueUnsignedInt = UInt(leftValue),
                let rightValueUnsignedInt = UInt(rightValue)
        {
            result = CalcService.process(leftValue: leftValueUnsignedInt,
                                         rightValue: rightValueUnsignedInt,
                                         operation: operation);

            presenter.postResult(result: result);
        }
        else
        {
            presenter.error(error: "Internal error cannot compute.");
        }
    }
}
