//
//  LYJRecommendTagCell.m
//  SolveDemo
//
//  Created by hyp on 16/4/25.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJRecommendTagCell.h"
#import "LYJRecommendTagModel.h"

@interface LYJRecommendTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewTag;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labCount;

@end

@implementation LYJRecommendTagCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setModelTag:(LYJRecommendTagModel *)modelTag
{
    _modelTag = modelTag;
    
    [self.imageViewTag sd_setImageWithURL:[NSURL URLWithString:modelTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.labTitle.text = modelTag.theme_name;
    NSString *subNumber = nil;
    if (modelTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅", modelTag.sub_number];
    } else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅", modelTag.sub_number / 10000.0];
    }
    self.labCount.text = subNumber;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 8;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
