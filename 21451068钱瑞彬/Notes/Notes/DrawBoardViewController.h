//
//  DrawBoardViewController.h
//  Notes
//
//  Created by apple on 14-11-23.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import "ViewController.h"
#import "DrawBoardView.h"

@interface DrawBoardViewController : ViewController

@property (strong, nonatomic) IBOutlet DrawBoardView *drawBoard;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *done;
@property (weak, nonatomic) IBOutlet UINavigationItem *barTitle;

@property BOOL isNewDraw;
@property NSString* drawItem;

@end
