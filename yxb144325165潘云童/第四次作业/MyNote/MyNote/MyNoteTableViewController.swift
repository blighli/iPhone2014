//
//  MyNoteTableViewController.swift
//  MyNote
//
//  Created by Joker on 14/11/21.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

import UIKit
import CoreData

class MyNoteTableViewController: UITableViewController,NSFetchedResultsControllerDelegate{
    
    @IBOutlet var noteTableView: UITableView!
    
    var context:NSManagedObjectContext!
    var _fetchedResultsController: NSFetchedResultsController?
    var mynotes = [AnyObject]()
    
    let TagTime = 1
    let TagText = 2
    let TagImage = 3
    
    var fetchedResultsController: NSFetchedResultsController {
        // return if already initialized
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        let managedObjectContext = self.context!
        
        /* `NSFetchRequest` config
        fetch all `Item`s
        order them alphabetically by name
        at least one sort order _is_ required */
        let entity = NSEntityDescription.entityForName("Note", inManagedObjectContext: managedObjectContext)
        let sort = NSSortDescriptor(key: "time", ascending: true)
        let req = NSFetchRequest()
        req.entity = entity
        req.sortDescriptors = [sort]
        
        /* NSFetchedResultsController initialization
        a `nil` `sectionNameKeyPath` generates a single section */
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: req, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        self._fetchedResultsController = aFetchedResultsController
        
        // perform initial model fetch
        var e: NSError?
        if !self._fetchedResultsController!.performFetch(&e) {
            println("fetch error: \(e!.localizedDescription)")
            abort();
        }
        
        return self._fetchedResultsController!
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return info.numberOfObjects
    }

    // 创建并设置UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("note", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    // 向NSFetchedResultsController请求数据来设置一个UITableViewCell
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            let note = self.fetchedResultsController.objectAtIndexPath(indexPath) as Note
            println(note.time)
            println(note.text)
            println(note.image)
            (cell.viewWithTag(TagTime) as UILabel).text = note.time
            (cell.viewWithTag(TagText) as UILabel).text = note.text
            if(note.image != "") {
                let image = UIImage(contentsOfFile: note.image)
                (cell.viewWithTag(TagImage) as UIImageView).image = image
            } else {
                println("kongkongkong")
            }
    }
    
    /* called first
    begins update to `UITableView`
    ensures all updates are animated simultaneously */
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.noteTableView.beginUpdates()
    }
    
    /* called:
    - when a new model is created
    - when an existing model is updated
    - when an existing model is deleted */
    func controller(controller: NSFetchedResultsController,
        didChangeObject object: AnyObject,
        atIndexPath indexPath: NSIndexPath,
        forChangeType type: NSFetchedResultsChangeType,
        newIndexPath: NSIndexPath) {
            switch type {
            case .Insert:
                self.noteTableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            case .Delete:
                self.noteTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            default:
                return
            }
    }
    
    /* called last
    tells `UITableView` updates are complete */
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.noteTableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        
        let detail = self.navigationController?.viewControllers[1] as NodeDetailViewController
        
        detail.time = (cell.viewWithTag(TagTime) as UILabel).text!
        detail.text = (cell.viewWithTag(TagText) as UILabel).text!
        detail.image = (cell.viewWithTag(TagImage) as UIImageView).image
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let note = self.fetchedResultsController.objectAtIndexPath(indexPath) as Note
            context.deleteObject(note)
            context.save(nil)
        }
    }
    
    
}
