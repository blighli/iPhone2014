//
//  secondgameViewController.m
//  cardgame
//
//  Created by emily on 14-11-7.
//  Copyright (c) 2014年 com.emily. All rights reserved.
//

#import "secondgameViewController.h"
#import "Cardplayer.h"
#import "historyViewController.h"


@interface secondgameViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *playerchoose;
@property (weak, nonatomic) IBOutlet UILabel *gamelog;
@property (weak, nonatomic) IBOutlet UILabel *gameresult;
@property (weak, nonatomic) IBOutlet UILabel *playerscore;
@property (weak, nonatomic) IBOutlet UILabel *computerscore;
@property (weak, nonatomic) IBOutlet UIButton *palyerchoice;
@property (weak, nonatomic) IBOutlet UIButton *computerchoice;
@property (strong,nonatomic) Cardplayer* player;
@property (strong,nonatomic) Cardplayer* computer;
@property (nonatomic) int playersc;
@property (nonatomic) int computersc;
@property (nonatomic,copy) NSString* oldhistory;
@property (nonatomic,copy) NSString* history;

@end

@implementation secondgameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static const int CHOOSE_FIRST_SCISSORS = 0;
static const int CHOOSE_SECOND_STONE = 1;
static const int CHOOSE_THIRD_CLOTH = 2;

- (IBAction)palygame:(id)sender {
    
    self.computer = [[Cardplayer alloc]init];
    self.player = [[Cardplayer alloc]init];
    
    [self.computer randromcontents];
    NSString *computercontents = [self.computer contents];
    int index = (int)_playerchoose.selectedSegmentIndex;
    NSString *title = [self.playerchoose titleForSegmentAtIndex:index];
    
    switch (index) {
        case CHOOSE_FIRST_SCISSORS :
            
            [self judgeWin:self.player andName:self.computer];
            [self uodateUI:title andName:computercontents];
            break;
        case CHOOSE_SECOND_STONE :
            [self judgeWin:self.player andName:self.computer];
            [self uodateUI:title andName:computercontents];
            break;
        case CHOOSE_THIRD_CLOTH :
            [self judgeWin:self.player andName:self.computer];
            [self uodateUI:title andName:computercontents];
            break;
            
        default:
            break;
    }
  //  historyViewController *historyvalus = [[historyViewController alloc] initWithNibName:@"historyViewController" bundle:[NSBundle mainBundle]];
   // historyvalus.historyvaluse = [NSString stringWithFormat:@"[%@----- %@]\n",_gamelog.text,_gameresult.text];
  //  [self presentModalViewController:historyvalus animated:YES];
  //  [self presentViewController:historyvalus animated:YES completion:nil];
    if (_oldhistory==NULL)
    {
        _history = [NSString stringWithFormat:@"[%@]-----%@\n",_gamelog.text,_gameresult.text];
        _oldhistory = _history;
    }
    else
    {
        _oldhistory = _history;
        _history = [NSString stringWithFormat:@"%@\n [%@]-----%@\n",_oldhistory,_gamelog.text,_gameresult.text];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
        if ([segue.destinationViewController isKindOfClass:[historyViewController class]])
        {
            historyViewController *vc = (historyViewController *)segue.destinationViewController;
           // vc.historyvaluse = [NSString stringWithFormat:@"[%@-----]%@\n",_gamelog.text,_gameresult.text];
            vc.historyvaluse = _history;
        }
   
}

- (void)uodateUI:(NSString*)title andName:(NSString*)computercontents
{
    self.gamelog.text = [NSString stringWithFormat:@"你选择的是%@，电脑选择的是%@",title,computercontents];
    if ([title isEqualToString:@"✌️"])
    {
        [self.palyerchoice setImage:[UIImage imageNamed:@"剪刀"] forState:UIControlStateNormal];
    }
    else if([title isEqualToString:@"👊"])
    {
        [self.palyerchoice setImage:[UIImage imageNamed:@"石头"] forState:UIControlStateNormal];
    }
    
    else if([title isEqualToString:@"👋"])
    {
        [self.palyerchoice setImage:[UIImage imageNamed:@"布"] forState:UIControlStateNormal];
    }
    
    if([computercontents isEqualToString:@"✌️"])
    {
        [self.computerchoice setImage:[UIImage imageNamed:@"剪刀"] forState:UIControlStateNormal];
    }
    else if ([computercontents isEqualToString:@"👊"])
    {
        [self.computerchoice setImage:[UIImage imageNamed:@"石头"] forState:UIControlStateNormal];
    }
    else if ([computercontents isEqualToString:@"👋"])
    {
        [self.computerchoice setImage:[UIImage imageNamed:@"布"] forState:UIControlStateNormal];
    }
    
}

-(Cardplayer*)judgeGame:(Cardplayer*)player andName:(Cardplayer*)computer
{
    
    
    //[self.computer randromcontents];
    NSString *computercontents = [self.computer contents];
    int index = (int)_playerchoose.selectedSegmentIndex;
    NSString *title = [self.playerchoose titleForSegmentAtIndex:index];
    if (([title isEqualToString:@"✌️"]&&[computercontents isEqualToString:@"✌️"])
        ||([title isEqualToString:@"👊"]&&[computercontents isEqualToString:@"👊"])
        ||([title isEqualToString:@"👋"]&&[computercontents isEqualToString:@"👋"]))
    {
        return NULL;
    }
    else if([title isEqualToString:@"✌️"]&&[computercontents isEqualToString:@"👊"])
    {
        return computer;
    }
    else if([title isEqualToString:@"✌️"]&&[computercontents isEqualToString:@"👋"])
    {
        return player;
    }
    else if([title isEqualToString:@"👊"]&&[computercontents isEqualToString:@"✌️"])
    {
        return player;
    }
    else if([title isEqualToString:@"👊"]&&[computercontents isEqualToString:@"👋"])
    {
        return computer;
    }
    else if([title isEqualToString:@"👋"]&&[computercontents isEqualToString:@"✌️"])
    {
        return computer;
    }
    else
    {
        return player;
    }
}

-(void)judgeWin:(Cardplayer*)player andName:(Cardplayer*)computer
{
    if([[self judgeGame:player andName:computer] isEqual:player])
    {
        self.playersc++;
        self.playerscore.text=[NSString stringWithFormat:@"玩家得分：%d",self.playersc];
        self.gameresult.textColor = [UIColor greenColor];
        self.gameresult.text=@"你赢了";
        ;
    }
    else if([[self judgeGame:player andName:computer] isEqual:computer])
    {
        self.computersc++;
        self.computerscore.text=[NSString stringWithFormat:@"电脑得分：%d",self.computersc];
        self.gameresult.textColor = [UIColor redColor];
        self.gameresult.text=@"你输了";
        
    }
    else
    {
        self.playerscore.text=[NSString stringWithFormat:@"玩家得分：%d",self.playersc];
        self.computerscore.text=[NSString stringWithFormat:@"电脑得分：%d",self.computersc];
        self.gameresult.textColor = [UIColor blueColor];
        self.gameresult.text=@"平局";
    }
}

@end
