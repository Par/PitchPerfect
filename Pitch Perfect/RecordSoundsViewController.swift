//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Parveen Yadav on 3/11/15.
//  Copyright (c) 2015 Parveen Yadav. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordButton.enabled = false
        stopButton.hidden = false

        recordingInProgress.hidden = false
        println("in recordAudio")
    }

    @IBAction func stopRecording(sender: UIButton) {

        recordingInProgress.hidden = true

    }
}

