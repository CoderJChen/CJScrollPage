//
//  SegmentVC.m
//  MVVMAndRAC
//
//  Created by Eric on 2021/1/4.
//

#import "SegmentVC.h"
#import "UIView+Extension.h"
@interface SegmentVC ()<CJSegmentBarDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) CJSegmentBar * segmentBar;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSArray<NSString *> *categoryMs;

@end

@implementation SegmentVC

-(CJSegmentBar *)segmentBar{
    if (!_segmentBar) {
        CJSegmentBarConfig * config = [CJSegmentBarConfig defaultConfig];
        config.isShowMore = YES;
        config.segmentBarBackColor = [UIColor yellowColor];
        _segmentBar = [CJSegmentBar segmentBarWithConfig:config];
        _segmentBar.delegate = self;
    }
    return _segmentBar;
}

-(UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 88 + self.segmentBar.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - (88 + self.segmentBar.height + 44))];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.bounces = NO;
        scrollView.contentSize = CGSizeMake(scrollView.width * self.childViewControllers.count, 0);
        _contentScrollView = scrollView;
    }
    return _contentScrollView;
}
- (void)setCategoryMs:(NSArray<NSString *> *)categoryMs{
    _categoryMs = categoryMs;
    [self setUpWithItems:categoryMs];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray * titleArray = @[@"总榜",@"有声书",@"音乐",@"娱乐",@"相声评书",@"儿童",@"头条",@"情感生活",@"历史",@"外语",@"个人成长",@"百家讲坛",@"广播剧",@"戏曲",@"商业财经",@"IT科技",@"健康养生",@"校园",@"旅游",@"汽车",@"二次元",@"影视",@"时尚生活"];
    self.categoryMs = titleArray;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)setUpWithItems:(NSArray <NSString *>*)items {
    // 0.添加子控制器
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    for (int i = 0; i < items.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
//        vc.view.backgroundColor = ;
        [self addChildViewController:vc];
    }
    // 2. 添加内容视图
    [self.view addSubview:self.contentScrollView];
    
    self.segmentBar.y = self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height;
    
    // 1. 设置菜单栏
    [self.view addSubview:self.segmentBar];
   
    
    
    // 1. 设置菜单项展示
    self.segmentBar.segmentMs = items;
    
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.width * items.count, 0);
    
//    self.segmentBar.selectIndex = 0;
}

- (void)showControllerView:(NSInteger)index {
    
    UIViewController * listVC = self.childViewControllers[index];
//    listVC.loadKey = self.categoryMs[index];
    UIView *view = listVC.view;
    CGFloat contentViewW = self.contentScrollView.width;
    view.frame = CGRectMake(contentViewW * index, 0, contentViewW, self.contentScrollView.height);
    [self.contentScrollView addSubview:view];
    [self.contentScrollView setContentOffset:CGPointMake(contentViewW * index, 0) animated:YES];
    
}

-(void)segmentBar:(CJSegmentBar *)segmentBar didSelectedWithIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex{
    [self showControllerView:toIndex];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / scrollView.width;
    self.segmentBar.selectIndex = page;
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
