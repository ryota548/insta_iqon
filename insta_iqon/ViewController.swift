//
//  ViewController.swift
//  insta_iqon
//
//  Created by ryota-ko on 2015/07/23.
//  Copyright (c) 2015年 ryota-ko. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var itemCount = 0
    var photos :[String] = []
    @IBOutlet var collectionView :UICollectionView!
    
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
        
        let json = JSON(data: data)
        println(json)
        itemCount = json["data"].count
        
        for i in 0..<itemCount{
            var imageUrl = json["data"][i]["images"]["low_resolution"]["url"].string
            photos.append(imageUrl!)
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            self.collectionView.reloadData()
        })
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.photos.count
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        let cell :CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        
        var imageString : String = photos[indexPath.item] as String
        
        cell.imageView.image = nil
        
        var q_global: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        var q_main: dispatch_queue_t  = dispatch_get_main_queue();
        
        dispatch_async(q_global, {
            var imageURL: NSURL = NSURL(string: imageString)!
            
            var imageData: NSData = NSData(contentsOfURL: imageURL)!
            
            var image = UIImage(data: imageData)
            
            dispatch_async(q_main, {
                cell.imageView.image = image
                cell.layoutSubviews()
            })
        })
        return cell
    }
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize
    {
        var itemSize : CGSize
        let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
        itemSize = CGSizeMake((myBoundSize.width)/3, (myBoundSize.width)/3)
        return itemSize
    }
    /*
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        println("下まできたよー！")
        var footer : MySupplementaryView? = nil
        return footer!
    }
    */
}

