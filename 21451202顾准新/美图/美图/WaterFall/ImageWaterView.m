//
//  ImageWaterView.m
//  美图
//
//  Created by 顾准新 on 14-12-23.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import "ImageWaterView.h"

@implementation ImageWaterView
@synthesize arrayImage;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithDataArray:(NSArray*)array withFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    
    if (self) {
        self.arrayImage = array;
        [self initParameter];
        
    }
    return self;
}
-(void)initParameter
{
    //每一列的视图初始化
    firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0)];
    secondView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, 0)];
    
    higher = row = highValue = lower = 1;
    countImage = 0;
    
    for (int i = 0; i<self.arrayImage.count; i++) {
        //0%3=0,0-2除3也不可能大于0
        if (i/2>0 && i%2==0) {
            row++;
        }
        ImageInfo *data = (ImageInfo*)[self.arrayImage objectAtIndex:i];
        
        countImage ++;
        //添加视图
        [self addViews:data with:countImage];
        //重新设置最高和最低view
        [self setHigherAndLower];
    }
    
    [self setContentSize:CGSizeMake(160.0f, highValue)];
    [self addSubview:firstView];
    [self addSubview:secondView];
}
-(void)addViews:(ImageInfo *)image with:(int)a
{
    //要添加到列上的图片对象
    SelfImageVIew *imageView = nil;
    //图片的高度
    float imageHeight = 0;
    
    switch (lower) {
        case 1:
            imageView = [[SelfImageVIew alloc]initWithImageInfo:image y:firstView.frame.size.height withA:a];
            imageHeight = imageView.frame.size.height;
            firstView.frame = CGRectMake(firstView.frame.origin.x, firstView.frame.origin.y, WIDTH, firstView.frame.size.height + imageHeight);
            [firstView addSubview:imageView];
            break;
        case 2:
            imageView = [[SelfImageVIew alloc]initWithImageInfo:image y:secondView.frame.size.height  withA:a];
            imageHeight = imageView.frame.size.height;
            secondView.frame = CGRectMake(secondView.frame.origin.x, secondView.frame.origin.y, WIDTH, secondView.frame.size.height + imageHeight);
            [secondView addSubview:imageView];
            break;
        default:
            break;
    }
    imageView.didClickImage = ^(ImageInfo *data){
        self.didShowImage(data);
    };
    
    imageView.didRemoveImage = ^(ImageInfo *data){
        self.didCancelImage(data);
    };
    //imageView.delegate = self;
}
-(void)setHigherAndLower
{
    float firstHeight = firstView.frame.size.height;
    float secondHeight = secondView.frame.size.height;

    if (firstHeight > highValue) {
        highValue = firstHeight;
        higher = 1;
    }else if (secondHeight > highValue){
        highValue = secondHeight;
        higher = 2;
    }
 
    if (firstHeight < secondHeight)
    {
        lower = 1;
    }else
    {
        lower = 2;
    }
}

//-(void)clickImage:(ImageInfo *)data
//{
//    [self.delegate showImage:data];
//}
//
//-(void)removeImg:(ImageInfo *)data
//{
//    [self.delegate removeImage:data];
//}

-(void)refreshView:(NSArray*)array
{
    [firstView removeFromSuperview];
    [secondView removeFromSuperview];
    firstView = nil;
    secondView = nil;
    self.arrayImage = array;
    [self initParameter];
    
}

-(void)loadNextPage:(NSArray*)array
{
    for (int i = 0; i<array.count; i++) {
        if (i/2>0 && i%2==0) {
            row++;
        }
        ImageInfo *data = (ImageInfo*)[array objectAtIndex:i];
        countImage++;
   
        [self addViews:data with:countImage];

        [self setHigherAndLower];
    }
    [self setContentSize:CGSizeMake(WIDTH, highValue)];

}
@end
