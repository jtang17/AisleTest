//
//  ProductsViewController.swift
//  AisleTest
//
//  Created by jonathan tang on 3/17/16.
//  Copyright © 2016 Jonathan Tang. All rights reserved.
//

import UIKit
import Foundation

class ProductsViewController: UIViewController {
    @IBOutlet var list: UILabel!
    
    var products: [[String: AnyObject]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(products)
        

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
