//
//  LYJRecommendTagVc.m
//  SolveDemo
//
//  Created by hyp on 16/4/25.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJRecommendTagVc.h"
#import "LYJRecommendTagModel.h"
#import "LYJRecommendTagCell.h"

@interface LYJRecommendTagVc ()

/** 数组 */
@property (nonatomic, strong) NSArray *tags;

@end


static NSString * const LYJtTagCellId = @"tagCell";

@implementation LYJRecommendTagVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐标签";
    self.tags = [NSArray array];
    self.tableView.backgroundColor = BackgroundColorRGB;
    self.tableView.rowHeight = 70;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYJRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:LYJtTagCellId];
    
    [self request];
}

- (void)request
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.tags = [LYJRecommendTagModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
        
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYJRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:LYJtTagCellId forIndexPath:indexPath];
    
    cell.modelTag = self.tags[indexPath.row];
    
    return cell;
}


@end
