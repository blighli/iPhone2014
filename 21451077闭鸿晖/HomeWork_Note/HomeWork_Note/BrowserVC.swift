//
//  BrowserVC.swift
//  HomeWork4
//
//  Created by turbobhh on 11/16/14.
//  Copyright (c) 2014 org.bhh.homework. All rights reserved.
//

import UIKit
import CoreData
class BrowserVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,NSFetchedResultsControllerDelegate{
    //通过闭包初始化属性
    //结果集控制器(当数据库中对象改变时，回调controller方法更新tableview)
    lazy var fetchedResultsController:NSFetchedResultsController! = {
        var fetchRequest=NSFetchRequest()
         var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        
        fetchRequest.entity = NSEntityDescription.entityForName("Note", inManagedObjectContext:context)
        
        var titleSortDescriptor=NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors=[titleSortDescriptor]

        var fetchedResultsController=NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)

        fetchedResultsController.delegate=self
        return fetchedResultsController
        
    }()
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       fetchedResultsController.performFetch(nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView DataSource(根据NSFetchedResultsController设置tableview的显示)
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (fetchedResultsController.sections?.first?.numberOfObjects)!
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var myCell = tableView.dequeueReusableCellWithIdentifier("cellID") as MyCell
        var note=fetchedResultsController.objectAtIndexPath(indexPath) as Note
        myCell.titleLabel.text=note.title
        return myCell
    }
    
    //MARK: - TableView Delegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle==UITableViewCellEditingStyle.Delete{
            var context=fetchedResultsController.managedObjectContext
            context.deleteObject(fetchedResultsController.objectAtIndexPath(indexPath) as Note)
            context.save(nil)
            
        }
    }
    

    //MARK: - NSFetchedResultsController Delegate
    //开始执行一个更新tableview的序列
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
       tableView.beginUpdates()
    }
    
    
    //数据改变时更新视图
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type{
        case NSFetchedResultsChangeType.Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)

            case NSFetchedResultsChangeType.Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            case NSFetchedResultsChangeType.Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            //记录的位置改变
            case NSFetchedResultsChangeType.Move:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.insertRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
 
    }
    //tableview更新完毕
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    // MARK: - SearchBar Delegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    //fetchedResultsController.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier=="EditNote" && segue.destinationViewController is AddNoteVC{
            var editNoteVC=segue.destinationViewController as AddNoteVC
            var indexPath = tableView.indexPathForCell(sender as UITableViewCell)
            editNoteVC.note=fetchedResultsController.objectAtIndexPath(indexPath!) as? Note
            editNoteVC.isNewNote=false
        }
    }


}
