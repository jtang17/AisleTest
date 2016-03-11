//
//  ViewController.swift
//  AisleTest
//
//  Created by jonathan tang on 3/11/16.
//  Copyright © 2016 Jonathan Tang. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController{
    
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
            completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential,credential);
        }
    }
    
    func connectToApi() {
        
        //text input to encoded string
        let PasswordString = "\(txtUserName.text):\(txtPassword.text)"
        let PasswordData = PasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = PasswordData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        let urlPath: String = "http://apistage2.aisleconnect.us"
        let url: NSURL = NSURL(string: urlPath)!
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let request = NSMutableURLRequest(URL: url)
        request.setValue("Basic \(base64EncodedCredential)", forHTTPHeaderField: "Authorization")
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            // JSON response, data, error, here
            guard let responseData = data else {
                print("No data") //print if no response
                return
            }
            guard error == nil else {
                print("GET error") //GET request error
                print(error)
                return
            }
            let contents: NSDictionary //!!!is server data dictionary?!!!
            do {
                contents = try NSJSONSerialization.JSONObjectWithData(responseData,
                    options: []) as! NSDictionary
            } catch  {
                print("JSON to data error") // not able to convert data from JSON
                return
            }
            print (contents.description) //print JSON data if it's retrieved
            
        })
        task.resume()
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

