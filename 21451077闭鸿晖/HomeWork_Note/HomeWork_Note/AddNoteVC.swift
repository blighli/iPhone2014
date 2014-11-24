
import UIKit
import CoreData
class AddNoteVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    lazy var images:[UIImage]=[]
    var isNewNote=true
    var note:Note?
    
    override func viewWillAppear(animated: Bool) {

        //注册键盘弹出和消失通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardShow:", name: UIKeyboardDidShowNotification, object: nil)
        
        //注册键盘弹出通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardHide:", name: UIKeyboardWillHideNotification, object: nil)
        
       

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        update()
        imageScrollView.layer.borderColor=UIColor.lightGrayColor().CGColor
        imageScrollView.layer.borderWidth=0.3
        contentTextView.layer.borderColor=UIColor.lightGrayColor().CGColor
        contentTextView.layer.borderWidth=0.3
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     var doneButton:UIButton?
    //view跳转后移除通知避免在别的view中出现自定义键盘
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //更新UI和图片数组
    func update(){
        //编辑
        if !isNewNote {
            titleTextField.text=note?.title
            contentTextView.text=note?.content
             images = NSKeyedUnarchiver.unarchiveObjectWithData((note?.photos)!) as [UIImage]
            var x:CGFloat=0
            var contentWidth:CGFloat=0
            for image in images{
                var imageView=UIImageView(image: image)
                imageView.frame=CGRect(x: x, y: 0, width: imageScrollView.bounds.height, height: imageScrollView.bounds.height)
                imageScrollView.addSubview(imageView)
                x+=imageScrollView.bounds.height
                contentWidth+=imageScrollView.bounds.height
            }
            
            imageScrollView.contentSize=CGSize(width: contentWidth, height: imageScrollView.bounds.height)
            navigationItem.title="修改笔记"
            navigationItem.rightBarButtonItem?.title="修改"

        }else{
            navigationItem.title="新建笔记"
            navigationItem.rightBarButtonItem?.title="新建"
        }
        
            /*
            //新建
        else{
            titleTextField.text=nil
            contentTextView.text=nil
            for view in imageScrollView.subviews{
                view.removeFromSuperview()
            }

        }
        */
    }


    
    //MARK: - 键盘处理
    //点击背景view
    @IBAction func tapBack(sender: AnyObject) {
        
        titleTextField.resignFirstResponder()
        contentTextView.resignFirstResponder()
    }
    
    //点击键盘上的按钮
    func doneKeyboard(sender:AnyObject?){
        titleTextField.resignFirstResponder()
        contentTextView.resignFirstResponder()
    }
    
    func keyBoardShow(notification:NSNotification) {

        var info = notification.userInfo! as Dictionary
        var keyboardValue = info[UIKeyboardFrameBeginUserInfoKey] as NSValue
        var keyboardWidth=keyboardValue.CGRectValue().size.width
        var keyboardHeight=keyboardValue.CGRectValue().size.height
        var window=self.view.window
        var x=keyboardWidth-50
        var y=self.view.window!.bounds.height-keyboardHeight-25//注意这个!隐式拆包
        //自定义完成按钮
        doneButton=UIButton.buttonWithType(UIButtonType.System) as? UIButton
        doneButton!.backgroundColor=UIColor.lightGrayColor()
        doneButton!.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        doneButton!.setTitle("完成", forState:UIControlState.Normal)
        
        doneButton!.addTarget(self, action:"doneKeyboard:", forControlEvents: UIControlEvents.TouchUpInside)
        doneButton!.frame=CGRect(x:x , y: y, width: 50, height: 25)
        window?.addSubview(doneButton!)

    }
    
    func keyBoardHide(notification:NSNotification) {
        doneButton!.removeFromSuperview()
    
    }

    @IBAction func titleTextFieldDidEnd(sender: UITextField) {
        titleTextField.resignFirstResponder()
    }

    //MARK: - 添加图片
    ///选择添加照片或手绘
    @IBAction func choosePhotoType(sender: AnyObject) {
        
        var sheet=UIAlertController(title: "添加图片", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        var cameraAction=UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default) {action -> Void in
            
            var imagePicker=UIImagePickerController()
            imagePicker.delegate=self
            imagePicker.allowsEditing=true
            imagePicker.sourceType=UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }
        
        var drawAction=UIAlertAction(title: "手绘", style: UIAlertActionStyle.Default) {action -> Void in self.performSegueWithIdentifier("DrawVC", sender: self)
        }
        var cancelAction=UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
            
        sheet.addAction(cameraAction)
        sheet.addAction(drawAction)
        sheet.addAction(cancelAction)
        self.presentViewController(sheet, animated: true, completion: nil)
        
    }
    
    func addImage(#image:UIImage){
        images.append(image)
        var imageView=UIImageView(image: image)
        var imageWidth=self.imageScrollView.bounds.height
        imageView.frame=CGRectMake(imageScrollView.contentSize.width, 0, imageWidth,imageWidth )
        imageScrollView.addSubview(imageView)
        imageScrollView.contentSize.width+=imageWidth
        //内容宽度大于scrollView宽度时执行滚动到最右边动画
        if imageScrollView.contentSize.width>imageScrollView.bounds.width{
            imageScrollView.setContentOffset(CGPoint(x:imageScrollView.contentSize.width-imageScrollView.bounds.width,y:0), animated: true)
        }

    }
    
    
    ///拍照后回调,将照片添加的scrollview中
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        picker.dismissViewControllerAnimated(true) {
            var image = info["UIImagePickerControllerOriginalImage"] as UIImage
            self.addImage(image: image)
        }
    }
    
    // MARK: - 先建或修改笔记
    @IBAction func saveOrModifyNote(sender: AnyObject) {
        if titleTextField.text.isEmpty{
            return
        }
               var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        //如果是新建note
        if isNewNote{
            //插入新的note
            var newNote = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext:context) as Note
            
            newNote.title=titleTextField.text
            newNote.content=contentTextView.text
            newNote.photos=NSKeyedArchiver.archivedDataWithRootObject(images)
            
         //修改原有note
        }else{
            note?.title=titleTextField.text
            note?.content=contentTextView.text
            note?.photos=NSKeyedArchiver.archivedDataWithRootObject(images)

        }
        context.save(nil)
        
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="DrawVC"&&segue.destinationViewController is DrawVC){
            (segue.destinationViewController as DrawVC).delegate=self
        }
    }


}
