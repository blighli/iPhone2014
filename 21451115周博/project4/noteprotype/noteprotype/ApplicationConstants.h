//
//  ApplicationConstants.h
//  noteprotype
//
//  Created by zhou on 14/11/23.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

// indentifier for prototype cells
extern NSString *const kMyNoteListCell;
extern NSString *const kImageAndRecordListCell;

// manageredObject entity name
extern NSString *const kNote;
extern NSString *const kPaint;
extern NSString *const kPhoto;
extern NSString *const kRecord;

// manageredObject entity id
extern NSString *const kNoteIdKey;
extern NSString *const kPaintIdKey;
extern NSString *const kPhotoIdKey;
extern NSString *const kRecordIdKey;

// indentifier for segue
extern NSString *const kDetailToPhotoSegue;
extern NSString *const kDetailToPaintSegue;
extern NSString *const kMultiMediaTableInitSegue ;
extern NSString *const kNoteListToDetailSegue ;