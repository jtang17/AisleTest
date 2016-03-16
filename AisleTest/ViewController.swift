//
//  ViewController.swift
//  AisleTest
//
//  Created by jonathan tang on 3/11/16.
//  Copyright © 2016 Jonathan Tang. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, NSURLSessionDelegate {
    
    //textfields automatically filled in with correct string for now
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func loginButton(sender: UIButton) {
      connectToApi()
    }
    //data received?

    //allow self signing for authentication
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust{
            let credential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
            completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential,credential)
        } else {
            alert()
        }
    }
    
    func alert() {
        
        let alert = UIAlertController(title: "Incorrect Login Information", message: "Please Re-enter Login Information", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }


    func connectToApi() {
        
        //text input to encoded string
        let PasswordString = txtUserName.text! + ":" + txtPassword.text!
        print(PasswordString)
        let PasswordData = PasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = PasswordData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        let urlPath: String = "https://apistage2.aisleconnect.us/ac.api/rest/v2.0/checklist/"
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
                var json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                //print(json)

            
                self.performSegueWithIdentifier("Login", sender: json)
            } catch {
                print("JSON to data error") // not able to convert data from JSON
                return
            }
            
            
        })
        task.resume()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let id = segue.identifier
        if id == "Login" {
            let listsViewController:ListsViewController = segue.destinationViewController as! ListsViewController
            listsViewController.contentsDict = sender as? NSDictionary
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

