//
//  MainViewController.m
//  FlappyRect
//
//  Created by lg on 14-12-1.
//  Copyright (c) 2014年 lg. All rights reserved.
//

#import "MainViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "MainScene.h"

@interface MainViewController ()

@property (strong, nonatomic) MainScene *mainScene;

@end

@implementation MainViewController

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
    
    SKView *view = (SKView *)self.view;
    view.showsDrawCount = NO;
    view.showsFPS = NO;
    view.showsNodeCount = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mainScene = [[MainScene alloc] initWithSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    _mainScene.scaleMode = SKSceneScaleModeAspectFit;
    
    SKView *view = (SKView *)self.view;
    [view presentScene:_mainScene];
}

@end
