//
//  LYJRecommendCategoryModel.m
//  SolveDemo
//
//  Created by hyp on 16/4/21.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJRecommendCategoryModel.h"

@implementation LYJRecommendCategoryModel

-(NSMutableArray *)arrRowUsers
{
    if (!_arrRowUsers) {
        _arrRowUsers = [NSMutableArray array];
    }
    return _arrRowUsers;
}
@end
