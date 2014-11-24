//
//  DBUtilis.h
//  MyNotes
//
//  Created by tanglie on 14/11/23.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBUtilis : NSObject


- (void)insertText:(NSString *)text OrImage:(NSData *)imageData WithTitle:(NSString *)title ofType:(NSString *)type;

- (void)deleteWithTitle:(NSString *)title;

- (NSMutableArray *)selectDataFromDB;
@end
