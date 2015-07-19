//
//  XlTabBarButton.m
//  XinLang
//
//  Created by 周舟 on 14-10-1.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XlTabBarButton.h"
#import "XLBadgeButton.h"

@interface XlTabBarButton()
@property (nonatomic, weak) XLBadgeButton *badgeButton;

@end

@implementation XlTabBarButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        //文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:XLColor(234, 103, 7) forState:UIControlStateSelected];
        
        //添加一个数字提醒
        XLBadgeButton *badgeButton = [[XLBadgeButton alloc]init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}
-(void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    //KVO 监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
}

-(void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    
    
}

/**
 *  监听到某个对象的属性改变了就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  熟悉发生得改变
 *  @param context
 */

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //NSLog(@"keyPath:%@,object:%@,change:%@,context:%@",keyPath, object, change, context);
    //设置文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];;
    
    //设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    //设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    //设置提醒数字的位置
    CGFloat badgeY = 0;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 1;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
}


//内部图片的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.6;
    return CGRectMake(0, 0, imageW, imageH);
    
}
//内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * 0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY - 3;
    
    return  CGRectMake(0, titleY, titleW, titleH);
    
}
@end
