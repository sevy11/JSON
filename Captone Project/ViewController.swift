//
//  ViewController.swift
//  Captone Project
//
//  Created by Michael Sevy on 11/9/14.
//  Copyright (c) 2014 Michael Sevy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET( "http://intutvp.herokuapp.com/intutv/api/v1.0/search/twitter/foofighters",
            parameters: nil,
            success: {  (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                println("JSON: " + responseObject.description)
                
                if let dataArray = responseObject.valueForKey("data") as? [AnyObject]       {
                    self.scrollView.contentSize = CGSizeMake(320, CGFloat(320*dataArray.count))
                    for var i = 0; i < dataArray.count; i++     {
                        let dataObject: AnyObject = dataArray[i]
                        if let imageURLString = dataObject.valueForKeyPath("images.standard_resolution.url") as? String {
                            println("image " + String(i) + " URL is " + imageURLString)
                            
                            let imageData =  NSData(contentsOfURL: NSURL(string: imageURLString)!)
                            let imageView = UIImageView(image: UIImage(data: imageData!))
                            imageView.frame = CGRectMake(0, CGFloat(320*i), 320, 320)
                            self.scrollView.addSubview(imageView)
                        }
                    }
                }
                
            },
            
            failure:    {   (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
//Instagram JSON: https://api.instagram.com/v1/tags/"timberlake"/media/recent?client_id=952d6ff443ce448d90d3bf12d819b88b

//Heroku JSON: http://intutvp.herokuapp.com/intutv/api/v1.0/search/twitter/foofighters

//pulls JSON and inserts it in a label.text box knowm here as "username":
//if let myName = responseObject.valueForKey("name") as? String {
//self.username.text = myName;
