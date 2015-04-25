#import "SetViewController.h"
#import "LoginViewController.h"

@implementation SetViewController
@synthesize imageView;
@synthesize delegate,backgroundImage,contentImage,Jkdelegate,buttonArrays;
-(id)initWithImage:(UIImage *)image contentImage:(UIImage *)content
{
    if(self == [super init])
    {
        self.backgroundImage = image;
        self.contentImage = content;
        buttonArrays = [NSMutableArray arrayWithCapacity:4];
    }
    return self;
}
-(void) addButtonWithUIbutton:(UIButton *)btn
{
    [buttonArrays addObject:btn];
}
-(void)drawRect:(CGRect)rect
{
    CGSize imageSize = self.backgroundImage.size;
    [self.backgroundImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
}
-(IBAction)ButtonClivk:(id)sender
{
    if(imagePicker == nil)
    {
        imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
    }
    [self presentModalViewController:imagePicker animated:YES];
}

//委托方法

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSURL *videoURL = [info valueForKey:UIImagePickerControllerMediaMetadata];
    NSString *videoPath = [videoURL path];
    NSLog(@"%@",videoPath);
    string3 = videoPath;
    NSLog(@"%@",string3);
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [imageView.image release];
    [image retain];
    imageView.image = image;
    NSURL *url = [editingInfo valueForKey:UIImagePickerControllerMediaURL];
    string3 = [url path];
    NSLog(@"%@",string3);
    [imagePicker dismissModalViewControllerAnimated:YES];
}
-(void)dealloc
{
    if(imageView !=nil)
    {
        [imageView.image release];
        [imageView release];
        imageView = nil;
    }
    [imagePicker release],imagePicker = nil;
    [super dealloc];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [userName resignFirstResponder];
    [passWord resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    userName.text = [defaults objectForKey:Username];
    passWord.text = [defaults objectForKey:Pasword];
    imageView.image= [UIImage imageNamed:[defaults objectForKey:Image]];
}
-(IBAction)SaveButtonClick:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"设置" message:@"" delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"保存", nil];
    [alert show];
    [alert release];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
        
        [self viewWillAppear:YES];
    else
    {
        [self viewDidLoad];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *string1 = userName.text;
    NSString *string2 = passWord.text;
    //    UIImage *imager = imageView.image;
    [defaults setObject:string1 forKey:Username];
    [defaults setObject:string2 forKey:Pasword];
    [defaults setObject:string3 forKey:Image];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
