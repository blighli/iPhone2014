//
//  ShowNoteViewController.h
//  Note
//
//  Created by jiaoshoujie on 14-11-21.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "Note.h"

@interface ShowNoteViewController : ViewController{

}
@property (nonatomic,strong) NSString *databaseFilePath;
@property (nonatomic, strong) Note *note;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UINavigationItem *noteNavItem;
@property (weak, nonatomic) IBOutlet UILabel *noteDateLabel;

@end
