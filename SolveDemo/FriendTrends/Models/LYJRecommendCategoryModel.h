//
//  LYJRecommendCategoryModel.h
//  SolveDemo
//
//  Created by hyp on 16/4/21.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYJRecommendCategoryModel : NSObject

/** id */
@property (nonatomic, assign) NSInteger id;

/** 总数 */
@property (nonatomic, assign) NSInteger count;

/** 名字 */
@property (nonatomic, copy) NSString *name;


/** 每一个类别行里user数据 */
@property (nonatomic, strong) NSMutableArray *arrRowUsers;


/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;


@end
