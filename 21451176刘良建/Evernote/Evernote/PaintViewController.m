//
//  PaintViewController.m
//  Evernote
//
//  Created by JANESTAR on 14-11-22.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//
#import "AppDelegate.h"
#import "PaintViewController.h"
#import "Paint.h"

@interface PaintViewController (){
    Paint* paint;
    AppDelegate* appDelegate;
    NSManagedObjectContext* appContext;

}

@end

@implementation PaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!self.flag){
    paint=[[Paint alloc]initWithFrame:CGRectMake(0, 0,375,self.view.frame.size.height-44)];
    paint.backgroundColor=[UIColor yellowColor];
       
    }
    else{
        NSString* subloc=[self.pic subloc];
        paint=[[Paint alloc]initWithFrame:CGRectMake(0, 0,375,self.view.frame.size.height-44)];
        paint.backgroundColor=[UIColor yellowColor];
    
         NSString* aPath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),subloc];
        NSArray* test=[NSKeyedUnarchiver unarchiveObjectWithFile:aPath];
        [paint.lineArray  addObjectsFromArray:test];
        NSLog(@"the path is%@",subloc);
        NSLog(@"lineArray is%lu",(unsigned long)[paint.lineArray count]);
        self.flag=NO;
    }
    
    
    [self.view addSubview:paint];
    UIBarButtonItem* button=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem=button;
    
    
    
    // Do any additional setup after loading the view.
}
/*
-(UIImage*)imageWithUIView:(UIView*)view{
   UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currentContext=UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currentContext];
    UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
 
    CGSize s=view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    //UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, view.layer.contentsScale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;




}*/

-(NSString*)dateToNSString:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-hh-mm-ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

-(void)save{

       /*
    NSData* imgData=UIImageJPEGRepresentation(image, 0);
    [imgData writeToFile:aPath atomically:YES];
    NSLog(@"the path is%@",aPath);
    */
    appDelegate=[[UIApplication sharedApplication]delegate];
    appContext=[appDelegate managedObjectContext];
    if(!self.mark){
        
        NSDate * today=[NSDate date];
        NSString* today2=[self dateToNSString:today];
        
        NSString* aPath=[NSString stringWithFormat:@"%@/Documents/%@.pic",NSHomeDirectory(),today2];
        NSString* subPath=[NSString stringWithFormat:@"%@.pic",today2];
        
       BOOL t2= [NSKeyedArchiver archiveRootObject:[paint lineArray] toFile:aPath];
        if(t2){
            printf("归档成功啦222");
        }
       //[[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"lineArray2 is%lu",(unsigned long)[paint.lineArray count]);
        NSLog(@"the path2 is%@",aPath);
     /*
        UIImage* img=[self imageWithUIView:paint];
    [UIImagePNGRepresentation(img) writeToFile:aPath atomically:YES]; */
    NSManagedObject* locinfo=[NSEntityDescription insertNewObjectForEntityForName:@"Picture" inManagedObjectContext:appContext];
   // [locinfo setValue:aPath forKey:@"loc"];
    [locinfo setValue:subPath forKey:@"subloc"];
        NSError* error;
        [appContext save:&error];
        if(error!=nil){
            NSLog(@"%@",error);
            printf("you get wrong\n");
        }
      
    
        
    }else{
        
         NSString* subloc=[self.pic subloc];
         NSString* aPath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),subloc];
        BOOL t1=[NSKeyedArchiver archiveRootObject:[paint lineArray] toFile:aPath];
        if(t1){
            printf("归档成功啦");
        }
        self.mark=NO;
        
    }

    [self.navigationController popViewControllerAnimated:YES ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
