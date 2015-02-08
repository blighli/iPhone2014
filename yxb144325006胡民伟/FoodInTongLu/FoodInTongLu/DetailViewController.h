//
//  DetailViewController.h
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/4.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Restaurant *restaurant;

@end
