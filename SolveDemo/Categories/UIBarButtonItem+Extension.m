//
//  UIBarButtonItem+Extension.m
//  SolveDemo
//
//  Created by hyp on 16/4/20.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [leftbtn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    CGRect frame = leftbtn.frame;
    frame.size = leftbtn.currentBackgroundImage.size;
    leftbtn.frame = frame;
    
    [leftbtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:leftbtn];
}

@end
