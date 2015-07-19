//
//  Paint.m
//  mynote
//
//  Created by Devon on 14/11/20.
//  Copyright (c) 2014年 Devon. All rights reserved.
//
#import "Paint.h"
#import "MyView.h"

@interface Paint ()

@property (strong,nonatomic)  MyView *drawView;

@end

@implementation Paint

//保存线条颜色
static NSMutableArray *colors;
- (void)viewDidLoad {
    [super viewDidLoad];
    colors=[[NSMutableArray alloc]initWithObjects:[UIColor blueColor],[UIColor redColor],[UIColor greenColor],[UIColor yellowColor], nil];
    CGRect viewFrame=self.view.frame;
    self.drawView=[[MyView alloc]initWithFrame:viewFrame];
    [self.drawView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview: self.drawView];
    [self.view sendSubviewToBack:self.drawView];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)clear:(id)sender{
    [self.drawView clear];
}

- (IBAction)widthSet:(id)sender {
    UIButton *button=(UIButton *)sender;
    [self.drawView setlineWidth:button.tag-8];
}

- (IBAction)colorSet:(id)sender {
    UIButton *button=(UIButton *)sender;
    [self.drawView setLineColor:button.tag-4];
}

- (IBAction)save:(id)sender {
    for (int i=2; i<12;i++) {
        UIView *view=[self.view viewWithTag:i];
        view.hidden=YES;
    }
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    [self.delegate CallBack:UIImagePNGRepresentation(image)];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
