//
//  ImageWaterView.h
//  美图
//
//  Created by 顾准新 on 14-12-23.
//  Copyright (c) 2014年 icephone. All rights reserved.
//
/*
思路：在scrollview上面放三个UIView代表每一个列，
     然后在每个UIview上添加图片，每次都是挑最短的UIView把图片添加上去；
 */
#import <UIKit/UIKit.h>
#import "SelfImageVIew.h"

#define SPACE 10
#define WIDTH [UIScreen mainScreen].applicationFrame.size.width/2

//@protocol ClickDelegate<NSObject>
//-(void)showImage:(ImageInfo*)data;
//-(void)removeImage:(ImageInfo*)data;
//@end
typedef void (^showImageBlock) (ImageInfo *);
typedef void (^cancelImageBlock) (ImageInfo *);


@interface ImageWaterView : UIScrollView  //<ImageDelegate>
{
    UIView *firstView,*secondView;

    int higher,lower,row;

    float highValue;

    int countImage;
}

//@property (nonatomic,weak)id<ClickDelegate> delegate;
@property (nonatomic,strong)showImageBlock didShowImage;
@property (nonatomic,strong)cancelImageBlock didCancelImage;
@property (nonatomic,strong)NSArray *arrayImage;

-(id)initWithDataArray:(NSArray*)array withFrame:(CGRect)rect;

-(void)refreshView:(NSArray*)array;

-(void)loadNextPage:(NSArray*)array;

@end
