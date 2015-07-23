//
//  ViewController.swift
//  insta_iqon
//
//  Created by ryota-ko on 2015/07/23.
//  Copyright (c) 2015年 ryota-ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reload(){
        
        let URL = NSURL(string: "https://api.instagram.com/v1/tags/iqon/media/recent?client_id=e7bd46dc32a641a792565c029a0caa8e")
        let req = NSURLRequest(URL: URL!)
        let connection: NSURLConnection = NSURLConnection(request: req, delegate: self, startImmediately: false)!
        
        // NSURLConnectionを使ってアクセス
        NSURLConnection.sendAsynchronousRequest(req,queue: NSOperationQueue.mainQueue(),completionHandler: response)
        
    }
    
    func response(res: NSURLResponse!, data: NSData!, error: NSError!){
        
        // responseをjsonに変換
        var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
        println(json)
        
    }

}

