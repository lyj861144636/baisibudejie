//
//  LYJRecommendVcViewController.m
//  SolveDemo
//
//  Created by hyp on 16/4/21.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJRecommendVcViewController.h"

#import "LYJRecommendCell.h"
#import "LYJRecommendCategoryModel.h"

#import "LYJRecommendUserCell.h"
#import "LYJRecomendUserModel.h"



@interface LYJRecommendVcViewController ()<UITableViewDataSource, UITableViewDelegate>

// 左边类别的数组
@property (nonatomic, strong) NSArray *arrCategory;
// 左边类别的tableView
@property (weak, nonatomic) IBOutlet UITableView *tableViewCategory;


// 右边类别的tableView
@property (weak, nonatomic) IBOutlet UITableView *tableViewUser;

// 右边类别的数组
@property (nonatomic, strong) NSArray *arrUser;


/** 参数 让其避免多个请求 只请求最后点击的那个 */
@property (nonatomic, strong) NSMutableDictionary *params;

/** 网络管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation LYJRecommendVcViewController

static NSString * const XMGCategoryId = @"category";
static NSString * const XMGUserId = @"user";

-(AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // 项目初始化的一些操作
    [self setUp];
    
    // 请求左边的tableView的信息
    [self getLeftMessages];
    
    // tableViewUser 上啦加载 下啦刷新
    [self mjRefreshWithUserTableView];
    
    

}

#pragma mark - 项目初始化的一些操作
- (void)setUp
{
    self.view.backgroundColor = BackgroundColorRGB;
    self.navigationItem.title = @"推荐关注";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableViewUser.rowHeight = 70;
    
    
    // 注册cell
    [self.tableViewCategory registerNib:[UINib nibWithNibName:NSStringFromClass([LYJRecommendCell class]) bundle:nil] forCellReuseIdentifier:XMGCategoryId];
    [self.tableViewUser registerNib:[UINib nibWithNibName:NSStringFromClass([LYJRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:XMGUserId];
}

#pragma mark - 请求左边的tableView的信息
- (void)getLeftMessages
{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    // 请求数据
    NSMutableDictionary *dicPara = [NSMutableDictionary dictionary];
    dicPara[@"a"] = @"category";
    dicPara[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dicPara progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        // 返回数据转化为对象
        self.arrCategory = [LYJRecommendCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableViewCategory reloadData];
        
        // 设置选中第一行 来显示第一行默认选中 为红色
        [self.tableViewCategory selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        LYJLog(@"%@", self.arrCategory);
        
        // 请求第一行右边的数据
        [self.tableViewUser.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

#pragma mark - 上啦刷新 下拉加载
- (void)mjRefreshWithUserTableView
{
    self.tableViewUser.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.tableViewUser.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.tableViewUser.mj_footer.hidden = YES;
}

- (void)loadNewUsers
{
    LYJRecommendCategoryModel *model = self.arrCategory[self.tableViewCategory.indexPathForSelectedRow.row];
    model.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(model.id);
    params[@"page"] = @(model.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        LYJLog(@"%@", responseObject[@"list"]);
        
        NSArray *arr = [LYJRecomendUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [model.arrRowUsers removeAllObjects];
        
        // 每个类别添加到类别的数组里
        [model.arrRowUsers addObjectsFromArray:arr];
        
        // 保存总数
        model.total = [responseObject[@"total"] integerValue];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        [self.tableViewUser reloadData];
        // 结束刷新
        [self.tableViewUser.mj_header endRefreshing];
        // 监测footer的状态
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         // 不是最后一次请求
        if (self.params != params) return;
        [SVProgressHUD showErrorWithStatus:@"加载信息失败"];
        // 结束刷新
        [self.tableViewUser.mj_header endRefreshing];
    }];

}

- (void)loadMoreUsers
{
    LYJRecommendCategoryModel *model = self.arrCategory[self.tableViewCategory.indexPathForSelectedRow.row];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(model.id);
    params[@"page"] = @(++model.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr = [LYJRecomendUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 每个类别添加到类别的数组里
        [model.arrRowUsers addObjectsFromArray:arr];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        [self.tableViewUser reloadData];
        
        // 监测footer的状态
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        [SVProgressHUD showErrorWithStatus:@"加载信息失败"];
        // 结束刷新
        [self.tableViewUser.mj_footer endRefreshing];
    }];
}

/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState
{
     LYJRecommendCategoryModel *rc = self.arrCategory[self.tableViewCategory.indexPathForSelectedRow.row];
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.tableViewUser.mj_footer.hidden = (rc.arrRowUsers.count == 0);
    
    // 让底部控件结束刷新
    if (rc.arrRowUsers.count == rc.total) { // 全部数据已经加载完毕
        [self.tableViewUser.mj_footer endRefreshingWithNoMoreData];
    } else { // 还没有加载完毕
        [self.tableViewUser.mj_footer endRefreshing];
    }
}


#pragma mark ---tableView 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableViewCategory) {
        return self.arrCategory.count;
    } else {
        LYJRecommendCategoryModel *cateModel = self.arrCategory[self.tableViewCategory.indexPathForSelectedRow.row];
        // 监测footer的状态
        [self checkFooterState];
        
        return cateModel.arrRowUsers.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableViewCategory) {
        // 左侧cell
        LYJRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGCategoryId];
        if (cell == nil) {
            cell = [[LYJRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XMGCategoryId];
        }
        cell.modelRecommend = self.arrCategory[indexPath.row];
        return cell;
    } else
    {
        // 右侧cell
        LYJRecommendUserCell *cellUser = [tableView dequeueReusableCellWithIdentifier:XMGUserId];
        if (cellUser == nil) {
            cellUser = [[LYJRecommendUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XMGUserId];
        }
        LYJRecommendCategoryModel *cateModel = self.arrCategory[self.tableViewCategory.indexPathForSelectedRow.row];
        cellUser.modelUser = cateModel.arrRowUsers[indexPath.row];
        return cellUser;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新 防止多次点击其他的cell 还处于更新状态
    [self.tableViewUser.mj_header endRefreshing];
    [self.tableViewUser.mj_footer endRefreshing];
    
    LYJRecommendCategoryModel *model = self.arrCategory[indexPath.row];
   
    if (model.arrRowUsers.count)
    {
        [self.tableViewUser reloadData];
    } else
    {
        // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        [self.tableViewUser reloadData];
        // 进入下拉刷新状态
        [self.tableViewUser.mj_header beginRefreshing];
    }
}

- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}

@end
