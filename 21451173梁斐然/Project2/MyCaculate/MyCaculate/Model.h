//
//  Model.h
//  MyCaculate
//
//  Created by LFR on 14/11/7.
//  Copyright (c) 2014年 LFR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+stack.h"


@interface Model : NSObject

@property (nonatomic,strong) NSMutableString* currentNum;
@property (nonatomic,strong) NSMutableString* memoryNum;
@property (nonatomic,strong) NSMutableArray* operationArray;
@property (nonatomic,strong) NSMutableArray* numberArray;
@property (nonatomic,assign) BOOL isMemoryed;

- (void)updateCurrentNum:(NSString*)newNum;
- (void)storeCurrentNum;
- (void)clearCurrentNum;
- (void)changeOperator;
- (void)deleteNum;
- (void)caculateWithOperation:(NSString*)operation;
- (void)leftBracket;
- (void)rightBracket;
- (void)equal;
- (void)percentage;
- (void)MClean;
- (void)MAdd;
- (void)MMinus;

@end
