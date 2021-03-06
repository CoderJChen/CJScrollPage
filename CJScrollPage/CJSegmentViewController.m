//
//  CJSegmentViewController.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/26.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "CJSegmentViewController.h"
#import "CJScrollPageConst.h"

@interface CJSegmentViewController ()<CJSegmentBarDelegate,UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView * contentView;
@property(assign,nonatomic) CGFloat  segmentTopH;
@property(assign,nonatomic) CGFloat  segmentH;
@end

@implementation CJSegmentViewController
- (CJSegmentBar *)segmentBar{
    if (!_segmentBar) {
        CJSegmentBar * segmentBar = [CJSegmentBar segmentBarWithFrame:CGRectZero];
        segmentBar.delegate = self;
        [self.view addSubview:segmentBar];
        _segmentBar = segmentBar;
    }
    return _segmentBar;
}
-(UIScrollView *)contentView{
    if (!_contentView) {
        UIScrollView * contentView = [[UIScrollView alloc]init];
        contentView.delegate = self;
        contentView.pagingEnabled = YES;
        contentView.showsVerticalScrollIndicator = NO;
        contentView.showsHorizontalScrollIndicator = NO;
        contentView.scrollsToTop = NO;
        contentView.bounces = NO;
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.contentView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(void)setUpWithItems:(NSArray<id<CJSegmentModelProtocol>> *)items childVC:(NSArray<UIViewController *> *)childVCs andSegBarPositionTop:(CGFloat)top andSegmentH:(CGFloat)height{
    NSAssert(items.count != 0 || items.count == childVCs.count, @"个数不一致，请自己检查");
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    for (UIViewController * vc in childVCs) {
        [self addChildViewController:vc];
    }
    self.contentView.contentSize = CGSizeMake(items.count * self.view.CJ_width, 0);
    self.segmentTopH = top;
    self.segmentH = height;
    self.segmentBar.frame = CGRectMake(0, self.segmentTopH>=0?self.segmentTopH:60, self.view.CJ_width, self.segmentH>0?self.segmentH:35);
    self.segmentBar.selectIndex = 0;
    self.segmentBar.segmentMs = items;
    
}
- (void)showChildVCViewsAtIndex:(NSInteger)index{
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count -1) {
        return;
    }
    UIViewController * vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.contentView.CJ_width, 0, self.contentView.CJ_width, self.contentView.CJ_height);
    [self.contentView addSubview:vc.view];
    
    [self.contentView setContentOffset:CGPointMake(index * self.view.CJ_width, 0) animated:YES];
}
#pragma mark - segmentDelegate
-(void)segmentBar:(CJSegmentBar *)segmentBar didSelectedWithIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex{
    [self showChildVCViewsAtIndex:toIndex];
    
}
#pragma mark - scrollviewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = self.contentView.contentOffset.x/self.contentView.CJ_width;
    self.segmentBar.selectIndex = index;
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if (self.segmentBar.superview == self.view) {
        self.segmentBar.frame = CGRectMake(0, self.segmentTopH>=0?self.segmentTopH:60, self.view.CJ_width, self.segmentH>0?self.segmentH:35);
        CGFloat contentViewY = self.segmentBar.CJ_y + self.segmentBar.CJ_height;
        CGRect contentFrame = CGRectMake(0, contentViewY, self.view.CJ_width, self.view.CJ_height - contentViewY);
        self.contentView.frame = contentFrame;
        self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.CJ_width, 0);
        
        return;
    }
    CGRect contentFrame = CGRectMake(0, 0,self.view.CJ_width,self.view.CJ_height);
    self.contentView.frame = contentFrame;
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.CJ_width, 0);
    
    self.segmentBar.selectIndex = self.segmentBar.selectIndex;
}
@end
