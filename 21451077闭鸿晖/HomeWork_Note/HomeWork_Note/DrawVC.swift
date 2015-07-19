
import UIKit

class DrawVC: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var drawView: UIView!
    var delegate:AddNoteVC!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden=false
        navigationItem.title="手绘图片"
        tabBarController?.tabBar.hidden=true
        (drawView as DrawView).color=segmentedControl.selectedSegmentIndex
    }
    
    //恢复显示tabBar不能在viewDidDisappear中实现
    override func viewWillDisappear(animated: Bool) {
        tabBarController?.tabBar.hidden=false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.layer.borderWidth=0.3
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseColor(sender: UISegmentedControl) {
        
        (drawView as DrawView).color=segmentedControl.selectedSegmentIndex
    }

    //绘图完成
    @IBAction func done(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
        //截取画板
        UIGraphicsBeginImageContext(drawView.bounds.size);
        drawView.layer.renderInContext(UIGraphicsGetCurrentContext())
        var image=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.delegate.addImage(image:image)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
