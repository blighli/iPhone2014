//
//  historyViewController.m
//  cardgame
//
//  Created by emily on 14-11-7.
//  Copyright (c) 2014年 com.emily. All rights reserved.
//

#import "historyViewController.h"

@interface historyViewController ()

@property (weak, nonatomic) IBOutlet UITextView *historyText;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *clearHistory;

@end

@implementation historyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)clearRecord:(id)sender
{
    if (_historyText) {
        _historyText.text = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _historyText.text = _historyvaluse;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
