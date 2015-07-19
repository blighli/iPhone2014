//
//  PhotoViewController.h
//  MyNote
//
//  Created by 蔡飞跃 on 14/11/23.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface PhotoViewController : UIViewController
{
    UIActionSheet *myActionSheet;
    sqlite3 *photoDB;
    NSString *databasePath;
    NSString *filePath;
}

@property (retain, nonatomic) IBOutlet UITextField *photo_title;
- (IBAction)insert_photo:(id)sender;
- (IBAction)save:(id)sender;

@end
