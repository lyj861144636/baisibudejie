//
//  LYJTabBarVc.m
//  SolveDemo
//
//  Created by hyp on 16/4/19.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJTabBarVc.h"
#import "LYJEssenceVC.h"
#import "LYJNewVC.h"
#import "LYJFriendTrendsVC.h"
#import "LYJMeVC.h"

#import "LYJTabBar.h"
#import "LYJNaviVc.h"

@interface LYJTabBarVc ()

@end

@implementation LYJTabBarVc

// 第一次使用这个类的的时候会调用用一次
+(void)initialize
{
    // 设置tabBar 的标题颜色 和 字体大小  用appearance方法 可设置所有 避免了一个一个设置的麻烦
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 图片的设置 这么设置 也的一个一个的设置 故可找到显示的图片 点击render as 选为 original 即可省略代码（7.0之后）
//    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//现实图片原有颜色
//    vc01.tabBarItem.selectedImage = image;
    
    
    
    [self tabBarVc:[[LYJEssenceVC alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self tabBarVc:[[LYJNewVC alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self tabBarVc:[[LYJFriendTrendsVC alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self tabBarVc:[[LYJMeVC alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    [self setValue:[[LYJTabBar alloc] init] forKeyPath:@"tabBar"];
    
    
}

/**
 *  初始化子控制器
 */
- (void)tabBarVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    
    LYJNaviVc *navi = [[LYJNaviVc alloc] initWithRootViewController:vc];
    [self addChildViewController:navi];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
