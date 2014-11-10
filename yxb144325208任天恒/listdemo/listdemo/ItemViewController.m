//
//  ItemViewController.m
//  listdemo
//
//  Created by rth on 14/11/9.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "ItemViewController.h"
#import "ListItem.h"

@interface ItemViewController ()

@end

@implementation ItemViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.itemToEdit != nil){
        self.title = @"Edit";
        self.textfield.text = self.itemToEdit.text;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self.delegate ItemViewControllerDidCancel:self];
}



- (IBAction)Done:(id)sender {
    if(self.itemToEdit == nil){// add元素
        ListItem *item = [[ListItem alloc]init];
        item.text = self.textfield.text;
        item.checked = NO;
        
        [self.delegate ItemViewController:self didFinishAddingItem:item];
    }else{ //edit
        
        self.itemToEdit.text = self.textfield.text;
        [self.delegate ItemViewcontroller:self didFinishEditingItem:self.itemToEdit];
        
    }
}

- (IBAction)Cancel:(id)sender {
    [self.delegate ItemViewControllerDidCancel:self];
   
}
@end
