//
//  ViewController.swift
//  WowApp
//
//  Created by Turner Thornberry on 5/26/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController, AVAudioPlayerDelegate  {
    //MARK: - Outlets
    @IBOutlet weak var face: UIButtonX!
    
    var wowSound: AVAudioPlayer?
    
    @IBAction func facePress(_ sender: UIButtonX) {
        //arc4random makes random number between 0 and upper bound -1, therefore +1 needed to counteract
        let path = Bundle.main.path(forResource: "Wow\(Int(arc4random_uniform(45))+1).mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            wowSound = try AVAudioPlayer(contentsOf: url)
            wowSound?.delegate = self // sets av player delegate protocol
            wowSound?.play()
            face.setImage(#imageLiteral(resourceName: "Wow_NBG.png"), for: .normal)
            UIView.animate(withDuration: (wowSound?.duration)!, animations: ({
                //first one rotates 180 degrees over half the time of the clip duration
                self.face.transform = CGAffineTransform(scaleX: 100.0, y: 100.0)
            }))
            
            // 360 rotation needs to be spread out over 2 rotations
            UIView.animate(withDuration: (wowSound?.duration)!/2, animations: ({
                //first one rotates 180 degrees over half the time of the clip duration
                self.face.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }))
            //then one with delay that is 1/2 the time of the OG clip, roatates 360
            UIView.animate(withDuration: (wowSound?.duration)!/2, delay: (wowSound?.duration)!/4, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                self.face.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
            }, completion: nil)
        } catch {
            print("couldn't load file :(")
        }
        print("pressed")
    }
    //declare audioplayer delegate as self in do func, this executes after audio finsihes playing
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        face.setImage(#imageLiteral(resourceName: "Owen_NBG.png"), for: .normal)
        print("finished playing")
    }
}

