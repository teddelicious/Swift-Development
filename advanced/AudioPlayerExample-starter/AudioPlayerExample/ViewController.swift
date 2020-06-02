//
//  ViewController.swift
//  AudioPlayerExample
//
//  Created by parrot on 2020-05-04.
//  Copyright © 2020 peacock. All rights reserved.
//


// -------------
// Exercises:
// -------------
// 1. Update app so the current time is shown in user interface
//      - Current time must be shown in this format:  HH:MM:SS
// 2. Add a Progress bar.
//      - Progress bar updates to show how much time has passed
// 3. Control the audio using a slider
//      - Add a slider.
//      - Control the audio playback by moving the slider
// 4. Add a track list:
//      - Users can play more than 1 song
//      - Add a NEXT and PREVIOUS button to the audio controls
//      - Pressing NEXT jumps to next song
//      - Pressing PREV jumps to previous song
// -------------
// Resuability:
// -------------
// 1. Create a playMusic() and stopMusic() function
//      - These functions should perform any tasks related to playing and stopping music (enabling buttons, stopping timers, etc)
//      - Call these functions from inside play, pause, and stop click handlers


import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    // Outlets
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!

    // MARK: Variables
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    // @TODO: Use a timer for tracking how many minutes have passed in the song
    var timer: Timer = Timer()
    
    // MARK: IOS Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAudio()
        setPlayControls(isPlaying: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: Helper Functions
    // @TODO: Create a function to load an audio file
    func loadAudio() {
        let path = Bundle.main.url(forResource: "Moonlit-Secrets", withExtension: "mp3")
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: path!)
            self.audioPlayer.delegate = self
        } catch {
            print("cannot open file")
            print(error)
        }
    }
    
    func setPlayControls(isPlaying: Bool) {
        self.playButton.isEnabled = !isPlaying
        self.pauseButton.isEnabled = isPlaying
        self.stopButton.isEnabled = isPlaying
    }
    
    
    // MARK: Actions
    
    // Basic controls for audio
    @IBAction func playButtonPressed(_ sender: Any) {
        print("Play button pressed")
        self.audioPlayer.play()
        setPlayControls(isPlaying: true)
        
        //start timer
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            (timer) in
            print("Current time: \(self.audioPlayer.currentTime)")
        })
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        print("Pause button pressed")
        self.audioPlayer.pause()
        setPlayControls(isPlaying: false)
        self.timer.invalidate()
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        print("Stop button pressed")
        self.audioPlayer.currentTime = 0
        self.audioPlayer.stop()
        setPlayControls(isPlaying: false)
        self.timer.invalidate()
    }
    
    // MARK: Delegates
    // @TODO: How to detect when the audio is finished?
    
    
    // MARK: Timer Functions
    // @TODO: Put any timer functions here

}

