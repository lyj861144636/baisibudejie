//
//  LYJEssenceVC.m
//  SolveDemo
//
//  Created by hyp on 16/4/19.
//  Copyright © 2016年 hyp. All rights reserved.
//

#import "LYJEssenceVC.h"
#import "LYJRecommendTagVc.h"


#import "LYJBaseTableVC.h"


@interface LYJEssenceVC () <UIScrollViewDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;

/** 最底层scrollView */
@property (nonatomic, weak) UIScrollView *scrollViewBottom;

/** 最顶层buttonView */
@property (nonatomic, weak) UIView *viewButton;


@end

@implementation LYJEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
   
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(leftBtnClicked)];
    self.view.backgroundColor = BackgroundColorRGB;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"hhhh" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    
    // 创建 子控制器tablViewController
    [self setUpTableViewControllers];
    // 创建 底部ScrollView
    [self setUpSCrollView];
    // 创建顶部五个button
    [self setUp];
    

}

#pragma mark - 创建 子控制器tablViewController
- (void)setUpTableViewControllers
{
    LYJBaseTableVC *all = [[LYJBaseTableVC alloc] init];
    all.title = @"全部";
    all.type = LYJTopicTypeAll;
    [self addChildViewController:all];
    
    LYJBaseTableVC *video = [[LYJBaseTableVC alloc] init];
    video.title = @"视频";
    video.type = LYJTopicTypeVideo;
    [self addChildViewController:video];
    
    LYJBaseTableVC *voice = [[LYJBaseTableVC alloc] init];
    voice.title = @"音频";
    voice.type = LYJTopicTypeVoice;
    [self addChildViewController:voice];
    
    LYJBaseTableVC *pic = [[LYJBaseTableVC alloc] init];
    pic.title = @"图片";
    pic.type = LYJTopicTypePicture;
    [self addChildViewController:pic];
    
    
    LYJBaseTableVC *word = [[LYJBaseTableVC alloc] init];
    word.title = @"段子";
    word.type = LYJTopicTypeWord;
    [self addChildViewController:word];
}



#pragma mark - 创建顶部五个button
- (void)setUp
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    titlesView.frame = CGRectMake(0, 64, self.view.width, 40);
    [self.view addSubview:titlesView];
    self.viewButton = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
 
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        //        [button layoutIfNeeded]; // 强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
       [titlesView addSubview:indicatorView];
}

- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.scrollViewBottom.contentOffset;
    offset.x = button.tag * self.scrollViewBottom.width;
    [self.scrollViewBottom setContentOffset:offset animated:YES];
}

#pragma mark - 创建 底部ScrollView
- (void)setUpSCrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollViewBottom = scrollView;
    
    scrollView.contentSize = CGSizeMake(self.view.width * 5, 0);
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


- (void)leftBtnClicked
{
    LYJRecommendTagVc *vc = [[LYJRecommendTagVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - <scrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, scrollView.width, scrollView.height);
    
    // 设置内边距
    vc.tableView.contentInset = UIEdgeInsetsMake(104, 0, self.tabBarController.tabBar.height, 0);
    // 设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    [self titleClick:self.viewButton.subviews[index]];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
