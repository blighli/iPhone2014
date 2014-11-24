//
//  ChakanShouxie.m
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-22.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChakanShouxie.h"
#import "ShouxieImage.h"
#import "OnePiece.h"
#import "MySqlite3DbHelper.h"
#import "Constants.h"

@implementation ChakanShouxie

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _currentColor = [UIColor redColor];
    
    //如果whopastit是1，即新建
    if ([Constants getWhoPastit] == 1) {
        _imageView.hidden =YES;
        _deleButton.hidden =YES;
    }
    //查看
    else
    {
        _cleaButton.hidden=YES;
        _saveButton.hidden=YES;
        _undoButton.hidden=YES;
        //显示图片
        NSString *aPath3=[NSString stringWithFormat:@"%@",[Constants getPastOnePiece].info];
        NSLog(@"FULLNAME:%@",aPath3);
        UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
        [_imageView setImage:imgFromUrl3];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [ShouxieImage cleanAllLine ];
}

//手指开始触屏开始
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch=[touches anyObject];
    MyBeganpoint=[touch locationInView:self.view ];
    
    [(ShouxieImage*)self.view Introductionpoint1];
    [(ShouxieImage*)self.view Introductionpoint3:MyBeganpoint];
    [self.view setNeedsDisplay];
}
//手指移动时候发出
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray* MovePointArray=[touches allObjects];
    MyMovepoint=[[MovePointArray objectAtIndex:0] locationInView:self.view];
    [(ShouxieImage*)self.view Introductionpoint3:MyMovepoint];
    [self.view setNeedsDisplay];
}
//当手指离开屏幕时候
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [(ShouxieImage*)self.view Introductionpoint2];
    [self.view setNeedsDisplay];
}

-(IBAction)deleteForever
{
    //从沙盒中删除图片
    NSFileManager* fileManager=[NSFileManager defaultManager];
    //文件名
    NSString *uniquePath=[Constants getPastOnePiece].info;
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        NSLog(@"no  have");
    }else {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            NSLog(@"dele success");
            
            
        }else {
            NSLog(@"dele fail");
        }
        
    }
    
    //从数据库中删除图片
    NSString *deleteSql = [NSString stringWithFormat:@"delete from contents where id=\"%d\"",[Constants getPastOnePiece].iD];
    BOOL res = [MySqlite3DbHelper execSql:deleteSql database:@"XiaoBenZi_1087.db"];
    if( NO == res )
    {
        NSLog(@"fail!");
    }
    else
    {
        NSLog(@"succeed!");
    }

    
    }

-(IBAction)myPalttealllineclear
{
    [(ShouxieImage*)self.view myalllineclear];
}
//
-(IBAction)LineFinallyRemove
{
    [(ShouxieImage*)self.view myLineFinallyRemove];
}
-(IBAction)captureScreen
{
    _titleField.hidden=YES;
    _saveButton.hidden=YES;
    _undoButton.hidden=YES;
    _cleaButton.hidden=YES;
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //保存内容到数据库
    //设置要插入的内容
    OnePiece * piece = [[OnePiece alloc] init];
    [piece setValue:[_titleField text] forKey:@"title"];
    [piece setValue:@"2" forKey:@"type"];
    [piece setValue:@"temp" forKey:@"info"];
    
    
        NSString *insertSql = [NSString stringWithFormat:@"insert into contents(title,type,info) values(\"%@\",\"%@\",\"%@\")",[piece valueForKey:@"title"],[piece valueForKey:@"type"],[piece valueForKey:@"info"]];
        BOOL res = [MySqlite3DbHelper execSql:insertSql database:@"XiaoBenZi_1087.db"];
        if( NO == res )
        {
            NSLog(@"fail!");
        }
        else
        {
            NSLog(@"succeed!");
            //获取last_insert_id()，修改数据库中info
            NSInteger last = [MySqlite3DbHelper queryOneNSIntegerSql:@"select max(id) from contents" database:@"XiaoBenZi_1087.db"];
            NSString *name = [NSString stringWithFormat:@"%d_shouxie.png",last];
            NSString *fullPath = [MySqlite3DbHelper dbPathforDbName:name];
            NSString *updateSql = [NSString stringWithFormat:@"update contents set info =\"%@\" where id = \"%d\" ",fullPath,last];
            BOOL res = [MySqlite3DbHelper execSql:updateSql database:@"XiaoBenZi_1087.db"];
            if( NO == res )
            {
                NSLog(@"fail!");
            }
            else
            {
                //update成功则保存图片
                [UIImagePNGRepresentation(image) writeToFile:fullPath atomically:NO];
            }

    //保存文件到沙盒sandbox，命名规则：id_shouxie.png
        }
    _titleField.hidden=NO;
    _saveButton.hidden=NO;
    _undoButton.hidden=NO;
    _cleaButton.hidden=NO;
    
}


@end