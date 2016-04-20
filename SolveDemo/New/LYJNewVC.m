//
//  LYJNewVC.m
//  SolveDemo
//
//  Created by hyp on 16/4/19.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJNewVC.h"

@interface LYJNewVC ()

@end

@implementation LYJNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(newLeftBtnClicked)];
    self.view.backgroundColor = BackgroundColorRGB;

}


- (void)newLeftBtnClicked
{
    LYJLogFunc;
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
