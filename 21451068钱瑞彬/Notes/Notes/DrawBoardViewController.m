//
//  DrawBoardViewController.m
//  Notes
//
//  Created by apple on 14-11-23.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import "DrawBoardViewController.h"

@interface DrawBoardViewController ()

@end

@implementation DrawBoardViewController

- (NSString*)getNowDate {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString* timeString = [NSString stringWithFormat:@"%.0f", time]; //转为字符型
    return timeString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isNewDraw) {
        self.drawItem = [NSString stringWithFormat:@"%@.png", [self getNowDate]];
    }
    
    NSString* aPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), self.drawItem];
    UIImage* image = [[UIImage alloc]initWithContentsOfFile:aPath];
    if(image != nil) {
        UIColor* bgColor = [UIColor colorWithPatternImage:image];
        [self.drawBoard setBackgroundColor:bgColor];
    }
    
    self.drawBoard.paths = CGPathCreateMutable();
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 截图
- (UIImage*)imageFromView:(UIView*)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 1.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)save {
    UIImage* image = [self imageFromView:self.drawBoard];
    NSString* aPath =[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), self.drawItem];
    NSData* imgData = UIImageJPEGRepresentation(image, 1.0);
    [imgData writeToFile:aPath atomically:YES];
}


// 传递数据
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.done) return;
    [self save];
}


@end
