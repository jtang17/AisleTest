//
//  ProductsViewController.swift
//  AisleTest
//
//  Created by jonathan tang on 3/17/16.
//  Copyright © 2016 Jonathan Tang. All rights reserved.
//

import UIKit
import Foundation

class ProductsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView?
    var products: [[String: AnyObject]]?
    var listTitle: String?
    var booksArray = [String]()
    var authorsArray = [NSArray]()
    var imageUrlArray = [String]()
    var chosenCellIndex: Int?
    var imageSend = UIImage()
    
    //data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return booksArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath) as UITableViewCell
        
        if imageUrlArray[indexPath.row] != "none" {
            
            if let url = NSURL(string:imageUrlArray[indexPath.row]) {
                if let data = NSData(contentsOfURL:url) {
                    cell.imageView!.image = UIImage(data: data)
                }
            }
        }
        
        cell.textLabel!.font = UIFont(name:"Arial", size:12)
        cell.textLabel!.text = "\"\(booksArray[indexPath.row])\", by \(authorsArray[indexPath.row][0])"
        cell.layer.borderWidth = 0.7
        cell.layer.borderColor = UIColor.blackColor().CGColor
        
        return cell
    }
    
    
    //delegate method
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        chosenCellIndex = indexPath.row

        performSegueWithIdentifier("3to4", sender: self)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = listTitle
        
        //print(products)
        for books in products! {
            let bookTitle = books["name"] as! String
            booksArray.append(bookTitle)
        }
        for authors in products! {
            let author = authors["authors"] as! NSArray
            authorsArray.append(author)
        }
        for imageUrls in products! {
            if let imageUrl = imageUrls["imageUrl"] as? String {
                imageUrlArray.append(imageUrl)
            }
            else {
                imageUrlArray.append("none")
            }
        }
        
        tableView = UITableView(frame: CGRectMake(0,0,view.frame.size.width,view.frame.size.height), style: .Plain)
        
        
        if let theTableView = tableView {
            
            theTableView.registerClass(UITableViewCell.classForCoder(),
                forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = self
            theTableView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            view.addSubview(theTableView)
        }
        tableView!.delegate = self


        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let id = segue.identifier
        if id == "3to4" {
            
            let detailsViewController:DetailsViewController = segue.destinationViewController as! DetailsViewController
            detailsViewController.imageUrl = imageUrlArray[chosenCellIndex!] as String
            detailsViewController.bookTitle = booksArray[chosenCellIndex!] as String
            
        }
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
