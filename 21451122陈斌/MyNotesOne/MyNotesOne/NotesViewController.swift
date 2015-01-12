//
//  NotesViewController.swift
//  MyNotesOne
//
//  Created by lqynydyxf on 14/11/24.
//  Copyright (c) 2014年 lqynydyxf. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var titles: UITableView!
    var dataArray:Array<AnyObject>! = []
    var context:NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titles.delegate = self
        titles.dataSource = self
        refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cellfornote") as UITableViewCell
        cell.textLabel.text = dataArray[indexPath.row].valueForKey("title") as? String
        return cell
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if (editingStyle == .Delete) {
            context.deleteObject(dataArray[indexPath.row] as NSManagedObject)
            context.save(nil)
            refresh()
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        var data = dataArray[indexPath.row] as NSManagedObject
        var vc = storyboard?.instantiateViewControllerWithIdentifier("editessay") as EditViewController
        vc.data = data
        presentViewController(vc, animated: true, completion: nil)
    }
    override func viewWillAppear(animated: Bool) {
        refresh()
    }
    func refresh(){
        var f = NSFetchRequest(entityName: "Notes")
        dataArray = context.executeFetchRequest(f, error: nil)
        titles.reloadData()
    }
}
