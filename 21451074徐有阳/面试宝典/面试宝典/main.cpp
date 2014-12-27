//
//  main.cpp
//  面试宝典
//
//  Created by xuyouyang on 14/12/27.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#include <iostream>

int main(int argc, const char * argv[]) {
    // insert code here...
    int arr[] = {6, 7, 8, 9, 10};
    int *ptr = arr;
    *(ptr++) += 123;
    printf("%d, %d\n", *ptr, *(++ptr));
    return 0;
}
