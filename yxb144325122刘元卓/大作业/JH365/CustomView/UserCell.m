#import "UserCell.h"

@implementation UserCell

@synthesize lblbeginTime,lblcompanyCode,lblcustomCode,lblcustomName,lblendTime,lblfaxNumber,lblhomeAddress,lblhomePhone,lblinsuranceNumber,lblinsuranceTypeName,lblkeepTime,lblmobilePhone,lblregionID,lblregionName,lblworkPhone;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc
{
    self.lblcompanyCode = nil;
    self.lblregionID = nil;
    self.lblregionName = nil;
    self.lblcustomCode = nil;
    self.lblcustomName = nil;
    self.lblhomeAddress = nil;
    self.lblhomePhone = nil;
    self.lblworkPhone = nil;
    self.lblfaxNumber = nil;
    self.lblmobilePhone = nil;
    self.lblinsuranceTypeName = nil;
    self.lblinsuranceNumber = nil;
    self.lblbeginTime = nil;
    self.lblkeepTime = nil;
    self.lblendTime = nil;
    [super dealloc];
}


@end
