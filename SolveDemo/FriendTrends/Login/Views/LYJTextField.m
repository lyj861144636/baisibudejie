//
//  LYJTextField.m
//  SolveDemo
//
//  Created by hyp on 16/4/26.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJTextField.h"

@implementation LYJTextField

-(void)awakeFromNib
{
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
@end
