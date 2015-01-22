//
//  ENTabBarControll.m
//  EverNote
//
//  Created by 顾准新 on 14-12-6.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import "ENTabBarControll.h"
@interface ENTabBarControll()
//@property (strong,nonatomic) EnNoteVewController *enNote;
//@property (strong,nonatomic) ENPhotoViewController *enPhoto;
//@property (strong,nonatomic) ENDrawViewController *enDraw;
@end

@implementation ENTabBarControll

//-(EnNoteVewController *)enNote{
//    if(!_enNote)
//        _enNote = [[EnNoteVewController alloc] init];
//    return _enNote;
//}
//
//-(ENPhotoViewController *)enPhoto{
//    if(_enPhoto)
//        _enPhoto = [[ENPhotoViewController alloc] init];
//    return _enPhoto;
//}
//
//-(ENDrawViewController *)enDraw{
//    if(!_enDraw)
//        _enDraw = [[ENDrawViewController alloc] init];
//    return _enDraw;
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //NSLog(@"%@",self.note.noteTitle);
    for (id vc in self.viewControllers) {
        if([vc isKindOfClass:[EnNoteVewController class]]){
            [(EnNoteVewController *)vc noteTitle].text = self.note.noteTitle;
            [(EnNoteVewController *)vc noteContents].text = self.note.noteContents;
        }else if([vc isKindOfClass:[ENPhotoViewController class]]){
            
        }else{
            
        }
    }
    
}


//-(instancetype)init{
//    NSLog(@"2");
//    self = [super init];
//    if(self){
//        _enNote = [[EnNoteVewController alloc] init];
//        _enPhoto = [[ENPhotoViewController alloc] init];
//        _enDraw = [[ENDrawViewController alloc] init];
//        self.viewControllers = @[_enNote,_enPhoto,_enDraw];
//    }
//    return  self;
//}

//-(instancetype)

//-(void)loadView{
//    
//    self.viewControllers = @[_enNote,_enPhoto,_enDraw];
//}


@end
