//
//  LYJRecommendCell.h
//  SolveDemo
//
//  Created by hyp on 16/4/21.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYJRecommendCategoryModel;

@interface LYJRecommendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *leftView;

/** 左边类别的类 */
@property (nonatomic, strong) LYJRecommendCategoryModel *modelRecommend;

@end
