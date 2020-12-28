//
//  CJViewController.m
//  CJScrollPage
//
//  Created by coderCJ on 12/28/2020.
//  Copyright (c) 2020 coderCJ. All rights reserved.
//

#import "CJViewController.h"
#import <CJScrollPage/WAISegmentBar.h>
#import <CJScrollPage/UIView+Extention.h>
@interface CJViewController ()<WAISegmentBarDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) WAISegmentBar * segmentBar;

@property (nonatomic, weak) UIScrollView *contentScrollView;

@end

@implementation CJViewController
-(WAISegmentBar *)segmentBar{
    if (!_segmentBar) {
        _segmentBar = [WAISegmentBar segmentBarWithConfig:[WAISegmentBarConfig defaultConfig]];
        _segmentBar.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 40);
        _segmentBar.delegate = self;
    }
    return _segmentBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    
    [self.view addSubview:self.segmentBar];
    
    self.segmentBar.segmentMs = @[@"推荐", @"订阅", @"历史",@"推荐", @"订阅", @"历史"];
    self.segmentBar.selectIndex = 0;
}
- (void)setUpInit{
    // 0. 初始化界面
    //    self.view.backgroundColor = WAIColor(225, 225, 225);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 1. 添加子控制器
    [self addChildViewControllers];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.segmentBar.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.segmentBar.frame))];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.bounces = NO;
    self.contentScrollView = scrollView;
    self.contentScrollView.contentSize = CGSizeMake(self.contentScrollView.width * self.childViewControllers.count, 0);
    [self.view addSubview:scrollView];
    
}
- (void)addChildViewControllers{
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:vc2];
    
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:vc4];
    
    UIViewController *vc5 = [[UIViewController alloc]init];
    vc5.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:vc5];
    
    
    UIViewController *vc6 = [[UIViewController alloc]init];
    vc6.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:vc6];
    
}

- (void)showControllerView:(NSInteger)index {
    
    UIView *view = self.childViewControllers[index].view;
    CGFloat contentViewW = self.contentScrollView.width;
    view.frame = CGRectMake(contentViewW * index, 0, contentViewW, self.contentScrollView.height);
    [self.contentScrollView addSubview:view];
    [self.contentScrollView setContentOffset:CGPointMake(contentViewW * index, 0) animated:YES];
    
}

- (void)segmentBar:(WAISegmentBar *)segmentBar didSelectedWithIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex{
    [self showControllerView:toIndex];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x / scrollView.width;
    self.segmentBar.selectIndex = page;
}
@end
