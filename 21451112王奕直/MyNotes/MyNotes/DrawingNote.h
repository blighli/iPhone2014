//
//  DrawingNote.h
//  MyNotes
//
//  Created by alwaysking on 14/11/24.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DrawingNote : NSManagedObject


@property (nonatomic, retain) NSString * drawingRoot;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * tagId;

@end
