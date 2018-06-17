//
//  LetsTry.swift
//  Recorder
//
//  Created by Rudra Jikadra on 04/01/18.
//  Copyright © 2018 Rudra Jikadra. All rights reserved.
//

import UIKit
import ReplayKit

class LetsTry: UIView {
    
    
    
    var recording: Bool = false
    
    //for screen recording
    let recorder = RPScreenRecorder.shared()
    
    @IBAction func record(_ sender: Any) {
        
        if recording {
            recording = false
            recorder.isMicrophoneEnabled = false
            recorder.stopRecording(handler: { (previewVC, error) in
                if let previewVC = previewVC {
                    
                }
                
                if let error = error {
                    print(error)
                }
            })
            
        } else {
            recording = true
            recorder.isMicrophoneEnabled = true
            recorder.startRecording(handler: { (error) in
                if let error = error {
                    print(error)
                }
            })
        }
        
    }
    
}

extension ViewController2: RPPreviewViewControllerDelegate {
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true, completion: nil)
    }
}
