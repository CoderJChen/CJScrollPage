//
//  WAISegmentViewController.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/26.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "WAISegmentViewController.h"
#import "UIView+Extention.h"
@interface WAISegmentViewController ()<WAISegmentBarDelegate,UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView * contentView;
@property(assign,nonatomic) CGFloat  segmentTopH;
@property(assign,nonatomic) CGFloat  segmentH;
@end

@implementation WAISegmentViewController
- (WAISegmentBar *)segmentBar{
    if (!_segmentBar) {
        WAISegmentBar * segmentBar = [WAISegmentBar segmentBarWithFrame:CGRectZero];
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
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)setUpWithItems:(NSArray<id<WAISegmentModelProtocol>> *)items childVC:(NSArray<UIViewController *> *)childVCs andSegBarPositionTop:(CGFloat)top andSegmentH:(CGFloat)height{
    NSAssert(items.count != 0 || items.count == childVCs.count, @"个数不一致，请自己检查");
    self.segmentBar.segmentMs = items;
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    for (UIViewController * vc in childVCs) {
        [self addChildViewController:vc];
    }
    self.contentView.contentSize = CGSizeMake(items.count * self.view.width, 0);
    self.segmentBar.selectIndex = 0;
    self.segmentTopH = top;
    self.segmentH = height;
}
- (void)showChildVCViewsAtIndex:(NSInteger)index{
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count -1) {
        return;
    }
    UIViewController * vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.contentView.width, 0, self.contentView.width, self.contentView.height);
    [self.contentView addSubview:vc.view];
    
    [self.contentView setContentOffset:CGPointMake(index * self.view.width, 0) animated:YES];
}
#pragma mark - segmentDelegate
-(void)segmentBar:(WAISegmentBar *)segmentBar didSelectedWithIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex{
    NSLog(@"%zd-----%zd",fromIndex,toIndex);
    [self showChildVCViewsAtIndex:toIndex];
    
}
#pragma mark - scrollviewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = self.contentView.contentOffset.x/self.contentView.width;
    self.segmentBar.selectIndex = index;
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if (self.segmentBar.superview == self.view) {
        self.segmentBar.frame = CGRectMake(0, self.segmentTopH>=0?self.segmentTopH:60, self.view.width, self.segmentH>0?self.segmentH:35);
        NSLog(@"%@===%f",NSStringFromCGRect(self.segmentBar.frame),self.segmentH>0?self.segmentH:35);
        CGFloat contentViewY = self.segmentBar.y + self.segmentBar.height;
        CGRect contentFrame = CGRectMake(0, contentViewY, self.view.width, self.view.height - contentViewY);
        self.contentView.frame = contentFrame;
        self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
        
        return;
    }
    CGRect contentFrame = CGRectMake(0, 0,self.view.width,self.view.height);
    self.contentView.frame = contentFrame;
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    
    self.segmentBar.selectIndex = self.segmentBar.selectIndex;
}
@end