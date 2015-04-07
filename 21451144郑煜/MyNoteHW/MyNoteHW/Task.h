//
//  Task.h
//  TODOListHW
//
//  Created by StarJade on 14-11-10.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FastTextStorage.h"


@interface Task : NSManagedObject{
//	FastTextStorage * _attributedString;
}

@property (nonatomic, retain) NSString * taskName;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSNumber * completed;
//@property (nonatomic, copy) FastTextStorage * attributedString;
@property (nonatomic, retain) NSMutableAttributedString *string;

//- (void)awakeFromInsert;

@end
