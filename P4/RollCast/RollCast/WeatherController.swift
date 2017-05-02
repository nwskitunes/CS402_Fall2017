//
//  WeatherController.swift
//  RollCast
//
//  Created by Wade Morris on 11/29/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//

import UIKit

class WeatherController: UIViewController{
    
    
    
    @IBOutlet weak var weatherWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowDataURL = URL(string: "http://mobile.weather.gov/index.php?lat=45.6319&lon=-112.6845&unit=0&lg=english")
        
        let flowDataURLRequest = URLRequest(url: flowDataURL!)
        
        weatherWebView.loadRequest(flowDataURLRequest)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
