//
//  ViewController.h
//  mount
//
//  Created by 江山 on 12/3/14.
//  Copyright (c) 2015 jiangshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
- (IBAction)bill:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *myImage;
@property (strong, nonatomic) IBOutlet UITableView *tableOutlet;

@property (strong,nonatomic) NSArray*list;
@end
