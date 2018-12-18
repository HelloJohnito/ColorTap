//
//  ViewController.m
//  ColorTap
//
//  Created by John  Ito lee on 11/17/18.
//  Copyright © 2018 Johnito. All rights reserved.
//

#import "ViewController.h"

typedef enum{
    RED,
    ORANGE,
    YELLOW,
    GREEN,
    BLUE,
    VIOLET,
} Colors;


@interface ViewController () {
    NSArray *colors;
    NSMutableArray *buttons;
    NSMutableArray *computerPattern;
    int gameLevel;
    int gamePointer;
    BOOL userInputCorrect;
    BOOL gameWon;
}
-(void)setBackgroundColorForButton: (UIButton*)button withColor: (int)colorValue;
-(void)startLevel;
-(void)createPattern;
-(void)showPatternToUser: (NSTimer *)timer;
-(void)userTurn: (NSTimer *)timer;
-(void)nextLevel;
-(void)gameOver;
-(void)setGameSettings;
-(void)toggleColoredButtonsForAbility: (BOOL)enabled;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    colors = @[@(RED), @(ORANGE), @(YELLOW), @(GREEN), @(BLUE), @(VIOLET)];
    
    buttons = [[NSMutableArray alloc] init];
    [buttons addObject: _button1];
    [buttons addObject: _button2];
    [buttons addObject: _button3];
    [buttons addObject: _button4];
    [buttons addObject: _button5];
    [buttons addObject: _button6];
    
    for(int i = 0; i < [buttons count]; i++){
        ((UIButton *)[buttons objectAtIndex:i]).showsTouchWhenHighlighted = YES;
        ((UIButton *)[buttons objectAtIndex:i]).enabled = NO;
        [self setBackgroundColorForButton:[buttons objectAtIndex:i] withColor: [colors[i] intValue]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)startLevel{
    gamePointer = 0;
    gameWon = NO;
    [self createPattern];
    NSMutableDictionary *patternParameter = [[NSMutableDictionary alloc] init];
    patternParameter[@"position"] = @0;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showPatternToUser:) userInfo: patternParameter repeats:YES];
}


- (void)createPattern{
    int currentNumberOfPattern = gameLevel + 4;
    computerPattern = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < currentNumberOfPattern; i++){
        NSNumber *randomNumber = [NSNumber numberWithInt: arc4random_uniform(6)];
        [computerPattern addObject: randomNumber];
    }
}


-(void)showPatternToUser: (NSTimer *)timer{
    if([[timer userInfo][@"position"] intValue] == [computerPattern count]){
        [timer invalidate];
        timer = nil;
        [self toggleColoredButtonsForAbility: YES];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(userTurn:) userInfo:nil repeats:YES];
        return;
    }
    int i = [([timer userInfo][@"position"]) intValue];
    UIButton* choosenButton = [buttons objectAtIndex: [[computerPattern objectAtIndex:i] intValue]];
    [choosenButton flashButton];
    [timer userInfo][@"position"] = @([[timer userInfo][@"position"] intValue] + 1);
    NSLog(@"%li", (long)choosenButton.tag);
}


-(void)userTurn: (NSTimer *)timer{
    int currentSecond = [self.gameTimer.text intValue];
    if(!userInputCorrect || currentSecond == 0){
        [timer invalidate];
        timer = nil;
        [self gameOver];
        return;
    }
    currentSecond -= 1;
    self.gameTimer.text = [NSString stringWithFormat:@"%d", currentSecond];
    
    if(gamePointer == [computerPattern count]){
        [timer invalidate];
        timer = nil;
        [self nextLevel];
    }
}


-(void)nextLevel {
    NSLog(@"NextLevel");
    [self toggleColoredButtonsForAbility: NO];
    gameLevel += 1;
    int currentSecond = [self.gameTimer.text intValue] + 10;
    self.gameTimer.text = [NSString stringWithFormat:@"%d", currentSecond];
    NSLog(@"Adding 10 more seconds");
    [self startLevel];
}


-(void)gameOver {
    self.gameTimer.text = [NSString stringWithFormat:@"%d", 0];
    [self toggleColoredButtonsForAbility:NO];
    [_startButton setTitle: @"Reset" forState:UIControlStateNormal];
    _startButton.enabled = YES;
    NSLog(@"GameOver");
}


-(void)setGameSettings {
    gameLevel = 1;
    userInputCorrect = YES;
    _gameScore.text = [NSString stringWithFormat:@"%d", 0];
    _gameTimer.text = [NSString stringWithFormat: @"%d", 10];
}


-(void)toggleColoredButtonsForAbility: (BOOL)display{
    for(int i = 0; i < [buttons count]; i++){
        ((UIButton *)[buttons objectAtIndex:i]).enabled = display;
    }
}


-(void)setBackgroundColorForButton: (UIButton*)button withColor: (int)colorValue{
    switch(colorValue){
        case RED:
            [button setBackgroundColor:[UIColor redColor]];
            break;
        case ORANGE:
            [button setBackgroundColor:[UIColor orangeColor]];
            break;
        case YELLOW:
            [button setBackgroundColor:[UIColor yellowColor]];
            break;
        case GREEN:
            [button setBackgroundColor: [UIColor greenColor]];
            break;
        case BLUE:
            [button setBackgroundColor: [UIColor blueColor]];
            break;
        case VIOLET:
            [button setBackgroundColor: [UIColor purpleColor]];
            break;
    }
}


- (IBAction)buttonPressed:(id)sender {
    UIButton *currentButton=(UIButton*)sender;
    if((int)currentButton.tag == [[computerPattern objectAtIndex:gamePointer] intValue]){
        gamePointer += 1;
        _gameScore.text = [NSString stringWithFormat:@"%d", ([_gameScore.text intValue] + 1)];
    }
    else {
        NSLog(@"Wrong");
        userInputCorrect = NO;
    }
}


- (IBAction)startGamePressed:(id)sender {
    [self setGameSettings];
    [self startLevel];
    _startButton.enabled = NO;
    [_startButton setTitle: @"" forState:UIControlStateNormal];
}

@end



/*
 On load - game sets color of the square
 
 Press Game Start - starts game
 1)Creates pattern at random (computerPattern)
 2)Start timer that calls showPatternToUser at each second. Pass in patternParam {position: 0} (pointer for computerPattern)
    - Up tic position for reach showPatternTouser method.
 3)Start timer and allow user to input the pattern.
 
 
 NEED TO CHANGE LOGIC OF WHEN TO STOP TIMER WHEN LOSING
 
 */
