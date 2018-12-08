//
//  ViewController.h
//  ColorTap
//
//  Created by John  Ito lee on 11/17/18.
//  Copyright © 2018 Johnito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *gameTimer;
@property (weak, nonatomic) IBOutlet UILabel *score;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)startGamePressed:(id)sender;

@end

