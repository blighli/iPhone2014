//
//  User.h
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/2.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject{
    NSString *_token;
    NSString *_UID;
    
}
@property (strong,nonatomic) NSString *token;
@property (strong,nonatomic) NSString *UID;
@end
