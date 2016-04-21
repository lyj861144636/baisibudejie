//
//  LYJRecommendVcViewController.m
//  SolveDemo
//
//  Created by hyp on 16/4/21.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJRecommendVcViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "LYJRecommendCell.h"
#import <MJExtension.h>
#import "LYJRecommendCategoryModel.h"

@interface LYJRecommendVcViewController ()<UITableViewDataSource, UITableViewDelegate>

// 左边类别的数组
@property (nonatomic, strong) NSArray *arrCategory;
// 左边类别的tableView
@property (weak, nonatomic) IBOutlet UITableView *tableViewCategory;

@end

@implementation LYJRecommendVcViewController

static NSString * const XMGCategoryId = @"category";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColorRGB;
    self.navigationItem.title = @"推荐关注";
    
    [self.tableViewCategory registerNib:[UINib nibWithNibName:NSStringFromClass([LYJRecommendCell class]) bundle:nil] forCellReuseIdentifier:XMGCategoryId];

    
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    // 请求数据
    NSMutableDictionary *dicPara = [NSMutableDictionary dictionary];
    dicPara[@"a"] = @"category";
    dicPara[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dicPara progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        // 返回数据转化为对象
        self.arrCategory = [LYJRecommendCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableViewCategory reloadData];
        
        // 设置选中第一行 来显示第一行默认选中 为红色
        [self.tableViewCategory selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        LYJLog(@"%@", self.arrCategory);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrCategory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYJRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCategoryId];
    if (cell == nil) {
        cell = [[LYJRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XMGCategoryId];
    }
    cell.modelRecommend = self.arrCategory[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LYJRecommendCategoryModel *model = self.arrCategory[indexPath.row];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(model.id);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LYJLog(@"%@", responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
