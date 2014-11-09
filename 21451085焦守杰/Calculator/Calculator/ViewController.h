//
//  ViewController.h
//  Calculator
//
//  Created by 焦守杰 on 14/11/4.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    double preNum;     //第一个数字
    double num;       //当前数字
    double showNum;   //显示在屏幕上的数字
    bool isContinueOper;  //是否是按完等号连续运算
    bool canCalculate;   //是否可以运算
    double result;   //运算结果
    int t;      //小数的位数
    int r;      //为10或者0.1
    bool dot;  //是否按了小数点
    bool add;   //+
    bool minus;  //-
    bool multiply;  //*
    bool divide;    //  /
    bool mod;     //  %
    bool pressOper;   //是否按了运算符
    double MR;     //MR存数
    bool pressMR;  //是否按了MR
    bool isFirst;  //是不是第一次给preNum赋值
    
}

@end

