#import "TaskDetailCell.h"

@implementation TaskDetailCell

@synthesize lblRC,lblCK,lblcompanyN,lblcustomN,lblDN,lblDMTN,lblDSTN,lblphoneNum,lblRealName,lbladdress,lblcreateTime,lblcreateUserName,lblcallTime,lblproblemDesc,lblrepairState,lblifAssigned,lblassignTechCode,lblassignTechName,lblassignTime,lblifMoneyRepair,lblmoneyRepair,lblrepairBackMsg,lblneedMaterial,lblifCallBack,lblcustomFeelLevel,lblcustomBackMsg,lblifDelete;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc
{
    self.lblRC = nil;
    self.lblCK = nil;
    self.lblcompanyN = nil;
    self.lblcustomN = nil;
    self.lblDN = nil;
    self.lblDMTN = nil;
    self.lblDSTN = nil;
    self.lblphoneNum = nil;
    self.lblRealName = nil;
    self.lbladdress = nil;
    self.lblcreateTime = nil;
    self.lblcreateUserName = nil;
    self.lblcallTime = nil;
    self.lblproblemDesc = nil;
    self.lblrepairState = nil;
    self.lblifAssigned = nil;
    self.lblassignTechCode = nil;
    self.lblassignTechName = nil;
    self.lblassignTime = nil;
    self.lblifMoneyRepair = nil;
    self.lblmoneyRepair = nil;
    self.lblrepairBackMsg = nil;
    self.lblneedMaterial = nil;
    self.lblifCallBack = nil;
    self.lblcustomFeelLevel = nil;
    self.lblcustomBackMsg = nil;
    self.lblifDelete = nil;
    [super dealloc];
}


@end
