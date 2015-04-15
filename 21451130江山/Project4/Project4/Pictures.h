//
//  Pictures.h
//  Project4
//
//  Created by 江山 on 1/7/15.
//  Copyright (c) 2015 jiangshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note;

@interface Pictures : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) Note *belongto;

@end
