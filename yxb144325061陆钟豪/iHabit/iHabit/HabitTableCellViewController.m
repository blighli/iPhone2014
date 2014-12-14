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
    timeLine.color = UIColor.blueColor;
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
    
    [cell addObserver:self forKeyPath:@"habit" options:0 context:nil];
    
    self.offsetMinX = -100;
    self.offsetMaxX = 100;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    HabitTableViewCell *cell = (HabitTableViewCell*) self.view;
    Habit *habit = cell.habit;
    
    // observe self.view(cell view).habit
    if([keyPath isEqualToString:@"habit"]){
        // FIXME should I remove these observer??
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
        
        cell.textLabel.text = habit.title;
        cell.imageView.image = [UIImage imageNamed:@"start"];
        
        NSDate *nowDate = [NSDate date];
        if([habit.nextDoTime timeIntervalSinceDate:nowDate] > 0) {
            NSDate *lastActionTime = habit.lastActionTime;
            self.timeLineView.progressRatio = [nowDate timeIntervalSinceDate:lastActionTime] / [habit.nextDoTime timeIntervalSinceDate:lastActionTime];
        }
        else{
            self.timeLineView.progressRatio = 1.0;
        }
        
    }
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
    } completion:nil];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    UIView *cellContentView = ((UITableViewCell*)(self.view)).contentView;
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cellContentView.frame = CGRectMake(0,
                                            cellContentView.frame.origin.y,
                                            cellContentView.frame.size.width,
                                            cellContentView.frame.size.height);
    } completion:nil];
}

-(void)dealloc {
    [self.view removeObserver:self forKeyPath:@"habit"];
}

@end
