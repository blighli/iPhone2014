//
//  StrCalcMethod.h
//  calc
//
//  Created by zhou on 14/11/5.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StrCalcMethod : NSObject


+ (NSString *)deciMultiply:(NSString *)lstr withString:(NSString * )rstr;
+ (NSString *)deciDivide:(NSString *)lstr withString:(NSString   * )rstr;
+ (NSString *)deciPlus:(NSString *)lstr withString:(NSString     * )rstr;
+ (NSString *)deciMinus:(NSString *)lstr withString:(NSString    * )rstr;
@end
