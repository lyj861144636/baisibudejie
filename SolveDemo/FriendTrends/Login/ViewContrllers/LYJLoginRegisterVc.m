//
//  LYJLoginRegisterVc.m
//  SolveDemo
//
//  Created by hyp on 16/4/25.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJLoginRegisterVc.h"

@interface LYJLoginRegisterVc ()

@property (weak, nonatomic) IBOutlet UITextField *fileldPhone;
@property (weak, nonatomic) IBOutlet UITextField *fieldPassword;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

@end

@implementation LYJLoginRegisterVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)close
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (IBAction)register:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (self.leftConstraint.constant == 0) {// 注册帐号
        self.leftConstraint.constant = - self.view.width;
        sender.selected = YES;
    } else { // 已有帐号
        self.leftConstraint.constant = 0;
        sender.selected = NO;
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
@end
