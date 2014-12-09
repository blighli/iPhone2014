//
//  Utils.h
//  justread
//
//  Created by Van on 14/12/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface Utils : NSObject
- (NSMutableArray *) getResult:(NSManagedObjectContext *)managedObjectContext;
@end
