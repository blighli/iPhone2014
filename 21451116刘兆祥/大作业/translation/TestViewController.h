//
//  TestViewController.h
//  translation
//
//  Created by Steve on 14-12-27.
//  Copyright (c) 2014年 Steve. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface TestViewController : UIViewController<UIAlertViewDelegate>
{
    sqlite3 *db;
    IBOutlet UILabel *WordLabel;
    IBOutlet UILabel *MeaningLabel;
    IBOutlet UIButton *ReadChinese;
    NSMutableArray *word;
    NSMutableArray *meaning;
    int i;
    int flag;
    
}
-(IBAction)Remember;
-(IBAction)Forget;
-(IBAction)ReadChinese;

@end