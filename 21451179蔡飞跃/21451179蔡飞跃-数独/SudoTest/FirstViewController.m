//
//  FirstViewController.m
//  SudoTest
//
//  Created by 蔡飞跃 on 14/12/22.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//


#import "FirstViewController.h"

#import "GameViewController.h"


@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize topView;

#pragma mark - ButtonAction

/*游戏开始*/
-(IBAction)StartGame:(id)sender
{
    GameViewController *gameController = [[GameViewController alloc]initWithNibName:@"GameViewController" 
                                                                             bundle:nil];
    
    [self.navigationController pushViewController:gameController animated:YES];
    
    [gameController release];
}


- (void)addBlocker {
    blocker = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
    [blocker addTarget:self action:@selector(closeTopView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blocker];
    
    [blocker release];
}


#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{

    //[self setSoundSetButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
	//[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [super dealloc];
}
@end
