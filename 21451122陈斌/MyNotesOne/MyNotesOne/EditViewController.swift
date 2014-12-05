//
//  EditViewController.swift
//  MyNotesOne
//
//  Created by lqynydyxf on 14/11/26.
//  Copyright (c) 2014年 lqynydyxf. All rights reserved.
//

import UIKit
import CoreData
class EditViewController: UIViewController {

    @IBOutlet weak var editTitle: UITextField!
    
    @IBOutlet weak var editContent: UITextView!
    
    var data:NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editContent.layer.borderColor = UIColor.grayColor().CGColor
        editContent.layer.borderWidth = 1.0
        editContent.layer.cornerRadius = 5.0
        editTitle.text = data.valueForKey("title") as String
        editContent.text = data.valueForKey("content") as String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        
        data.setValue(editTitle.text, forKey: "title")
        data.setValue(editContent.text, forKey: "content")
        data.setValue(NSDate(), forKey: "time")
        data.managedObjectContext?.save(nil)
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
