//
//  LYJFriendTrends.m
//  SolveDemo
//
//  Created by hyp on 16/4/19.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJFriendTrendsVC.h"
#import "LYJRecommendVcViewController.h"
#import "LYJLoginRegisterVc.h"

@interface LYJFriendTrendsVC ()

@end

@implementation LYJFriendTrendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    self.view.backgroundColor = BackgroundColorRGB;
    LYJLogFunc;
}


#pragma mark - 左上角navi的点击事件
- (void)friendsClick
{
    LYJRecommendVcViewController *vc = [[LYJRecommendVcViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 立即登录按钮的点击事件
- (IBAction)login
{
    LYJLoginRegisterVc *vc = [[LYJLoginRegisterVc alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
