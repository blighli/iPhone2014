//
//  BBTVListModel.h
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/5.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBTVListModel : NSObject

/**
 *  电视台UUID
 */
@property NSString *tvID;
/**
 *  电视台名称
 */
@property NSString *tvName;
/**
 *  电视台Logo图片地址
 */
@property NSString *logo;
/**
 *  电视节目源
 */
@property NSArray *source;

@end
