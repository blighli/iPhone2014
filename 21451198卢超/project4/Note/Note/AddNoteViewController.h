//
//  AddNoteViewController.h
//  Note
//
//  Created by jiaoshoujie on 14-11-21.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface AddNoteViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic,strong) NSString *databaseFilePath;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightButon;

@end
