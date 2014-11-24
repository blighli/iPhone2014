//
//  DrawViewController.m
//  MyNotes
//
//  Created by cstlab on 14/11/12.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawView.h"

@interface DrawViewController ()
@property(strong,nonatomic) DrawView *drawView;
@property(assign,nonatomic) BOOL widthBtnHidden;
@property(assign,nonatomic) BOOL colorBtnHidden;

@end

@implementation DrawViewController
NSMutableArray *colors;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    colors=[[NSMutableArray alloc]initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blackColor],[UIColor whiteColor], nil];    // Do any additional setup after loading the view from its nib.
    CGRect viewFrame =  self.view.frame;
    self.drawView = [[DrawView alloc]initWithFrame:viewFrame];
    [self.view addSubview:self.drawView];
    [self.view sendSubviewToBack:self.drawView];
    self.widthBtnHidden = YES;
    self.colorBtnHidden = YES;
  //  self.view.backgroundColor = [UIColor whiteColor];
    self.drawView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.title = @"画图";
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ClearAll:(UIButton *)sender {
    NSLog(@"ClearAll");
    [self.drawView clearAll];
}

- (IBAction)Save:(UIButton *)sender {
    
    NSLog(@"Save!");
    // hidden the  all the button
    for (int i= 1; i<16; i++) {
        UIView *view = [self.view viewWithTag:i];
        if (view.hidden == NO) {
            view.hidden = YES;
        }
    }
    
    // get the current image
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *MyImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(MyImage, self, nil, nil);
    
    
    //delegate AlerView for Success
    for (int i=1;i<16;i++) {
        if ((i>=1&&i<=5)||(i>=11&&i<=14)) {
            continue;
        }
        UIView *view=[self.view viewWithTag:i];
        view.hidden=NO;
    }    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"保存成功" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancle", nil];
    
    [alertView show];
  
}

- (IBAction)TapWithBtn:(UIButton *)sender {
    UIButton *btn = sender;
    [self.drawView SetWidthForLine:btn.tag-11];
}

- (IBAction)TapColorBtn:(UIButton *)sender
{
    UIButton *btn = (UIButton*)sender;
    [self.drawView SetColorForLine:btn.tag-1];
    self.ColorBtn.backgroundColor = [colors objectAtIndex:btn.tag-1];
    
}

- (IBAction)selectColor:(UIButton *)sender{
    if (self.colorBtnHidden == YES) {
        for (int i = 1; i<6; i++) {
            UIButton *ColorBtn = (UIButton *)[self.view viewWithTag:i];
            ColorBtn.hidden = NO;
            self.colorBtnHidden = NO;
            
        }
        
    }else
    {
        for (int i = 1; i<6; i++) {
            UIButton *ColorBtn = (UIButton *)[self.view viewWithTag:i];
            ColorBtn.hidden = YES;
            self.colorBtnHidden = YES;
        }

    }
    
}

- (IBAction)Back:(UIButton *)sender {
    [self.drawView BackToTheLast];
}

- (IBAction)SelectWidth:(UIButton *)sender {
    if (self.widthBtnHidden == YES) {
        for (int i = 11; i<15; i++) {
            UIButton *WidthBtn = (UIButton *)[self.view viewWithTag:i];
            WidthBtn.hidden = NO;
            self.widthBtnHidden = NO;
        }
        
    }else
    {
        for (int i = 11; i<15; i++) {
            UIButton *WidthBtn = (UIButton *)[self.view viewWithTag:i];
            WidthBtn.hidden = YES;
            self.widthBtnHidden = YES;
        }
        
    }
}

- (IBAction)Delete:(UIButton *)sender {
    [self.drawView deleteTheLast];
}
@end
