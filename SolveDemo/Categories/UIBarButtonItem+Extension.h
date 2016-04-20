//
//  UIBarButtonItem+Extension.h
//  SolveDemo
//
//  Created by hyp on 16/4/20.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
