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
        
        //var myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
        //childPicture.layer.borderColor = myColor.CGColor
        childPicture.layer.borderWidth = 4
        
        // Set image corner radius
        childPicture.layer.cornerRadius = 2.0

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    @IBAction func DonePressed(sender: AnyObject) {
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}
