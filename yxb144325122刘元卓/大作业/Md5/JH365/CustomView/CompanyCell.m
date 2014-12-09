#import "CompanyCell.h"

@implementation CompanyCell

@synthesize lblinsuranceNumber,lblkeepTime,lblendTime,lblcompanyCode,lblbeginTime,lbladdress,lblcompanyName,lblcontactName,lblcreateTime,lblcreateUserID,lbldutyServer,lblemail,lblifPerson,lblinsuranceTypeCode,lblpeopleCount,lblphoneNum;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc
{
    self.lblcompanyCode = nil;
    self.lblcompanyName = nil;
    self.lblpeopleCount = nil;
    self.lblbeginTime = nil;
    self.lblkeepTime = nil;
    self.lblendTime = nil;
    self.lblinsuranceTypeCode = nil;
    self.lblinsuranceNumber = nil;
    self.lblcontactName = nil;
    self.lbladdress = nil;
    self.lblphoneNum = nil;
    self.lblemail = nil;
    self.lbldutyServer = nil;
    self.lblcreateUserID = nil;
    self.lblcreateTime = nil;
    self.lblifPerson = nil;
    [super dealloc];
}


@end
