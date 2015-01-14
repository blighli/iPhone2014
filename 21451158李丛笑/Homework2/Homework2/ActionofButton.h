//
//  ActionofButton.h
//  Homework2
//
//  Created by 李丛笑 on 14/11/11.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#ifndef Test_ActionofButton_h
#define Test_ActionofButton_h
@interface ActionofButton : NSObject

-(NSMutableString *) ActtoNum: (NSString *)num Text:(NSMutableString *)textstr Num:(NSMutableString *)numstr Is:(NSMutableString *)ifresult;

-(NSMutableString *) ActtoSym: (NSString *)sym Text:(NSMutableString *)textstr Num:(NSMutableString *)numstr Is:(NSMutableString *)ifresult;

@end

#endif
