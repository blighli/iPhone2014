//
//  ApplicationConstants.m
//  noteprotype
//
//  Created by zhou on 14/11/23.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "ApplicationConstants.h"

// indentifier for prototype cells
NSString *const kMyNoteListCell         = @"MyNoteListCell";
NSString *const kImageAndRecordListCell = @"ImageAndRecordListCell";

// manageredObject entity name
NSString *const kNote   = @"Note";
NSString *const kPaint  = @"Paint";
NSString *const kPhoto  = @"Photo";
NSString *const kRecord = @"Record";

// manageredObject entity id
NSString *const kNoteIdKey   = @"note_id";
NSString *const kPaintIdKey  = @"paint_id";
NSString *const kPhotoIdKey  = @"photo_id";
NSString *const kRecordIdKey = @"record_id";

// indentifier for segue
NSString *const kDetailToPhotoSegue = @"DetailToPhoto";
NSString *const kDetailToPaintSegue = @"DetailToPaint";
NSString *const kMultiMediaTableInitSegue = @"AudioListTable";
NSString *const kNoteListToDetailSegue = @"showDetail";
