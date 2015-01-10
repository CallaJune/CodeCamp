//
//  TimelineTableViewController.swift
//  SwifferApp
//
//  Created by Training on 29/06/14.
//  Copyright (c) 2014 Training. All rights reserved.
//
import UIKit

class TimelineTableViewController: UITableViewController {

    var timelineData:NSMutableArray! = NSMutableArray()
    var health : UIImage! = UIImage(named: "health.png")
    var news : UIImage! = UIImage(named: "news.png")
    var milestones : UIImage! = UIImage(named: "milestones.png")
    var social : UIImage! = UIImage(named: "social.png")
    var letter : UIImage! = UIImage(named: "letter.png")
 
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
  
        // Custom initialization
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @IBAction func loadData(){
        timelineData.removeAllObjects()
        
        var findTimelineData:PFQuery = PFQuery(className: "Sweets")
        
        findTimelineData.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!)->Void in
            
            if error == nil{
                for object in objects{
                    let sweet:PFObject = object as PFObject
                    self.timelineData.addObject(sweet)
                }
                
                let array:NSArray = self.timelineData.reverseObjectEnumerator().allObjects
                self.timelineData = NSMutableArray(array: array)
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidAppear(animated: Bool) {
        self.loadData()
         self.tableView.reloadData()
        if PFUser.currentUser() == nil{
            var loginAlert:UIAlertController = UIAlertController(title: "Sign Up / Login", message: "Please sign up or login", preferredStyle: UIAlertControllerStyle.Alert)
            
            loginAlert.addTextFieldWithConfigurationHandler({
                    textfield in
                    textfield.placeholder = "Username"
            })
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Password"
                textfield.secureTextEntry = true
            })
            loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
                    alertAction in
                let textFields:NSArray = loginAlert.textFields as AnyObject! as NSArray
                let usernameTextfield:UITextField = textFields.objectAtIndex(0) as UITextField
                let passwordTextfield:UITextField = textFields.objectAtIndex(1) as UITextField
                
                PFUser.logInWithUsernameInBackground(usernameTextfield.text, password: passwordTextfield.text){
                    (user:PFUser!, error:NSError!)->Void in
                    if user != nil{
                        println("Login successful")
                    }else{
                        println("Login failed")
                    }
                }
            }))
            loginAlert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                let textFields:NSArray = loginAlert.textFields as AnyObject! as NSArray
                let usernameTextfield:UITextField = textFields.objectAtIndex(0) as UITextField
                let passwordTextfield:UITextField = textFields.objectAtIndex(1) as UITextField
                
                var sweeter:PFUser = PFUser()
                sweeter.username = usernameTextfield.text
                sweeter.password = passwordTextfield.text
                
                sweeter.signUpInBackgroundWithBlock{
                    (success:Bool!, error:NSError!)->Void in
                    if error == nil{
                        println("Sign Up successful")
                    }else{
                        let errorString = error.localizedDescription
                        println(errorString)
                    }
                }
            }))
            
            
            
            
            
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView(tableView,numberOfRowsInSection: 1)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return timelineData.count
    }
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell:SweetTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as SweetTableViewCell


        let sweet:PFObject = self.timelineData.objectAtIndex(indexPath.row) as PFObject
    
            cell.sweetTextView.alpha = 0
            cell.timestampLabel.alpha = 0
            cell.usernameLabel.alpha = 0
            cell.postTypeLabel.alpha = 0
            cell.sweetTextView.text = sweet.objectForKey("content") as String
            cell.postTypeLabel.text = sweet.objectForKey("PostType") as? String
    
        var dataFormatter:NSDateFormatter = NSDateFormatter()
            dataFormatter.dateFormat = "MM-dd-yyyy"
            cell.timestampLabel.text = dataFormatter.stringFromDate(sweet.createdAt)
        
        var findSweeter:PFQuery = PFUser.query()
            findSweeter.whereKey("objectId", equalTo: sweet.objectForKey("sweeter").objectId)
        
        findSweeter.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]!, error:NSError!)->Void in
            if error == nil{
                let user:PFUser = (objects as NSArray).lastObject as PFUser
                cell.usernameLabel.text = user.username
                
                UIView.animateWithDuration(0.5, animations: {
                        cell.sweetTextView.alpha = 1
                        cell.timestampLabel.alpha = 1
                        cell.usernameLabel.alpha = 1
                        cell.postTypeLabel.alpha = 1
                })
            }
        }
    
    if(cell.postTypeLabel.text == "Health"){
        cell.thisImageView.image = health
    }
    if(cell.postTypeLabel.text == "Current Events"){
        cell.thisImageView.image = news
    }
    if(cell.postTypeLabel.text == "Milestone"){
        cell.thisImageView.image = milestones
    }
    if(cell.postTypeLabel.text == "Social"){
        cell.thisImageView.image = social
    }
    if(cell.postTypeLabel.text == "Letter"){
        cell.thisImageView.image = letter
    }
    
        return cell
    }
}
