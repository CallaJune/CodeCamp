//
//  ComposeViewController.swift
//  SwifferApp
//
//  Created by Training on 29/06/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var sweetTextView: UITextView! = UITextView()
    @IBOutlet var charRemainingLabel: UILabel! = UILabel()

    var selectedType = String()
    
    @IBOutlet var postTypePicker: PostTypePicker!
    let pickerData = ["Health","Current Events","Milestone","Social","Letter"]
   
    @IBOutlet var pickerLabel: UILabel!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
       // postTypePicker.dataSource = self
        postTypePicker.delegate = self


        sweetTextView.layer.borderColor = UIColor.blackColor().CGColor
        sweetTextView.layer.borderWidth = 0.5
        sweetTextView.layer.cornerRadius = 5
        sweetTextView.delegate = self
        
        sweetTextView.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendSweet(sender: AnyObject) {
        
        var sweet:PFObject = PFObject(className: "Sweets")
        sweet["content"] = sweetTextView.text
        sweet["sweeter"] = PFUser.currentUser()
        sweet["PostType"] = selectedType
        
        sweet.saveInBackground()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }

    
    func textView(textView: UITextView!,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String!) -> Bool{
    
            var newLength:Int = (textView.text as NSString).length + (text as NSString).length - range.length
            var remainingChar:Int = 500 - newLength
            
            charRemainingLabel.text = "\(remainingChar)"
            
            return (newLength > 500) ? false : true
    }
    
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerLabel.text = pickerData[row]
        selectedType=pickerData[row]
       

    }
    
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
