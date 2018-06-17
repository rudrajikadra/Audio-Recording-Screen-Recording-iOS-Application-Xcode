//
//  ViewController.swift
//  Toss
//
//  Created by Rudra Jikadra on 18/12/17.
//  Copyright © 2018 Rudra Jikadra. All rights reserved.
//

import UIKit
import ReplayKit

class ViewController2: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var record: UIButton!
    @IBOutlet var videoView: UIWebView!
    
    var recording: Bool = false
    
    var linkVideo: String = ""
    var link: String = "https://www.youtube.com/embed/" //default
    var extention: String = "DQMca1PINME"
    var finalLink: String = "https://www.youtube.com/embed/DQMca1PINME"

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //for screen recording
    let recorder = RPScreenRecorder.shared()
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let pp: String = getYoutubeId(youtubeUrl: linkVideo)!
//        print("This is The Link : \(pp)")
        
        if linkVideo == "" {
            
        } else {
            extention = linkVideo.youtubeID!
        }
        
        
        print("***********************This is The Video ID : \(extention)")
        
        finalLink = "\(link)\(extention)"
        
        videoView.allowsInlineMediaPlayback = true
        videoView.scrollView.isScrollEnabled = false
        
        let width: CGFloat = self.view.frame.width
        let height: CGFloat = width * 9 / 15
        
        //the video is already muted with (&mute=1)
        videoView.loadHTMLString("<iframe id=\"vidid\" width=\"\(width - 15)\" height=\"\(height - 15)\" src=\"\(finalLink)?&playsinline=1&rel=0&controls=0&autohide=1&showinfo=0\" frameborder=\"0\" gesture=\"media\" allow=\"encrypted-media\" allowfullscreen></iframe>", baseURL: nil)
        
       
    }

    
/////        this is to get the video id from the whole url which is implemented better in the very bottom as extension
//    func getYoutubeId(youtubeUrl: String) -> String? {
//        return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
//    }
    
    @IBAction func goback(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Record the screen
    @IBAction func startRecord(_ sender: Any) {
        if recording {
            recording = false
            record.setTitle("Record", for: .normal)
            recorder.isMicrophoneEnabled = false
            recorder.stopRecording(handler: { (previewVC, error) in
                if let previewVC = previewVC {
                    previewVC.previewControllerDelegate = self
                    self.present(previewVC, animated: true, completion: nil)
                }
                
                if let error = error {
                    print(error)
                }
            })
            
        } else {
            recording = true
            record.setTitle("Stop", for: .normal)
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

extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, options: [], range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
}


