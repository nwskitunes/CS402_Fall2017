//
//  ReportController.swift
//  RollCast
//
//  Created by Wade Morris on 11/29/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//

import UIKit

class ReportController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "run_results", ofType: "json")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
