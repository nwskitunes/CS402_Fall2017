//
//  ReportController.swift
//  RollCast
//
//  Created by Wade Morris on 11/29/16.
//  Copyright © 2016 Wade Morris. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReportController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    public var riverChoice:String = ""
    public var stateName:String = ""
    var reportStringTest: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func tableView(_ tableView: UITableView, numberOfColumnsInSection section: Int) -> Int
    {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
//        let viewControl: ViewController = ViewController()
//        var reportString:String = viewControl.riverReportString as String
        print("HMMM\n" + reportStringTest!)
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        cell.textLabel?.numberOfLines=0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        if(reportStringTest == ""){
            reportStringTest = "No Report at this time"
        }
        
        cell.textLabel?.text = reportStringTest
        
        return (cell)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
