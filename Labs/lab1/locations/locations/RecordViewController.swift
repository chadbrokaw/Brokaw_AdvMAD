//
//  RecordViewController.swift
//  locations
//
//  Created by Chad Brokaw on 2/5/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//  Credit to the class notes for help
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    let noteAudioSession = AVAudioSession.sharedInstance()
    var noteAudioPlayer: AVAudioPlayer?
    var noteAudioRecorder: AVAudioRecorder?

    let filename = "notes.m4a"
    
    
    @IBOutlet weak var playOutlet: UIButton!
    @IBOutlet weak var recordOutlet: UIButton!
    @IBOutlet weak var stopOutlet: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilePath = docDir.appendingPathComponent(filename)
        
        do {
            try noteAudioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .init(rawValue: 1))
        } catch {
            print(error)
        }
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 1200,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            noteAudioRecorder = try AVAudioRecorder(url: audioFilePath, settings: settings)
            noteAudioRecorder?.prepareToRecord()
            print("Note recorder ready")
        } catch {
            print(error)
        }
    }
    
    @IBAction func playAction(_ sender: Any) {
        if noteAudioRecorder?.isRecording == false {
            stopOutlet.isEnabled = true
            recordOutlet.isEnabled = false
            
            do {
                try noteAudioPlayer = AVAudioPlayer(contentsOf: (noteAudioRecorder?.url)!)
                try noteAudioSession.setCategory(AVAudioSession.Category.playback)
                noteAudioPlayer!.delegate = self
                noteAudioPlayer!.prepareToPlay()
                noteAudioPlayer!.play()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func recordAction(_ sender: Any) {
        if let recorder = noteAudioRecorder {
            if recorder.isRecording == false {
                playOutlet.isEnabled = false
                stopOutlet.isEnabled = true
                
                recorder.delegate = self
                recorder.record()
            }
        }
        else {
            print("No Audio Recorder found")
        }
    }
    
    @IBAction func stopAction(_ sender: Any) {
        stopOutlet.isEnabled = false
        playOutlet.isEnabled = true
        recordOutlet.isEnabled = true
        
        if noteAudioRecorder?.isRecording == true {
            noteAudioRecorder?.stop()
        }
        else {
            noteAudioPlayer?.stop()
            
            do {
                try noteAudioSession.setCategory(AVAudioSession.Category.playAndRecord)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }

    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordOutlet.isEnabled = true
        stopOutlet.isEnabled = false
        
        do {
            try noteAudioSession.setCategory(AVAudioSession.Category.playAndRecord)
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
