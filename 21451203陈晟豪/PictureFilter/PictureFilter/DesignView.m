//
//  DesignView.m
//  PictureFilter
//
//  Created by 陈晟豪 on 14/12/27.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import "DesignView.h"

@implementation DesignView

+ (UIImageView *)initTappedLayerStyle
{
    UIImageView *tappedLayer;
    tappedLayer = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    tappedLayer.layer.masksToBounds = YES;
    tappedLayer.layer.cornerRadius = 25;
    tappedLayer.image = [UIImage imageNamed:@"TappedLayer"];
    
    return tappedLayer;
}

+ (void)initTabBarItemSelectedStyle:(UITabBarItem *)tabBarItem withSelectedImage:(NSString *)imageName
{
    //设置选中后的图片
    tabBarItem.selectedImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置选中后的颜色
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor orangeColor], NSForegroundColorAttributeName ,nil] forState:UIControlStateSelected];
    
    //初始化不可用
    tabBarItem.enabled = NO;
}

+ (void)initImageViewStyle:(UIImageView *)imageView
{
    //将图片按比例填满imageView
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
}

+ (void)initScrollViewStyle:(UIScrollView *)scrollView
{
    //ScrollView滚动指标风格(默认）
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    
    //ScrollView水平和垂直指针不显示
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    //ScrollView滚动到内容边缘是否发生反弹
    scrollView.bounces = NO;
    
    //给scrollView创建薄膜里效果
    UIBlurEffect *blur1 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview1 = [[UIVisualEffectView alloc] initWithEffect:blur1];
    effectview1.frame =CGRectMake(0, 0, 1200, 90);
    scrollView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:effectview1];
    
    
    //初始化隐藏
    scrollView.hidden = YES;
    
    if(scrollView.tag == 402)
    {
        //添加滤镜
        NSArray *arrFilter = @[@"亮度",@"曝光",@"对比度",@"饱和度",@"锐化"];
        
        //把所有的显示效果图添加到scrollView里面
        
        //计算x坐标
        float x = 10;
        for(int i=0;i<arrFilter.count;i++)
        {
            
            x = 100*i+10;
            
            //添加名字标签
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 55, 50, 20)];
            [label setText:[arrFilter objectAtIndex:i]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [label setTextColor:[UIColor blackColor]];
            [scrollView addSubview:label];
            
            //添加滤镜效果图片
            UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 5, 50, 50)];
            bgImageView.contentMode = UIViewContentModeScaleAspectFill;
            bgImageView.clipsToBounds = YES;
            switch (i)
            {
                case 0:
                    bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"brightness"]];
                    break;
                case 1:
                    bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"exposure"]];
                    break;
                case 2:
                    bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"contrast"]];
                    break;
                case 3:
                    bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"saturation"]];
                    break;
                case 4:
                    bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"sharpen"]];
                    break;
                default:
                    break;
            }
            
            //为每个滤镜图片设置tag
            int tag = i+120;
            [bgImageView setTag:tag];
            
            [scrollView addSubview:bgImageView];
        }
        
        //设置滚动视图的实际大小 , 决定你是否可以水平或垂直方向拉动
        scrollView.contentSize = CGSizeMake(x+60, 80);
        
    }
    else if(scrollView.tag == 403)
    {
        //添加滤镜
        NSArray *arrFilter = @[@"无",@"伊甸园",@"水果风",@"美人鱼",@"紫色花",@"巧克力",@"情人节"];
        
        //把所有的显示效果图添加到scrollView里面
        
        //计算x坐标
        float x = 10;
        for(int i=0;i<arrFilter.count;i++)
        {
            
            x = 100*i+10;
            
            //添加名字标签
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 55, 80, 20)];
            [label setText:[arrFilter objectAtIndex:i]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [label setTextColor:[UIColor blackColor]];
            [scrollView addSubview:label];
            
            //添加滤镜效果图片
            UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 5, 80, 50)];
            bgImageView.contentMode = UIViewContentModeScaleAspectFill;
            bgImageView.clipsToBounds = YES;
            bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"frame%d",i]];
            
            //为每个滤镜图片设置tag
            int tag = i+130;
            [bgImageView setTag:tag];
            
            [scrollView addSubview:bgImageView];
        }
        
        //设置滚动视图的实际大小 , 决定你是否可以水平或垂直方向拉动
        scrollView.contentSize = CGSizeMake(x+90, 80);
    }
    else if(scrollView.tag == 404)
    {
        //添加滤镜
        NSArray *arrFilter = @[@"黑",@"灰",@"绿",@"红",@"蓝",@"棕",@"橘",@"紫",@"白"];
        
        //把所有的显示效果图添加到scrollView里面
        
        //计算x坐标
        float x = 10;
        for(int i=0;i<arrFilter.count;i++)
        {
            
            x = 100*i+10;
            
            //添加名字标签
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 55, 50, 20)];
            [label setText:[arrFilter objectAtIndex:i]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setFont:[UIFont systemFontOfSize:12.0f]];
            [label setTextColor:[UIColor blackColor]];
            [scrollView addSubview:label];
            
            //添加滤镜效果图片
            UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 5, 50, 50)];
            bgImageView.contentMode = UIViewContentModeScaleAspectFill;
            bgImageView.clipsToBounds = YES;
            bgImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Color%d",i]];
            
            //为每个滤镜图片设置tag
            int tag = i+140;
            [bgImageView setTag:tag];
            
            [scrollView addSubview:bgImageView];
        }
        
        //设置滚动视图的实际大小 , 决定你是否可以水平或垂直方向拉动
        scrollView.contentSize = CGSizeMake(x+60, 80);
    }
}

+ (UIButton *)initButtonOnvisualEffectView:(UIButton *)button IndexofButton:(NSInteger)index
{
    //根据屏幕宽度创建button
    if([[UIScreen mainScreen] bounds].size.width == 375)
    {
        button = [[UIButton alloc] initWithFrame:CGRectMake(187.5*index+83.75, 5, 20, 20)];
    }
    else if ([[UIScreen mainScreen] bounds].size.width == 414)
    {
        button = [[UIButton alloc] initWithFrame:CGRectMake(207*index+93.5, 5, 20, 20)];
    }
    else
    {
        button = [[UIButton alloc] initWithFrame:CGRectMake(160*index+70, 5, 20, 20)];
    }
    
    if(index == 0)
    {
        [button setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    }
    else if(index == 1)
    {
        [button setBackgroundImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
    }
    
    button.tag = 601+index;
    return button;
}

@end
