//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Parveen Yadav on 3/11/15.
//  Copyright (c) 2015 Parveen Yadav. All rights reserved.
//

import UIKit
import AVFoundation

/**
*  Class for recording voice
*/
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    /// <#Description#>
    @IBOutlet weak var recordingInProgress: UILabel!
    
    /// <#Description#>
    @IBOutlet weak var stopButton: UIButton!
    
    /// <#Description#>
    @IBOutlet weak var recordButton: UIButton!
    /// <#Description#>
    @IBOutlet weak var pauseButton: UIButton!
    
    /// <#Description#>
    @IBOutlet weak var resumeButton: UIButton!
    
    /// Description
    var audioRecorder:AVAudioRecorder!
    /// <#Description#>
    var recordedAudio:RecordedAudio!
    

    /**
    <#Description#>
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

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
    
    :param: animated <#animated description#>
    */
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        pauseButton.hidden = true
        resumeButton.hidden = true
        recordButton.enabled = true
        recordingInProgress.text = "Tap to Record"
    }

    /**
    <#Description#>
    
    :param: sender <#sender description#>
    */
    @IBAction func recordAudio(sender: UIButton) {
        recordButton.enabled = false
        stopButton.hidden = false
        pauseButton.hidden = false
        resumeButton.hidden = false
        
        
        recordingInProgress.text = "recording in progress..."

        
        println("recording in progress...")
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    /**
    <#Description#>
    
    :param: recorder <#recorder description#>
    :param: flag     <#flag description#>
    */
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    
        println("recorder finished recording.")

        // Fix for low volume on device. Setting to playback fixes the issue.
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
        
        if(flag)
        {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
        
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else
        {
            println("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    /**
    <#Description#>
    
    :param: segue  <#segue description#>
    :param: sender <#sender description#>
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording")
        {
            println("moving to Play effect screen")

            let playSoundVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundVC.receivedAudio = data
        }
        
    }

    /**
    <#Description#>
    
    :param: sender <#sender description#>
    */
    @IBAction func stopRecording(sender: UIButton) {
        
        println("stopped recording")

        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)

    }
    
    /**
    <#Description#>
    
    :param: sender <#sender description#>
    */
    @IBAction func pauseRecording(sender: UIButton) {
        
        println("recording paused")

        recordingInProgress.text = "recording paused..."

        audioRecorder.pause()
    }
    
    /**
    <#Description#>
    
    :param: sender <#sender description#>
    */
    @IBAction func resumeRecording(sender: UIButton) {
        
        println("resume recording")

        recordingInProgress.text = "recording in progress..."

        audioRecorder.record()
    }
    
    
}

