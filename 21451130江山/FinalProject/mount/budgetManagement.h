//
//  budgetManagement.h
//  mount
//
//  Created by 江山 on 1/3/15.
//  Copyright (c) 2015 jiangshan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface budgetManagement : NSObject

//给一个预算数，插入预算数据
-(BOOL)insertIntoBudgetTable:(NSString*)BudgetData;
//返回总支出金额
-(NSNumber*)backPayAmount;
@end
