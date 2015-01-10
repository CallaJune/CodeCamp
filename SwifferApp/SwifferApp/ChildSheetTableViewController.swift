//
//  ChildSheetTableViewController.swift
//  SwifferApp
//
//  Created by Rachel Schifano on 1/8/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

import Foundation

class ChildSheetTableViewController: UITableViewController {
    
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @IBAction func DonePressed(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
