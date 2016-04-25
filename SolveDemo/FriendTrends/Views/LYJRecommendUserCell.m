//
//  LYJRecommendUserCell.m
//  SolveDemo
//
//  Created by hyp on 16/4/22.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJRecommendUserCell.h"


@interface LYJRecommendUserCell()

@property (weak, nonatomic) IBOutlet UIImageView *ImageViewHeader;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labCount;

@end


@implementation LYJRecommendUserCell

-(void)setModelUser:(LYJRecomendUserModel *)modelUser
{
    _modelUser = modelUser;
    [self.ImageViewHeader sd_setImageWithURL:[NSURL URLWithString:modelUser.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.labName.text = modelUser.screen_name;
    
    NSString *subNumber = nil;
    if (modelUser.fans_count < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人关注", modelUser.fans_count];
    } else { // 大于等于10000
        subNumber = [NSString stringWithFormat:@"%.1f万人关注", modelUser.fans_count / 10000.0];
    }
    self.labCount.text = subNumber;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
