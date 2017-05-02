//
//  FlowDataController.swift
//  RollCast
//
//  Created by Wade Morris on 11/29/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//

import UIKit

class FlowDataController: UIViewController{
    
    
    @IBOutlet weak var flowDataWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowDataURL = URL(string: "http://waterdata.usgs.gov/nwisweb/graph?agency_cd=USGS&site_no=06025500&parm_cd=00060&period=7")
        
        let flowDataURLRequest = URLRequest(url: flowDataURL!)
        
        flowDataWebView.loadRequest(flowDataURLRequest)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
