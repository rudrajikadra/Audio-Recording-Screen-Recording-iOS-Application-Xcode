//
//  passData.swift
//  Recorder
//
//  Created by Rudra Jikadra on 03/01/18.
//  Copyright © 2018 Rudra Jikadra. All rights reserved.
//

import UIKit

class passData: UIViewController {

    
    @IBOutlet var videoLink: UITextField!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destView: ViewController2 = segue.destination as! ViewController2
        destView.linkVideo = videoLink.text!
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
