//
//  ChildSheetTableViewController.swift
//  SwifferApp
//
//  Created by Rachel Schifano on 1/8/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

import Foundation

class ChildSheetTableViewController: UITableViewController {
    
    @IBOutlet var childPicture: UIImageView!=UIImageView()
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
        childPicture.clipsToBounds=true
        
        // Create a white border with defined width
      ////  let myBlackColor = CGColorCreateCopy(color: blackColor!)
       // childPicture.layer.borderColor = myBlackColor
        childPicture.layer.borderWidth = 1.5
        
        // Set image corner radius
        childPicture.layer.cornerRadius = 5.0
        
        // Custom initialization
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    @IBAction func DonePressed(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}
