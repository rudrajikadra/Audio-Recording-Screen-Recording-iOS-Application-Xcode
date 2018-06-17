//
//  ViewController.swift
//  Recorder
//
//  Created by Rudra Jikadra on 02/01/18.
//  Copyright © 2018 Rudra Jikadra. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    
    var numberOfRercords: Int = 0
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if let number: Int = UserDefaults.standard.object(forKey: "MyNumber") as? Int
        {
            numberOfRercords = number
        }
        
        //setting session
        recordingSession = AVAudioSession.sharedInstance()
        
        //ask for permission
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission {
                //accepted
            }
        }
        
    }
    
    
    
    @IBAction func record(_ sender: Any) {
        
        //check if we have active recorder
        if audioRecorder == nil {
            numberOfRercords += 1
            let fileName = getDirectory().appendingPathComponent("\(numberOfRercords).m4a")
            
            let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 1200, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            
            //start Audio Recording
            do {
                audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
                recordButton.setTitle("Stop Recording", for: .normal)
            } catch {
                displayAlert(title: "Oops!", message: "Recording Not Possible")
            }
        } else {
            audioRecorder.stop()
            UserDefaults.standard.set(numberOfRercords, forKey: "MyNumber")
            audioRecorder = nil
            
            tableView.reloadData()
            
            recordButton.setTitle("Record!", for: .normal)
        }
    }
    
    func getDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    func displayAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func share(_ sender: Any) {
        let activity = UIActivityViewController(activityItems: [audioPlayer], applicationActivities: nil)
        activity.popoverPresentationController?.sourceView = self.view
        
        self.present(activity, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRercords
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: path)
            audioPlayer.play()
        } catch {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

