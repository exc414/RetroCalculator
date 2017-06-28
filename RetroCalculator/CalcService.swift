//
//File name     : CalcService.swift
//Project name  : RetroCalculator
//Created by    : Carlos Perez 
//Created on    : 6/26/17.
//

import Foundation

class CalcService
{
    static private var generalError: String = "Calc Error!";
    
    //Int32 -  4bytes - RANGE : -2 147 483 648 to 2 147 483 647 (10 digits)
    //Int64 -  8bytes - RANGE : -9 223 372 036 854 775 808 to 9 223 372 036 854 775 807 (19 digits)
    //UInt64 - 8bytes - RANGE : 0 to 18 446 744 073 709 551 615 (20 digits)
    //The standard Int/UInt value will switch as need it to
    //accomodate the range of values.
    static func process<T: Integer>(leftValue: T, rightValue: T,
                              operation: Operation) -> String
    {
        switch(operation)
        {
            case .Add: return String(describing: leftValue + rightValue);
            
            case .Subtract:
                
                if(leftValue is Int)
                {
                    print("On subtract with SIGNED integer");
                    return String(describing: leftValue - rightValue);
                }
                else if(leftValue is UInt)
                {
                    print("On subtract with UNSIGNED integer");
                    
                    //Check for the right value being larger than left value
                    //and reverse the operands and add the negative symbol to
                    //the result. UInt cannot be negative.
                    if(leftValue < rightValue)
                    {
                        let negative: String = "-";
                        let result: String = String(describing:  rightValue - leftValue);
                        return negative + result;
                    }
                    
                    return String(describing: leftValue - rightValue);
                }
                else { return generalError; }
                
            case .Multiply: return String(describing: leftValue * rightValue);
            
            case .Divide: return String(describing: leftValue / rightValue);
            
            case .Power:
                
                let result: T = customPow(leftValue: leftValue, rightValue: rightValue);
                return String(describing: result);
                
            case .SquareRoot:

                //Check how large the int is.
                if(leftValue is Int)
                {
                    print("On square root with SIGNED integer");
                    return String(format: "%.3f", sqrt(Double(leftValue as! Int)));
                }
                else if(leftValue is UInt)
                {
                    print("On square root with UNSIGNED integer");
                    return String(format: "%.3f", sqrt(Double(leftValue as! UInt)));
                }
                else { return generalError; }
            
            default: return generalError;
        }
    }
    
    //For explanation on this function see :
    //@see https://stackoverflow.com/questions/24196689/
    //@author Paul Buis
    //Explanation of the algorithm overall done in C check :
    //@see http://www.programminglogic.com/fast-exponentiation-algorithms/
    //
    private static func customPow<T: Integer>(leftValue: T, rightValue:  T) -> T
    {
        var base: T = leftValue;
        var power: T = rightValue;
        var result: T = 1;
        
        while(power != 0)
        {
            if(power % 2 == 1)
            {
                result *= base;
            }
            
            power /= 2;
            base *= base;
        }
        
        return result;
    }
}
