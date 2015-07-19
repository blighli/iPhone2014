//
//  Datas.h
//  Mynotes
//
//  Created by lixu on 14/11/15.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Datas : NSObject
{
    int ID;
    int Type;
    NSString *Note;
    NSString *Time;
    
}

@property (nonatomic) int ID;
@property (nonatomic) int Type;
@property (strong ,nonatomic) NSString *Note;
@property (strong ,nonatomic) NSString* Time;
@property (strong,nonatomic) NSString* Name;

@end
