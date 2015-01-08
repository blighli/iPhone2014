//
//  DrawViewController.m
//  Homework4
//
//  Created by 李丛笑 on 14/12/22.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawView.h"

//#define ToolViewY (IS_IOS7 ? 20 :0)

@interface DrawViewController ()

@property(strong,nonatomic) DrawView *drawView;

@end

@implementation DrawViewController
NSMutableArray *colors;
int colorcount =0;
int widthcount =0;
- (void)viewDidLoad {
    [super viewDidLoad];
    colors  = [[NSMutableArray alloc]initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blackColor],[UIColor whiteColor], nil];
    CGRect frame = self.view.frame;
    self.drawView = [[DrawView alloc]initWithFrame:frame];
    [self.drawView setColor:colorcount];
    [self.drawView setWidth:widthcount];
    [self.view addSubview:self.drawView];
    [self.view sendSubviewToBack:self.drawView];
    self.drawView.backgroundColor = [UIColor whiteColor];
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    
}


- (IBAction)Color:(id)sender {
    colorcount++;
    if (colorcount == 6) {
        colorcount = 0;
    }
    [self.drawView setColor:colorcount];
    //Color.backgroundColor = [UIColor [colors objectAtIndex:colorCount]];

    
    
}

- (IBAction)Width:(id)sender {
    widthcount++;
    if (widthcount == 4) {
        widthcount = 0;
    }
    [self.drawView setWidth:widthcount];
}

- (IBAction)Clear:(id)sender {
 //   [self.drawView clearall];
}

- (IBAction)Save:(id)sender {
    UIView *view = [self.view viewWithTag:0];
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *MyImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(MyImage, self, nil, nil);

}
@end
