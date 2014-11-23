//
//  Note.h
//  project4
//
//  Created by xuyouyang on 14/11/23.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject
@property (nonatomic, strong)NSString *noteId;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *imagePath;
@property (nonatomic, strong)NSString *type;
+ (NSMutableArray *)getAllNotes;
+ (BOOL)addNoteWithTitle:(NSString *)title Content:(NSString *)content ImagePath:(NSString *)imagePath Type:(NSString *)type;
@end
