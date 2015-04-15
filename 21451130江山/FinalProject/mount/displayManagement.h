//
//  displayManagement.h
//  mount
//
//  Created by 江山 on 1/3/15.
//  Copyright (c) 2015 jiangshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "billManagement.h"
@interface displayManagement : NSObject
@property(nonatomic,strong)billManagement*billM;
//按月份显示饼图
-(NSMutableArray*)XYPieChart:(int)Month;
//用类型为参数，返回以参数为key的字典
-(NSMutableDictionary*)getClassPayout:(NSString*)TypeOrPersonnel Month:(int)theMonth;//YES
//查询所有类别
-(NSArray*)selectType;
//查询预算
-(NSNumber*)selectBudget;//YES
//根据类别查询子类别
-(NSArray*)selectSubType:(NSString*)Type;
@end
