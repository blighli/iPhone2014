//
//  CreateViewController.h
//  MyNotes
//
//  Created by liug on 14-11-15.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
@interface CreateViewController : UIViewController
{
    sqlite3 *db;

}
@property(nonatomic,weak)IBOutlet  UITextView *notes;
@property(nonatomic,weak)IBOutlet UITextView *notetitle;
-(NSString *)filepath;
-(void) openDB;
-(void) createTableNamed:(NSString *)tablename
              withField1:(NSString *)field1
              withField2:(NSString *)field2;
-(void) insertRecordIntoTableNamed:(NSString *)tableName
                        withField1:(NSString *)field1
                       field1Value:(NSString *)field1Value
                         andField2:(NSString *)field2
                       field2Value:(NSString *)field2Value;
-(void)getAllRowsFromTable:(NSString *)tableName and:(NSMutableArray *)nsta second:(NSMutableArray *) seco;
-(void) deleteRecordfromTableNamed:(NSString *)tableName
                        withField1:(NSString *)field1
                       field1Value:(NSString *)field1Value;
-(void) createDrawTableNamed:(NSString *)tablename
                  withField1:(NSString *)path;
-(void) insertDrawIntoTableNamed:(NSString *)tableName
                      withField1:(NSString *)field1
                     field1Value:(NSString *)field1Value;
-(void)getAllRowsFromDraw:(NSString *)tableName and:(NSMutableArray *)nsta;
-(void) deleteDrawfromTableNamed:(NSString *)tableName
                      withField1:(NSString *)field1
                     field1Value:(NSString *)field1Value;

@end
