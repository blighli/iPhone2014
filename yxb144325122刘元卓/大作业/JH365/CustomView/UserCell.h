#import <UIKit/UIKit.h>

@interface UserCell : UITableViewCell

@property (nonatomic,retain) IBOutlet UILabel *lblcompanyCode;
@property (nonatomic,retain) IBOutlet UILabel *lblregionID;
@property (nonatomic,retain) IBOutlet UILabel *lblregionName;
@property (nonatomic,retain) IBOutlet UILabel *lblcustomCode;
@property (nonatomic,retain) IBOutlet UILabel *lblcustomName;
@property (nonatomic,retain) IBOutlet UILabel *lblhomeAddress;
@property (nonatomic,retain) IBOutlet UILabel *lblhomePhone;
@property (nonatomic,retain) IBOutlet UILabel *lblworkPhone;
@property (nonatomic,retain) IBOutlet UILabel *lblfaxNumber;
@property (nonatomic,retain) IBOutlet UILabel *lblmobilePhone;
@property (nonatomic,retain) IBOutlet UILabel *lblinsuranceTypeName;
@property (nonatomic,retain) IBOutlet UILabel *lblinsuranceNumber;
@property (nonatomic,retain) IBOutlet UILabel *lblbeginTime;
@property (nonatomic,retain) IBOutlet UILabel *lblkeepTime;
@property (nonatomic,retain) IBOutlet UILabel *lblendTime;

@end
