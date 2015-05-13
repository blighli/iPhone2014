//
//  TextNote.h
//  MyNotes
//
//  Created by alwaysking on 14/11/23.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TextNote : NSManagedObject

@property (nonatomic, retain) NSString * textItem;

@end
