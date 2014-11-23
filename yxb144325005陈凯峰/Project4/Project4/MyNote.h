//
//  MyNote.h
//  Project4
//
//  Created by jingcheng407 on 14-11-23.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyNote : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * time;

@end
