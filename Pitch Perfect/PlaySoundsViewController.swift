//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Parveen Yadav on 3/22/15.
//  Copyright (c) 2015 Parveen Yadav. All rights reserved.
//

import UIKit
import AVFoundation

/**
*  Class for playback effects
*/
class PlaySoundsViewController: UIViewController {
    
    /// <#Description#>
    var audioPlayer:AVAudioPlayer!
    /// <#Description#>
    var receivedAudio:RecordedAudio!
    /// <#Description#>
    var audioEngine:AVAudioEngine!
    //// <#Description#>
    var audioFile:AVAudioFile!
    
    /**
    <#Description#>
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
    }

    /**
    <#Description#>
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    <#Description#>
    
    :param: sender <#sender description#>
    */
    @IBAction func playSlowAudio(sender: UIButton) {
       
        println("play Slow Audio")

        setAudioSpeedRate(0.5)

        audioPlayer.play()
    }

    /**
    <#Description#>
    
    :param: sender <#sender description#>
    */
    @IBAction func playFastAudio(sender: UIButton) {
        
        println("play fast Audio")
        
        setAudioSpeedRate(1.5)

        audioPlayer.play()

    }
    
    /**
    <#Description#>
    
    :param: sender <#sender description#>
    */
    @IBAction func playChipMunkAudio(sender: UIButton) {

        println("play chip munk Audio")

        //Play audio at higher pitch.
        var highPitchEffect = AVAudioUnitTimePitch()
        highPitchEffect.pitch = 1000
        playAudioWithEffect(highPitchEffect)
    }
    
    
    
    /**
    <#Description#>
    
    :param: rate <#rate description#>
    */
    func setAudioSpeedRate(rate: Float){
        
        println("setting audio spped rate")

        stopAudioPlayerAndEngine()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
    }
    
    /**
    <#Description#>
    */
    func stopAudioPlayerAndEngine(){
        
        println("stop audio player and engine")

        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    //Combined function for Pitch, Reverb and Delay effects
    /**
    <#Description#>
    
    :param: effect <#effect description#>
    */
    func playAudioWithEffect(effect: NSObject){
        stopAudioPlayerAndEngine()
        
        //Play audio with effect applied.
        //Initialize AVPlayerNode and get other nodes as 'effect' from @IBActions.
        //Connect player node through 'effect' to audio engine output node, start audio engine and play file.
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(effect as AVAudioNode)
        
        audioEngine.connect(audioPlayerNode, to: effect as AVAudioNode, format: nil)
        audioEngine.connect(effect as AVAudioNode, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }
    
    /**
    <#Description#>
    
    :param: sender <#sender description#>
    */
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        
        println("play Darthvader Audio")

        //Play audio at lower pitch.
        var lowPitchEffect = AVAudioUnitTimePitch()
        lowPitchEffect.pitch = -1000
        playAudioWithEffect(lowPitchEffect)

    }
    
    /**
    <#Description#>
    
    :param: sender <#sender description#>
    */
    @IBAction func playEchoAudio(sender: UIButton) {
        
        println("play Echo Audio")

        //Play audio with delay effect.
        var delayEffect = AVAudioUnitDelay()
        delayEffect.delayTime = 0.7
        playAudioWithEffect(delayEffect)
    }
    
    /**
    <#Description#>
    
    :param: sender <#sender description#>
    */
    @IBAction func playReverbAudio(sender: UIButton) {
        
        println("play Revert Audio")

        var reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(.LargeRoom2)
        reverbEffect.wetDryMix = 70
        playAudioWithEffect(reverbEffect)
    }
}
