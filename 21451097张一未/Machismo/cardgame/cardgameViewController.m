//
//  cardgameViewController.m
//  cardgame
//
//  Created by emily on 14-11-13.
//  Copyright (c) 2014年 com.emily. All rights reserved.
//

#import "cardgameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "historyViewController.h"

int flagcard=0;


@interface cardgameViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *change;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;
@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UIButton *deal;
@property (nonatomic,copy) NSString* oldhistory;
@property (nonatomic,copy) NSString* history;

@end

@implementation cardgameViewController
- (IBAction)change:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    int index = (int)seg.selectedSegmentIndex;
    switch (index) {
            
        case 0:
            flagcard = 0;
            self.game=nil;
            [self updateUI];
            break;
        case 1:
            flagcard = 1;
            self.game=nil;
            [self updateUI];
            break;
        default:
            break;
    }
}
- (IBAction)ddd:(id)sender {
    if (_oldhistory==NULL)
    {
        _history = [NSString stringWithFormat:@"本局最终得分为：%ld\n",(long)_game.score];
        _oldhistory = _history;
    }
    else
    {
        _oldhistory = _history;
        _history = [NSString stringWithFormat:@"%@\n 本局最终得分为：%ld\n",_oldhistory,(long)_game.score];
        
    }
    self.game=nil;
    [self updateUI];
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}
- (IBAction)touchCardButton:(UIButton *)sender
{
    unsigned long chosenBUttonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenBUttonIndex];
    [self updateUI];
    self.flipCount++;
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


- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        unsigned long cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:  UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" :@"cardback" ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
