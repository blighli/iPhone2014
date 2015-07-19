//
//  AddNoteViewController.swift
//  MyNote
//
//  Created by Joker on 14/11/21.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var inputTextView: UITextView!
    
    var num = ["0", "1", "2"]
    var imageName = ""
    
    // 打开图库
    @IBAction func getImage(sender: UIButton) {
        var c = UIImagePickerController()
        c.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        c.delegate = self
        
        self.presentViewController(c, animated: true, completion: nil)
    }
    
    // 取消笔记
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // 保存笔记
    @IBAction func save(sender: UIBarButtonItem) {
//        println(self.navigationController?.viewControllers)
        
        // 插入一条新的笔记
        let myNote = self.navigationController?.viewControllers.first as MyNoteTableViewController
        let context = myNote.fetchedResultsController.managedObjectContext
        let newNote = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: context) as Note
        newNote.time = timeLabel.text!
        newNote.text = inputTextView.text!
        if (image.image != nil) {
            saveImage(image.image!)
            newNote.image = imageName
        } else {
            newNote.image = ""
        }
        newNote.managedObjectContext?.save(nil)
        
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if (inputTextView.text == "点击编辑") {
            inputTextView.text = ""
            inputTextView.textColor = UIColor.blackColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        inputTextView.delegate = self
        
        //获取当前时间
        let now = NSDate()
        var df = NSDateFormatter()
        df.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm")
        let time = df.stringFromDate(now)
        timeLabel.text = time
        
        df.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        imageName = formatTime(df.stringFromDate(now)) + ".png"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //将选择的图片保存到该笔记中
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        image.image = info[UIImagePickerControllerOriginalImage] as? UIImage

        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveImage(noteImage: UIImage) {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let filePath = paths.first?.stringByAppendingPathComponent(imageName) as String!
        imageName = filePath
        UIImagePNGRepresentation(image.image).writeToFile(filePath, atomically: true)
    }
    
    func formatTime(time: String) ->String {
        var format = ""
        for char in time {
            if (char != "/" && char != ":" && char != " " && char != ",") {
                format += String(char)
            }
        }
        return format
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
