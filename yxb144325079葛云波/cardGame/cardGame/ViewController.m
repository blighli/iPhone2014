//
//  ViewController.m
//  cardGame
//
//  Created by 葛 云波 on 14/11/29.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) CardMatchingGame *game;
@property (nonatomic) NSInteger matchCount;
@end

@implementation ViewController

- (IBAction)touchRestartButton:(UIButton *)sender {
    self.game = nil;
    self.game = [self game];
    [self updateUI];
}

-(CardMatchingGame *)game{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self creatDeck]];
    }
    return _game;
}


-(Deck *)creatDeck{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex withMatchCount:self.matchCount];
    [self updateUI];

}

-(void)updateUI{
    for(UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score:%ld",(long)self.game.score];
        
    }
}
-(NSString *)titleForCard:(Card *)card{
    return card.isChosen ? card.contents :@"";
}
-(UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
