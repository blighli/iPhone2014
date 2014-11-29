//
//  HandDrawnDataSource.h
//  Mynotes
//
//  Created by xiaoo_gan on 11/28/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HandDrawnData;

@interface HandDrawnDataSource : NSObject

+ (id) sharedInstance;

- (NSInteger) noteCount;
- (HandDrawnData *) getNoteAtIndex:(NSInteger) index;
- (void) addNote:(HandDrawnData *) note;
- (void) removeNoteAtIndex:(NSInteger) index;

- (void) saveToFilePath:(NSString *) filePath;
- (void) loadFormFilePath:(NSString *) filePath;

@end
