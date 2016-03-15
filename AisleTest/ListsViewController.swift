//
//  ListsViewController.swift
//  AisleTest
//
//  Created by jonathan tang on 3/11/16.
//  Copyright © 2016 Jonathan Tang. All rights reserved.
//

import UIKit

class ListsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var contentsDict:NSDictionary?
    
    var tableData = [String]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        //cell.name.text = tableName[indexPath.row]
        //cell.number.text = tableNumber[indexPath.row]
  
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(contentsDict)

    

        // Do any additional setup after loading the view.
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
