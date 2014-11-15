//
//  sqlite3DB.h
//  Project3
//
//  Created by jingcheng407 on 14-11-15.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface sqlite3DB : NSObject{
     sqlite3 *db;
}
-(NSString *)filePath;
@end
