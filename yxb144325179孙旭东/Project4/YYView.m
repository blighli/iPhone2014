//
//  YYView.m
//  Project3
//
//  Created by  sephiroth on 14/11/23.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import "YYView.h"

@interface YYView ()

@property(nonatomic,strong)NSMutableArray *paths;
@end

@implementation YYView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark-懒加载
-(NSMutableArray *)paths
{
    if (_paths==nil) {
        _paths=[NSMutableArray array];
    }
      return _paths;
    }

//开始手指触摸事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //1.获取手指对应的UItoch对象
    UITouch  *touch=[touches anyObject];
    //2.通过UIToch对象获取手指触摸的位置
    CGPoint starPoint=[touch locationInView:touch.view];

    //3.当用户手指按下的时候创建一条路径
    UIBezierPath *path=[UIBezierPath bezierPath];
    //设置路径的相关属性
    [path setLineWidth:5];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    //4.设置当前路径的起点
    [path moveToPoint:starPoint];
    //5.将路径添加到数组中去
    [self.paths addObject:path];
    }
//手指移动事件
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
   //1.获取手指对应的UIToch对象
    UITouch *touch=[touches anyObject];
    //2.通过UIToch对象获取手指触摸的位置
     CGPoint movePoint=[touch locationInView:touch.view];
     //3.取出当前的path
    UIBezierPath *currentPath=[self.paths lastObject];
   //4.设置当前路径的终点
    [currentPath addLineToPoint:movePoint];
    
    //5.调用drawRect方法重绘视图
     [self setNeedsDisplay];
    }

////抬起手指
//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self touchesMoved:touches withEvent:event];
//}

//画线
- (void)drawRect:(CGRect)rect
{
    //根据路径绘制所有的线段
    for (UIBezierPath *path in self.paths) {
        [path stroke];
        }
    }
/**
      *  清空面板
      */
-(void)clearView
{
  //清空所有的路径
  [self.paths removeAllObjects];
  //调用方法重新绘图
[self setNeedsDisplay];
    }
/**
    96  *  回退操作
    97  */
-(void)backView
{
  //移除路径数组中的最后一个元素（最后一条路径）
   [self.paths removeLastObject];
   //重新绘图
   [self setNeedsDisplay];
}
@end
