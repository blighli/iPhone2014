//
//  MDBAccess.h
//  Mynotes
//
//  Created by lixu on 14/11/15.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Datas.h"
#define TEXTTYPE 0;
#define IMAGETYPE 1;
#define DRAWTYPE 2;
@interface MDBAccess : NSObject
{
    sqlite3 *db;
}

-(NSMutableArray *) getAllDatas;
-(void) closeDatabase;
-(void) initializeDatabase;
-(void) createTable;
-(void) execSql:(NSString *)sql;
-(void) saveDatas:(NSString *) content Type:(int) type NibName:(NSString*) nibName;
-(void) deleteDatas:(int) id;
@end
