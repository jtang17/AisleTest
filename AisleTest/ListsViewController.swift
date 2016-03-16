//
//  ListsViewController.swift
//  AisleTest
//
//  Created by jonathan tang on 3/11/16.
//  Copyright © 2016 Jonathan Tang. All rights reserved.
//

import UIKit

class ListsViewController: UIViewController, UITableViewDataSource {

    var tableView: UITableView?
    var contentsDict:NSDictionary?
    var namesArray = [String]()
    var productsArray = [NSArray]()
    
    var tableData = [String]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = "\(namesArray[indexPath.row]) : \(productsArray[indexPath.row].count) items"
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
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
        
        print(namesArray.count)
        print(productsArray[2].count) //test: [0]:8 [1]:8 [2]:20
        // Do any additional setup after loading the view.
        
        tableView = UITableView(frame: view.bounds, style: .Plain)
        
        if let theTableView = tableView{
            
            theTableView.registerClass(UITableViewCell.classForCoder(),
                forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = self
            theTableView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            view.addSubview(theTableView)
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
