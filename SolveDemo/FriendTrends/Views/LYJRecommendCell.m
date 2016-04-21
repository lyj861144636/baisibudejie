//
//  LYJRecommendCell.m
//  SolveDemo
//
//  Created by hyp on 16/4/21.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJRecommendCell.h"
#import "LYJRecommendCategoryModel.h"

@implementation LYJRecommendCell


-(void)setModelRecommend:(LYJRecommendCategoryModel *)modelRecommend
{
    _modelRecommend = modelRecommend;
    
    self.textLabel.text = modelRecommend.name;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = ColorRGB(244, 244, 244);
    
    // 当设置了选中cell时 没有点击颜色 这下面的高亮颜色都不好用
//    self.textLabel.textColor = ColorRGB(78, 78, 78);
//    self.textLabel.highlightedTextColor = ColorRGB(219, 21, 26);
    
    self.leftView.backgroundColor = ColorRGB(219, 21, 26);
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.leftView.hidden = !selected;
    self.textLabel.textColor = selected ? self.leftView.backgroundColor : ColorRGB(78, 78, 78);
}

@end
