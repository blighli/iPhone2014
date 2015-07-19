//
//  IconPickerController.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/20.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "IconPickerController.h"
#import "Habit.h"
#import "Util.h"
#import <objc/runtime.h>

@interface IconPickerController ()

@end

@implementation IconPickerController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSDictionary* iconColorDict = [Habit iconColorDict];
    [iconColorDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *iconName = (NSString *)key;
        UIColor *iconColor = (UIColor *)obj;
        // 设置图标
        UIImage *iconFileImage = [UIImage imageNamed:iconName];
        CGSize iconSize = iconFileImage.size;
        UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0.0); // That way, on a double-resolution screen, you'll get a double-resolution graphics context. 否则有锯齿，就是这样！
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        [iconFileImage drawInRect:CGRectMake(0, 0, iconSize.width, iconSize.height)];
        CGContextSetBlendMode(contextRef, kCGBlendModeSourceIn);
        CGContextSetFillColorWithColor(contextRef, iconColor.CGColor);
        CGContextFillRect(contextRef, CGRectMake(0, 0, iconSize.width, iconSize.height));
        UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
        UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        iconButton.frame = CGRectInset(CGRectMake(0, 0, iconImage.size.width, iconImage.size.height), -10, -10);
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(10 - 3, 10 - 3, iconImage.size.width + 3 * 2, iconImage.size.height + 3 * 2)];
        [iconButton setImage:iconImage forState:UIControlStateNormal];
        [iconButton addTarget:self action:@selector(selectCellView:) forControlEvents:UIControlEventTouchUpInside];
        ActionBlock* actionBlock = [[ActionBlock alloc] initWith:^(id sender){
            _selectedIconName = iconName;
        }];
        [iconButton addTarget:actionBlock action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(self, "selectedViewFrame", selectedView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//runtime添加属性 哈哈
        [self addCellView:iconButton];
        [self addChildViewController:actionBlock];//button的target必须是contrlloer，坑
    }];
    self.numberOfCellInRow = 4;
    self.horizontalSpace = 5;
    self.verticalSpace = 5;
    [self layoutCellViews];
    [self selectCellViewWithIndex:0];
}

-(void)action:(id) sender{
    NSLog(@"hello");
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

@end
