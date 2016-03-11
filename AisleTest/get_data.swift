//
//  get_data.swift
//  AisleTest
//
//  Created by jonathan tang on 3/11/16.
//  Copyright © 2016 Jonathan Tang. All rights reserved.
//

import Foundation
@objc protocol get_data_delegate
{
    
    func download_complete(data: NSString)
    
    optional func error()
    
}