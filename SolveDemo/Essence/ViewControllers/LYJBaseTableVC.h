//
//  LYJBaseTableVC.h
//  SolveDemo
//
//  Created by hyp on 16/5/16.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LYJTopicTypeAll = 1,
    LYJTopicTypePicture = 10,
    LYJTopicTypeWord = 29,
    LYJTopicTypeVoice = 31,
    LYJTopicTypeVideo = 41
} LYJTopicType;

@interface LYJBaseTableVC : UITableViewController

/** leixing */
@property (nonatomic, assign) LYJTopicType type;

@end