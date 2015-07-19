//
//  DrawViewController.swift
//  MyNote
//
//  Created by Joker on 14/11/21.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {

    @IBOutlet weak var drawBoardView: DrawingBoardView!
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        
        UIGraphicsBeginImageContext(drawBoardView.bounds.size)
        drawBoardView.layer.renderInContext(UIGraphicsGetCurrentContext())
        var draw = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
//        println(self.navigationController?.viewControllers)
        (self.navigationController?.viewControllers[1] as AddNoteViewController).image.image = draw
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
