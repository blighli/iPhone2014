//
//  NodeDetailViewController.swift
//  MyNote
//
//  Created by Joker on 14/11/21.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

import UIKit

class NodeDetailViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var content: UITextView!
    
    var time:String!
    var text:String!
    var image: UIImage? = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.timeLabel.text = time
        self.content.text = text
        self.imageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
