#import "MaterialDetailCell.h"

@implementation MaterialDetailCell

@synthesize lblDCode,lblDName,lblDSize,lblDUnit;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc
{
    self.lblDName = nil;
    self.lblDCode = nil;
    self.lblDSize = nil;
    self.lblDUnit = nil;
    [super dealloc];
}

@end
