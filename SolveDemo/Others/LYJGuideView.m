//
//  LYJGuideView.m
//  SolveDemo
//
//  Created by hyp on 16/4/29.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJGuideView.h"

@implementation LYJGuideView

+(instancetype)showGuideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)close
{
    [self removeFromSuperview];
}

+ (void)show
{
    NSString *key = @"CFBundleVersion";
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    NSString *boxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:boxVersion])
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        LYJGuideView *guideView = [LYJGuideView showGuideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

@end
