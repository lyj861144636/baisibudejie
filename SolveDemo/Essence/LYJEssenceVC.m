//
//  LYJEssenceVC.m
//  SolveDemo
//
//  Created by hyp on 16/4/19.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJEssenceVC.h"

@interface LYJEssenceVC ()

@end

@implementation LYJEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
   
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(leftBtnClicked)];
    self.view.backgroundColor = BackgroundColorRGB;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"hhhh" style:UIBarButtonItemStyleDone target:nil action:nil];

}


- (void)leftBtnClicked
{
    LYJLogFunc;
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:vc animated:YES];
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
