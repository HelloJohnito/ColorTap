//
//  UIButton+animation.m
//  ColorTap
//
//  Created by John  Ito lee on 12/17/18.
//  Copyright © 2018 Johnito. All rights reserved.
//

#import "UIButton+animation.h"

@implementation UIButton (animation)

-(void)flashButton{
    NSLog(@"Pressed");
    CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash.duration = 0.3;
    flash.fromValue = [NSNumber numberWithFloat:1.0];
    flash.toValue = [NSNumber numberWithFloat:0.1];
    flash.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    flash.autoreverses = YES;
    flash.repeatCount = 1;
    [self.layer addAnimation:flash forKey:nil];
}

@end
