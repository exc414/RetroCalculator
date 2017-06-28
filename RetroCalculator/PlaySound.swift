//
//File name     : PlaySound.swift
//Project name  : RetroCalculator
//Created by    : Carlos Perez 
//Created on    : 6/25/17.
//

import Foundation
import AVFoundation

public class PlaySound
{
    //Use for sound effects
    private static var btnSound: AVAudioPlayer!;

    public static func prepareSound()
    {
        let path: String? = Bundle.main.path(forResource: "btn", ofType: "wav");
        let soundUrl: URL! = URL(fileURLWithPath: path!); //must be unwrapped
        
        do
        {
            //Get the sound url loaded into the player and prepare it to be used.
            try btnSound = AVAudioPlayer(contentsOf: soundUrl);
            btnSound.prepareToPlay();
        }
        catch let error as NSError
        {
            print(error.debugDescription);
        }
    }
    
    public static func play()
    {
        //Check to make sure that the sound is not playing. If it is
        //and a request has been made to play the sound again stop it
        //and then play it.
        if(btnSound.isPlaying) { btnSound.stop(); }
        btnSound.play();
    }
}
