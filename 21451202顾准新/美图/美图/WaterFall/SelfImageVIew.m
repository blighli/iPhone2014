//
//  SelfImageVIew.m
//  hlrenTest
//  美图
//
//  Created by 顾准新 on 14-12-23.
//  Copyright (c) 2014年 icephone. All rights reserved.
//

#import "SelfImageVIew.h"
#import "Colours.h"

@interface SelfImageVIew (){
    BOOL isCkicked;
}

@end
@implementation SelfImageVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(id)initWithImageInfo:(ImageInfo*)imageInfo y:(float)y  withA:(int)a
{
    
    if (imageInfo.thumbURL.length < 8)
    {
        return nil;
    }
    
    _data = imageInfo;
    float imageW = imageInfo.width;
    float imageH = imageInfo.height;
    float width = WIDTH - SPACE;
    float height = width * imageH / imageW;

    self = [super initWithFrame:CGRectMake(0, y, WIDTH, height + SPACE)];
    if (self)
    {
        self.data = imageInfo;
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SPACE / 2 , SPACE / 2 , width, height)];
        NSURL *url = [NSURL URLWithString:imageInfo.thumbURL];
        [imageView setImageWithURL:url placeholderImage:nil];
        imageView.backgroundColor = [UIColor cornflowerColor];
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.75];
        if(![imageInfo.title isEqualToString:@""]){
            label.text = imageInfo.title;
        }else{
            label.text =@"Junsion";
        }
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:10];
       
        
        float labelH = [label.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]} context:nil].size.height;
        
        if(labelH > height*0.333){
            labelH = height*0.333;
        }
        label.frame = CGRectMake(SPACE/2, height-labelH, width, labelH);
        [self addSubview:label];
        
        float clickW = 30;
        float clickH = 25;
        
        
        UIButton *click = [[UIButton alloc] initWithFrame:CGRectMake(width-clickW, height-labelH-clickH, clickW, clickH)];
        
        if([imageInfo.love isEqualToString:@"YES"]){
            [click setImage:[UIImage imageNamed:@"yes"] forState:UIControlStateNormal];
              isCkicked = YES;
            
        }else{
            [click setImage:[UIImage imageNamed:@"no"] forState:UIControlStateNormal];
              isCkicked = NO;
        }
        [click setContentMode:UIViewContentModeCenter];
        
        [click addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:click];
      
        
        // 单击
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom:)];
        singleRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleRecognizer];
        
        //长按
        UILongPressGestureRecognizer *longRecognizer;
        longRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleLongFrom:)];
        [self addGestureRecognizer:longRecognizer];
        
        [singleRecognizer requireGestureRecognizerToFail:longRecognizer];
        
    }
    
    return self;
}

//点赞收藏
-(void)click:(UIButton *)sender{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * namePath = [documentsDirectory stringByAppendingPathComponent:@"myLove.plist"];
    NSMutableArray *picArray = [[NSMutableArray alloc] initWithContentsOfFile:namePath];
    
    if (picArray == NULL)
    {
        picArray = [[NSMutableArray alloc]init];
    }
    //写入新数据

    NSMutableDictionary *nowDic = [[NSMutableDictionary alloc]init];
    [nowDic setObject:_data.thumbURL forKey:@"image_url"];
    [nowDic setObject:_data.title forKey:@"desc"];
    [nowDic setObject:[NSString stringWithFormat:@"%f",_data.height] forKey:@"image_height"];
    [nowDic setObject:[NSString stringWithFormat:@"%f",_data.width] forKey:@"image_width"];
    [nowDic setObject:@"YES" forKey:@"love"];
    
    UIAlertView *promptAlert;
    if(isCkicked){
        [sender setImage:[UIImage imageNamed:@"no"] forState:UIControlStateNormal];
        if ([picArray containsObject:nowDic])
        {
            [picArray removeObject:nowDic];
            [picArray writeToFile:namePath atomically:YES];
            
            promptAlert = [[UIAlertView alloc] initWithTitle:@"取消收藏照片" message:@"您已将照片从收藏夹内移除。" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            
            [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(timerFireMethod:)
                                           userInfo:promptAlert
                                            repeats:YES];
            [promptAlert show];
            
            
            
        }
    }else{
        
        
        if (![picArray containsObject:nowDic])
        {
            [sender setImage:[UIImage imageNamed:@"yes"] forState:UIControlStateNormal];
            //[nowDic setObject:@"YES" forKey:@"love"];
            [picArray addObject:nowDic];
            [picArray writeToFile:namePath atomically:YES];
            
            promptAlert = [[UIAlertView alloc] initWithTitle:@"收藏照片成功" message:@"您可以在收藏夹内查看" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        }else{
            promptAlert = [[UIAlertView alloc] initWithTitle:@"图片已存在" message:@"您可以在收藏夹内查看" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        }
    }
    
    
    
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values = @[@(0.1),@(1.0),@(1.5)];
    k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    k.calculationMode = kCAAnimationLinear;
    
    [sender.layer addAnimation:k forKey:@"SHOW"];
    
    isCkicked = !isCkicked;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}
//弹出框自动消失
- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}

//单击事件
- (void)handleSingleTapFrom:(UISwipeGestureRecognizer*)recognizer
{
    //[self.delegate clickImage:self.data];
    self.didClickImage(self.data);
}

//长按事件
- (void)handleSingleLongFrom:(UISwipeGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        return;
    }
    else if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        //[self.delegate removeImg:self.data];
        self.didRemoveImage(self.data);
    }
}

@end
