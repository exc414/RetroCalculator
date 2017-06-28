//
//File name     : Toast.swift
//Project name  : RetroCalculator
//Created by    : Carlos Perez 
//Created on    : 6/25/17.
//

import Foundation
import UIKit

public class Toast
{
    init(message: String, view: UIView) { showToast(message: message, view: view); }
    
    private func showToast(message: String, view: UIView)
    {
        let rectWidth: CGFloat = 250;
        let rectHeight: CGFloat = 35;
        let slice: CGFloat = 2;

        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width / slice - (rectWidth / slice),
                                               y: view.frame.size.height - 100,
                                               width: rectWidth,
                                               height: rectHeight));
        
        //Set properties for the label.
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6);
        toastLabel.textColor = UIColor.white;
        toastLabel.textAlignment = .center;
        toastLabel.text = message;
        toastLabel.alpha = 1.0;
        toastLabel.clipsToBounds  =  true;
        toastLabel.layer.cornerRadius = 4;
        view.addSubview(toastLabel);
        
        //Animate
        UIView.animate(withDuration: 5.0, delay: 0.3, options: .curveEaseOut, animations:
            {
                toastLabel.alpha = 0.0;
        },
        completion: { (isCompleted) in toastLabel.removeFromSuperview(); } );
    }
}
