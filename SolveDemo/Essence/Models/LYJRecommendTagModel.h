//
//  LYJRecommendTagModel.h
//  SolveDemo
//
//  Created by hyp on 16/4/25.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYJRecommendTagModel : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;

@end
