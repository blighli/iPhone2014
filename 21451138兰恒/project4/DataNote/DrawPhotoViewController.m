//
//  DrawPhotoViewController.m
//  EverNote
//
//  Created by lh on 14-11-26.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import "DrawPhotoViewController.h"
#import<QuartzCore/QuartzCore.h>
@interface DrawPhotoViewController ()

@end

@implementation DrawPhotoViewController

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
    _myView = [[DoodleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _myView.backgroundColor = [UIColor yellowColor];
    
    UIButton *that_OK =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    that_OK.frame = CGRectMake(80, 400, 50, 50);
    [that_OK setTitle:@"完成" forState:UIControlStateNormal];
    
    UIButton * undo=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    undo.frame = CGRectMake(180, 400, 50, 50);
    [undo setTitle:@"重绘" forState:UIControlStateNormal];
    
    [that_OK addTarget:self action:@selector(commitDraw) forControlEvents:UIControlEventTouchUpInside];
    [undo addTarget:self action:@selector(undoDraw) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_myView];
    [self.view addSubview:that_OK];
    [self.view addSubview:undo];
	// Do any additional setup after loading the view.
}
-(void)commitDraw
{
    UIImage *oneDraw = [self creatImageFromView:_myView];
    [self.delegate passValue:oneDraw];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)undoDraw
{
    [_myView undo];
    
}

-(UIImage *)creatImageFromView:(UIView *)view
{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.frame.size.width, view.frame.size.height), YES, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
