#import "MainScene.h"

@implementation MainScene
-(void)pause_click
{
    NSLog(@"pause click");
}
-(void)play
{
    NSLog(@"play click");
    CCScene *scene = [CCBReader loadAsScene:@"PlayGame"];
    [[CCDirector sharedDirector] replaceScene:scene];
}
@end
