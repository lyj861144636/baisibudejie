//
//  LYJWordCell.m
//  SolveDemo
//
//  Created by hyp on 16/5/11.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJWordCell.h"
#import "LYJWordModel.h"


@interface LYJWordCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *createLabel;
@property (weak, nonatomic) IBOutlet UIButton *dianButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end
@implementation LYJWordCell



-(void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.origin.y += margin;
    frame.size.height -= margin;
    
    [super setFrame:frame];
}


- (void)setModelWord:(LYJWordModel *)modelWord
{
    _modelWord = modelWord;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:modelWord.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = modelWord.name;
    self.createLabel.text = modelWord.create_time;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dianButton count:modelWord.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:modelWord.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:modelWord.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:modelWord.comment placeholder:@"评论"];
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    //    NSString *title = nil;
    //    if (count == 0) {
    //        title = placeholder;
    //    } else if (count > 10000) {
    //        title = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    //    } else {
    //        title = [NSString stringWithFormat:@"%zd", count];
    //    }
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
