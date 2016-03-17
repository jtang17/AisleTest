//
//  ListsViewController.swift
//  AisleTest
//
//  Created by jonathan tang on 3/11/16.
//  Copyright © 2016 Jonathan Tang. All rights reserved.
//

import UIKit
import Foundation

class ListsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView?
    var contentsDict:NSDictionary?
    var namesArray = [String]()
    var productsArray = [NSArray]()
    var chosenCellIndex: Int?
    
    //data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = "\(namesArray[indexPath.row]) : \(productsArray[indexPath.row].count) items"
        cell.layer.borderWidth = 0.7
        cell.layer.borderColor = UIColor.blackColor().CGColor
        
        return cell
    }
    
    //delegate method
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        chosenCellIndex = indexPath.row
        //print(chosenCellIndex)
  
        // Start segue with index of cell clicked
        performSegueWithIdentifier("2to3", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LISTS"
        let data = contentsDict!["data"] as! [[String : AnyObject]]

        for names in data {
            
            let name = names["name"]! as! String
            //print("names: \(name)")
            self.namesArray.append(name)
        }
        for products in data {
            
            let productList = products["products"] as! NSArray
            self.productsArray.append(productList)


        }

        //print(productsArray[0])
        //print(productsArray[2].count)
        // Do any additional setup after loading the view.
        
        tableView = UITableView(frame: CGRectMake(0,64,view.frame.size.width,view.frame.size.height), style: .Plain)
        
        
        if let theTableView = tableView {
            
            theTableView.registerClass(UITableViewCell.classForCoder(),
                forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = self
            theTableView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            view.addSubview(theTableView)
        }
        tableView!.delegate = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let id = segue.identifier
        if id == "2to3" {
            
            let productsViewController:ProductsViewController = segue.destinationViewController as! ProductsViewController
            productsViewController.products = productsArray[chosenCellIndex!] as? [[String: AnyObject]]
            productsViewController.listTitle = namesArray[chosenCellIndex!] as String

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
