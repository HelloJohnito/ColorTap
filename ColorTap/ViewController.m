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
    BLUE,
    GREEN,
    YELLOW
} Colors;

@interface ViewController () {
    NSArray *colors;
    NSMutableArray *buttons;
    int squareNumber;
}
- (void) setBackgroundColorForButton: (UIButton*) button withColor: (int)colorValue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    colors = @[@(RED), @(BLUE), @(GREEN), @(YELLOW)];
    [self setBackgroundColorForButton:_button1 withColor:[colors[0] intValue]];
    
    buttons = [[NSMutableArray alloc] init];
    [buttons addObject: _button1];
    [buttons addObject: _button2];
    [buttons addObject: _button3];
    [buttons addObject: _button4];
    [buttons addObject: _button5];
    [buttons addObject: _button6];
    
    for(int i = 0; i < [buttons count]; i++){
        [self setBackgroundColorForButton:[buttons objectAtIndex:i] withColor:[colors[0] intValue]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) setBackgroundColorForButton: (UIButton*) button withColor: (int)colorValue{
    switch(colorValue){
        case RED:
            [button setBackgroundColor:[UIColor redColor]];
            break;
        case BLUE:
            [button setBackgroundColor: [UIColor blueColor]];
            break;
        case GREEN:
            [button setBackgroundColor: [UIColor greenColor]];
            break;
        case YELLOW:
            [button setBackgroundColor:[UIColor yellowColor]];
            break;
    }
}



- (IBAction)buttonPressed:(id)sender {
    UIButton *currentButton=(UIButton*)sender;
    
    NSLog(@"%li", (long)currentButton.tag);
}
@end
