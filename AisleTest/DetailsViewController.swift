//
//  DetailsViewController.swift
//  AisleTest
//
//  Created by jonathan tang on 3/17/16.
//  Copyright © 2016 Jonathan Tang. All rights reserved.
//

import UIKit
import Foundation

class DetailsViewController: UIViewController, NSURLSessionDelegate {
    
    var imageUrl: String?
    var bookTitle: String?
    var imageViewObject = UIImageView()
    var productDict: NSDictionary?
    var textLabel = UILabel()
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust{
            let credential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
            completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential,credential)
        }
    }
    
    func jsonData() {
        
        let PasswordString = "paul.lin@lineagenetworks.com:welcome1"
        print(PasswordString)
        let PasswordData = PasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = PasswordData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        let urlPath: String = "https://apistage2.aisleconnect.us/ac.api/rest/v2.0/product/"
        let url: NSURL = NSURL(string: urlPath)!
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config, delegate: self, delegateQueue:NSOperationQueue.mainQueue())
        
        let request = NSMutableURLRequest(URL: url)
        request.setValue("Basic \(base64EncodedCredential)", forHTTPHeaderField: "Authorization")
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            // JSON response, data, error, here]
            guard let responseData = data else {
                print("No data") //print if no response
                return
            }
            guard error == nil else {
                print("GET error") //GET request error
                print(error)
                return
            }
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                //print(json)
                //self.update_text(json)

                
            } catch {
                print("JSON to data error") // not able to convert data from JSON
                return
            }
            
            
        })
        
        task.resume()
        
        
    }
    
    func update_text(json:NSDictionary) {
        dispatch_async(dispatch_get_main_queue(), {
            //self.textLabel.text = "Description from JSON"
            return
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = bookTitle
        
        jsonData()
        print(productDict)
        
        textLabel = UILabel(frame: CGRectMake(0 , 285, 250, 250))
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        textLabel.font = UIFont(name: "Arial", size: 14)
        textLabel.text = "hi there can you see this text \n hello hello \n description \n json"
        self.view.addSubview(textLabel)
        
        imageViewObject = UIImageView(frame:CGRectMake(0, 75, 200, 250))
        if imageUrl != "none" {
            
            if let url = NSURL(string:imageUrl!) {
                if let imageData = NSData(contentsOfURL:url) {
                    imageViewObject.image = UIImage(data: imageData)
                }
            }
        }
        self.view.addSubview(imageViewObject)
        self.view.sendSubviewToBack(imageViewObject)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        textLabel.center.x = view.center.x
        imageViewObject.center.x = view.center.x
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
