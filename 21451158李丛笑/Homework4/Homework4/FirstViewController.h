//
//  FirstViewController.h
//  Homework4
//
//  Created by 李丛笑 on 14/11/23.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondTableViewController.h"

@interface FirstViewController : UIViewController

{
    NSMutableArray *texts, *titles;
    NSMutableString *text, *title;
}

-(NSArray *)gettexts;
-(NSArray *)gettitles;

- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *titlebox;
@property (weak, nonatomic) IBOutlet UITextView *textbox;

@property (strong, nonatomic) NSString *thistitle;
@property (strong, nonatomic) NSString *thistext;
@property (strong, nonatomic) NSString *textcount;



@end
