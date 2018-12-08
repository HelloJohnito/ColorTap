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
    NSMutableArray *gamePattern;
    int level;
}
- (void)setBackgroundColorForButton: (UIButton*)button withColor: (int)colorValue;
- (void)startGame;
- (void)createPattern;
- (void)showPatternToUser: (NSTimer *)timer;
- (void)playGame: (NSTimer *)timer;
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
        [self setBackgroundColorForButton:[buttons objectAtIndex:i] withColor: [colors[i] intValue]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)startGame{
    level = 1;
    [self createPattern];
    NSMutableDictionary *patternParameter = [[NSMutableDictionary alloc] init];
    patternParameter[@"position"] = @0;
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showPatternToUser:) userInfo: patternParameter repeats:YES];
}


- (void)createPattern{
    int currentNumberOfPattern = level + 4;
    gamePattern = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < currentNumberOfPattern; i++){
        NSNumber *randomNumber = [NSNumber numberWithInt: arc4random_uniform(6)];
        [gamePattern addObject: randomNumber];
    }
}


-(void)showPatternToUser: (NSTimer *)timer{
    if([[timer userInfo][@"position"] intValue] == [gamePattern count]){
        [timer invalidate];
        timer = nil;
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(playGame:) userInfo:nil repeats:YES];
        return;
    }
    int i = [([timer userInfo][@"position"]) intValue];
    UIButton* choosenButton = [buttons objectAtIndex: [[gamePattern objectAtIndex:i] intValue]];
    [timer userInfo][@"position"] = @([[timer userInfo][@"position"] intValue] + 1);
    NSLog(@"%li", (long)choosenButton.tag);
}


-(void)playGame: (NSTimer *)timer{
    int currentSecond = [self.gameTimer.text intValue];
    if(currentSecond == 0){
        [timer invalidate];
        timer = nil;
        //game over
        return;
    }
    currentSecond -= 1;
    self.gameTimer.text = [NSString stringWithFormat:@"%d", currentSecond];
    
    
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
    NSLog(@"%li", (long)currentButton.tag);
}

- (IBAction)startGamePressed:(id)sender {
    [self startGame];
}
@end
