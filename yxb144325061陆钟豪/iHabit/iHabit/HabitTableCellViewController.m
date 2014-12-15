//
//  HabitTableCellViewController.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/3.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "HabitTableCellViewController.h"
#import "TimeLineView.h"
#import "math.h"
#import "CellActionView.h"
#import "HabitBiz.h"
#import "HabitTableViewCell.h"

@interface HabitTableCellViewController ()

@end

@implementation HabitTableCellViewController{
    CGPoint _touchBeginPoint;
    BOOL _isTouchBegin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    HabitTableViewCell *cell = (HabitTableViewCell*) super.view;
    
    TimeLineView *timeLine = [[TimeLineView alloc] initWithFrame:CGRectMake(67, 50, 242, 30)];
    timeLine.backgroundColor = UIColor.clearColor;
    [cell.contentView addSubview:timeLine];
    self.timeLineView = timeLine;
    
    UIView *doneAction = [[CellActionView alloc] initWithFrame:CGRectMake(-100, 0, 100, 80)];
    doneAction.backgroundColor = UIColor.greenColor;
    [cell.contentView addSubview:doneAction];
    
    UIView *skipAction = [[CellActionView alloc] initWithFrame:CGRectMake(320, 0, 100, 80)];
    skipAction.backgroundColor = UIColor.blueColor;
    [cell.contentView addSubview:skipAction];
    
    cell.contentView.layer.masksToBounds = NO;
    
    cell.textLabel.font = [UIFont fontWithName:@"Raleway-Tracked" size:22];
    cell.contentView.backgroundColor = UIColor.whiteColor;
    
    [cell addObserver:self forKeyPath:@"habit" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    self.offsetMinX = -100;
    self.offsetMaxX = 100;
    
    [NSTimer scheduledTimerWithTimeInterval:1   // FIXME 1秒钟刷新一次是为了测试
                                     target:[NSBlockOperation blockOperationWithBlock:^{
        cell.habit = cell.habit;    //刷新
    }]
                                   selector:@selector(main)
                                   userInfo:nil
                                    repeats:YES
     ];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    HabitTableViewCell *cell = (HabitTableViewCell*) self.view;
    Habit *habit = cell.habit;
    
    // observe self.view(cell view).habit
//    if([keyPath isEqualToString:@"habit"]){
//        Habit *oldHabit = [change valueForKey:NSKeyValueChangeOldKey];
//        if((NSNull *)oldHabit != [NSNull null]) { // NSNull坑死人啊！
//            // FIXME should I remove these observer??
//            [oldHabit removeObserver:self forKeyPath:@"title"];
//            [oldHabit removeObserver:self forKeyPath:@"iconKey"];
//            [oldHabit removeObserver:self forKeyPath:@"period"];
//            [oldHabit removeObserver:self forKeyPath:@"times"];
//            [oldHabit removeObserver:self forKeyPath:@"createTime"];
//            [oldHabit removeObserver:self forKeyPath:@"nextDoTime"];
//            [oldHabit removeObserver:self forKeyPath:@"nextPeriodBeginTime"];
//            [oldHabit removeObserver:self forKeyPath:@"doTime"];
//            [oldHabit removeObserver:self forKeyPath:@"skipTime"];
//            [oldHabit removeObserver:self forKeyPath:@"surplusTimes"];
//        }
//        [habit addObserver:self forKeyPath:@"title" options:0 context:nil];
//        [habit addObserver:self forKeyPath:@"iconKey" options:0 context:nil];
//        [habit addObserver:self forKeyPath:@"period" options:0 context:nil];
//        [habit addObserver:self forKeyPath:@"times" options:0 context:nil];
//        [habit addObserver:self forKeyPath:@"createTime" options:0 context:nil];
//        [habit addObserver:self forKeyPath:@"nextDoTime" options:0 context:nil];
//        [habit addObserver:self forKeyPath:@"nextPeriodBeginTime" options:0 context:nil];
//        [habit addObserver:self forKeyPath:@"doTime" options:0 context:nil];
//        [habit addObserver:self forKeyPath:@"skipTime" options:0 context:nil];
//        [habit addObserver:self forKeyPath:@"surplusTimes" options:0 context:nil];
//    }
    
    cell.textLabel.text = habit.title;
    
    // 设置图标
    UIImage *iconImage = [UIImage imageNamed:habit.iconName];
    CGSize iconSize = iconImage.size;
    cell.imageView.maskView = [[UIImageView alloc] initWithImage:iconImage];
    UIGraphicsBeginImageContext(iconSize);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, habit.color.CGColor);
    CGContextFillRect(contextRef, CGRectMake(0, 0, iconSize.width, iconSize.height));
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // FIXME 整合到HabitBiz中
    NSDate *nowDate = [NSDate date];
    if([habit.nextDoTime timeIntervalSinceDate:nowDate] > 0) {
        NSDate *lastActionTime = habit.lastActionTime;
        self.timeLineView.progressRatio = fmax([nowDate timeIntervalSinceDate:lastActionTime] / [habit.nextDoTime timeIntervalSinceDate:lastActionTime], 0);
        if(habit.doTime != nil) {
            NSTimeInterval nowTimeIntervalSinceDoTime = [nowDate timeIntervalSinceDate:habit.doTime];
            NSTimeInterval nextDoTimeIntervalSinceNow = [habit.nextDoTime timeIntervalSinceDate:nowDate];
            if(nowTimeIntervalSinceDoTime < 60) {
                self.timeLineView.tip = @"Just done!";
            }
            else if(nextDoTimeIntervalSinceNow < 60 * 5) {
                self.timeLineView.tip = @"Do soon!";
            }
            else {
                self.timeLineView.tip = [NSString stringWithFormat:@"%f", nowTimeIntervalSinceDoTime];
            }
        }
        else {
            self.timeLineView.tip = @"New!";
        }
    }
    else if([nowDate timeIntervalSinceDate:habit.nextPeriodBeginTime] > 0 && habit.surplusTimes > 0){
        self.timeLineView.progressRatio = 1.1;  // late
        self.timeLineView.tip = @"Late!";
    }
    else {
        self.timeLineView.progressRatio = 1.0;  // do now
        self.timeLineView.tip = @"Do now!";
    }
    self.timeLineView.color = habit.color;
    [self.timeLineView setNeedsDisplay]; // FIXME 使用Observer？？
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _touchBeginPoint = [touch locationInView:self.view];
    _isTouchBegin = YES;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(!_isTouchBegin) return;
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    CGFloat offsetX = touchPoint.x - _touchBeginPoint.x;
    offsetX = fmaxf(offsetX, self.offsetMinX);
    offsetX = fminf(offsetX, self.offsetMaxX);
    HabitTableViewCell *cell = (HabitTableViewCell*)(self.view);
    UIView *cellContentView = cell.contentView;
    cellContentView.frame = CGRectMake(offsetX,
                                        cellContentView.frame.origin.y,
                                        cellContentView.frame.size.width,
                                        cellContentView.frame.size.height);
    
    if(0 < offsetX && offsetX < self.offsetMaxX) {
        float offsetRatio = offsetX / self.offsetMaxX;
        cellContentView.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.3 * offsetRatio];
    }
    else if(self.offsetMinX < offsetX && offsetX < 0) {
        float offsetRatio = offsetX / self.offsetMinX;
        cellContentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.3 * offsetRatio];
    }
    
    NSInteger afterActionIndex;
    if(offsetX == self.offsetMinX)
        afterActionIndex = [[HabitBiz getInstance]skip:cell.habit];
    else if(offsetX == self.offsetMaxX)
        afterActionIndex = [[HabitBiz getInstance]done:cell.habit];
    else
        return;
    
    cell.habit = cell.habit; //刷新
    
    UITableView *tableView = ((UITableViewController*)self.parentViewController).tableView;
    _isTouchBegin = NO;

    // done skip动画效果
    [UIView animateKeyframesWithDuration:.5 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            
            cell.layer.transform = CATransform3DRotate(cell.layer.transform, -M_PI/2, 1.0f, 0.0f, 0.0f);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.0 animations:^{
            cell.layer.transform = CATransform3DRotate(cell.layer.transform, M_PI, 1.0f, 0.0f, 0.0f);
            cellContentView.frame = CGRectMake(0,
                                               cellContentView.frame.origin.y,
                                               cellContentView.frame.size.width,
                                               cellContentView.frame.size.height);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            cell.layer.transform = CATransform3DRotate(cell.layer.transform, -M_PI/2, 1.0f, 0.0f, 0.0f);
        }];
    } completion:^(BOOL finished){
        [tableView moveRowAtIndexPath:[tableView indexPathForCell:cell] toIndexPath:[NSIndexPath indexPathForRow:afterActionIndex inSection:0]];
    }];
    
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UIView *cellContentView = ((UITableViewCell*)(self.view)).contentView;
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cellContentView.frame = CGRectMake(0,
                                            cellContentView.frame.origin.y,
                                            cellContentView.frame.size.width,
                                            cellContentView.frame.size.height);
        cellContentView.backgroundColor = [UIColor clearColor];
    } completion:nil];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

-(void)dealloc {
    [self.view removeObserver:self forKeyPath:@"habit"];
}

@end
