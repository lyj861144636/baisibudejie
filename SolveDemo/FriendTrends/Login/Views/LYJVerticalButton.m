//
//  LYJVerticalButton.m
//  SolveDemo
//
//  Created by hyp on 16/4/26.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJVerticalButton.h"

@implementation LYJVerticalButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
