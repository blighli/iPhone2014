//
//  ThirdViewController.h
//  MyNotes
//
//  Created by 樊博超 on 14-11-14.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "DrawView.h"
#import "NoteData.h"
@interface ThirdViewController : UIViewController
{
    UIButton *clear;
    UIButton *save;
    UITextField *drawNameView;
    Database *db;
    DrawView * drawview;
}
@property(nonatomic, strong) NoteData *item;
-(IBAction)clearDraw:(id)sender;
-(IBAction)saveDraw:(id)sender;
@end
