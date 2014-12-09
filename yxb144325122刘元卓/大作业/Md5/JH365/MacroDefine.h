/////////////////////
//     全局定义     //
/////////////////////

#define IfDebug true
#define IfDebugDAL false
#define IfDebugDALView false
#define StatusBarHight 20
#define Rowheight 450
#define MaterRowHeight 96
#define Image @"image"
#define Imager @"00.png"
#define Username @"username"
#define Pasword @"pasword"
#define ImageTow @"imagetow"
#define WcfUrl @"http://192.168.31.220:8005"
//#define WcfUrl @"http://ios.insigmaedu.com/px"

// bug 对于ios6.0.1 必须在项目->target->Summary设置Launch images 才能会生效，否则 高度只会是960,不会是1136
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

