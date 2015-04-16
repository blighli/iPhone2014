//
//  HandDrawViewController.m
//  MyNote
//
//  Created by yjq on 14/11/23.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import "HandDrawViewController.h"


@interface HandDrawViewController ()<UINavigationControllerDelegate>

@property(weak,nonatomic) IBOutlet UIButton *pickColorButton;
@property(weak,nonatomic) IBOutlet UIButton *pickEraserButton;
@property(weak,nonatomic) IBOutlet UIButton *drawButton;
@property(weak,nonatomic) UIColor *selectedColor;

-(IBAction)pickColorButton:(id)sender;
-(IBAction)pickEraserButton:(id)sender;
-(IBAction)drawButton:(id)sender;
-(IBAction)dismissKeyboard:(id)sender;
-(IBAction)clearImageButton:(id)sender;

@end

@implementation HandDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]   initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self.pickColorButton.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.pickColorButton.layer setBorderWidth:5.0];
    [self.pickColorButton.layer setCornerRadius:3.0];
    self.selectedColor=[UIColor redColor];
    [self.pickColorButton setBackgroundColor:self.selectedColor];
    self.textfield.text=self.textString;
    self.imageview.image=self.handimage;
    self.drawerView.hidden=self.flag;
    //[self.drawerView setSelectedColor:self.selectedColor];
    //[self.drawerView awakeFromNib];
    
}

#pragma mark -Button Action methods
-(IBAction)pickColorButton:(id)sender
{
    
}

-(IBAction)pickEraserButton:(id)sender
{

    [self.drawerView setDrawingMode:DrawingModeErase];
}

-(IBAction)drawButton:(id)sender
{
    [self.drawerView setDrawingMode:DrawingModePaint];
}

-(IBAction)clearImageButton:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *) handImageDocPath
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    //return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"handimage.png"];
    return [pathList objectAtIndex:0];
}

//标题存放地址
-(NSString *) textDocPath
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

-(IBAction)dismissKeyboard:(id)sender
{
    [self.textfield resignFirstResponder];
}

-(void)dismissKeyboard
{
    [self.textfield resignFirstResponder];
}

@end
