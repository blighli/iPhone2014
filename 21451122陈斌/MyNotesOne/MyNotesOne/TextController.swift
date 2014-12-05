//
//  TextController.swift
//  MyNotesOne
//
//  Created by lqynydyxf on 14/11/24.
//  Copyright (c) 2014年 lqynydyxf. All rights reserved.
//

import UIKit
import CoreData

class TextController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var content_title: UITextField!
    
    @IBOutlet weak var content: UITextView!
    
    @IBOutlet weak var table_view: UITableView!
    var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        content.layer.borderColor = UIColor.grayColor().CGColor
        content.layer.borderWidth = 1.0
        content.layer.cornerRadius = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        var cursor:AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Notes", inManagedObjectContext: context!)
        cursor.setValue(content_title.text, forKey: "title")
        cursor.setValue(content.text, forKey: "content")
        cursor.setValue(NSDate(), forKey: "time")
        context?.save(nil)
        UIAlertView(title: "提示", message: "保存成功", delegate: nil, cancelButtonTitle: "确定").show()
    }
}
