#import "MaterialCell.h"

@implementation MaterialCell

@synthesize lblMName;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc
{
    self.lblMName = nil;
    [super dealloc];
}

@end
