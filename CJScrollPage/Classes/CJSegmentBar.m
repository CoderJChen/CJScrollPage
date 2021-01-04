//
//  CJSegmentBar.m
//  CJFM
//
//  Created by 陈杰 on 2019/1/26.
//  Copyright © 2019 Eric. All rights reserved.
//

#import "CJSegmentBar.h"
#import "CJSegmentRLButton.h"
#import "CJMenuBarShowDetailVC.h"
#import "CJScrollPageHeader.h"

#define CJMinMargin 30
#define CJShowMoreBtnW (self.bounds.size.height + 30)

@interface CJSegmentBar()<UICollectionViewDelegate>
@property (nonatomic,weak) UIScrollView * contentView;
@property (nonatomic,strong) NSMutableArray <UIButton *>* itemBtns;

@property (nonatomic,weak) UIView * indicatorView;

@property (nonatomic,strong) CJSegmentBarConfig * config;

@property (nonatomic,weak) UIButton * lastBtn;

@property (nonatomic,strong) CJSegmentRLButton * showMoreBtn;

@property (nonatomic,strong,nonnull) UIView * coverView;

@property (nonatomic,strong) CJMenuBarShowDetailVC * showDetailVC;

@end

@implementation CJSegmentBar
#pragma mark -懒加载
-(NSMutableArray<UIButton *> *)itemBtns{
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}
-(UIScrollView *)contentView{
    if (!_contentView) {
        UIScrollView * scrollView = [[UIScrollView alloc]init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.frame = self.bounds;
        [self addSubview:scrollView];
        _contentView = scrollView;
    }
    return _contentView;
}
-(UIView *)indicatorView{
    if (!_indicatorView) {
        UIView * indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, self.CJ_height - self.config.indicatorHeight, 0, self.config.indicatorHeight)];
        indicatorView.backgroundColor = self.config.indicatorColor;
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
        
    }
    return _indicatorView;
}

-(CJMenuBarShowDetailVC *)showDetailVC{
    if (!_showDetailVC) {
        _showDetailVC = [[CJMenuBarShowDetailVC alloc]init];
        _showDetailVC.collectionView.delegate = self;
    }
    if (_showDetailVC.collectionView.superview != self.superview) {
        _showDetailVC.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.frame), self.CJ_width, 0);
        [self.superview addSubview:_showDetailVC.collectionView];
    }
    return _showDetailVC;
}
-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, self.CJ_y + self.CJ_height, self.CJ_width, 0)];
        _coverView.backgroundColor = [UIColor colorWithRed:55 / 255. green:55 / 255. blue:55 / 255. alpha:0.4];
        UITapGestureRecognizer * gestR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideDetailPane)];
        [_coverView addGestureRecognizer:gestR];
    }
    if (!_coverView.superview) {
        [self.superview insertSubview:_coverView belowSubview:self.showDetailVC.collectionView];
    }
    return _coverView;
}
-(CJSegmentRLButton *)showMoreBtn{
    if (!_showMoreBtn) {
        UIImage * showImage = [UIImage imageNamed:@"icon_radio_show"];
        UIImage * hideImage = [UIImage imageNamed:@"icon_radio_hide"];
        _showMoreBtn = [[CJSegmentRLButton alloc]init];
        [_showMoreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_showMoreBtn setImage:showImage forState:UIControlStateNormal];
        [_showMoreBtn setTitle:@"收起" forState:UIControlStateSelected];
        [_showMoreBtn setImage:hideImage forState:UIControlStateSelected];
        _showMoreBtn.imageView.contentMode = UIViewContentModeCenter;
        [_showMoreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _showMoreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        UIView * lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 0)];
        lineV.backgroundColor = [UIColor lightGrayColor];
        _showMoreBtn.layer.masksToBounds = YES;
        [_showMoreBtn addSubview:lineV];
        [_showMoreBtn addTarget:self action:@selector(showOrHide:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_showMoreBtn];
    }
        return _showMoreBtn;
}

+(instancetype)segmentBarWithConfig:(CJSegmentBarConfig *)config{
    CGRect defaultFrame = CGRectMake(0, 0,CJScreenWidth, 40);
    CJSegmentBar * segmentBar = [[CJSegmentBar alloc]initWithFrame:defaultFrame];
    segmentBar.config = config;
    return segmentBar;
}
+(instancetype)segmentBarWithFrame:(CGRect)frame{
    CJSegmentBar * segmentBar = [[CJSegmentBar alloc]initWithFrame:frame];
    return segmentBar;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.config = [CJSegmentBarConfig defaultConfig];
    }
    return self;
}
-(void)updateWithConfig:(void (^)(CJSegmentBarConfig * _Nonnull))configBlock{
    if (configBlock) {
        configBlock(self.config);
    }
    self.config = self.config;
}
-(void)setConfig:(CJSegmentBarConfig *)config{
    _config = config;
    
    self.indicatorView.backgroundColor = config.indicatorColor;
    self.indicatorView.CJ_height = config.indicatorHeight;
    self.backgroundColor = config.segmentBarBackColor;
        for (UIButton * btn in self.itemBtns) {
            [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
            if (btn != self.lastBtn) {
                btn.titleLabel.font = config.itemNormalFont;
            }else{
                btn.titleLabel.font = config.itemSelectFont;
            }
            [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        }
    
        [self setNeedsLayout];
        [self layoutIfNeeded];
    
}

- (void)setSegmentMs:(NSArray<id<CJSegmentModelProtocol>> *)segmentMs{
    _segmentMs = segmentMs;
    if (self.config.isShowMore) {
        self.showDetailVC.items = segmentMs;
        self.showDetailVC.collectionView.CJ_height = 0;
    }
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    self.lastBtn = nil;
    [self.indicatorView removeFromSuperview];
    self.indicatorView = nil;
    for (NSObject <CJSegmentModelProtocol> * segM in segmentMs) {
        UIButton * btn = [[UIButton alloc]init];
        if (segM.segID == -1) {
            btn.tag = self.itemBtns.count;
        }else{
            btn.tag = segM.segID;
        }
        [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:segM.segContent forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemNormalFont;
        [self.contentView addSubview:btn];
        [btn sizeToFit];
        [self.itemBtns addObject:btn];
        
    }
    
    [self layoutIfNeeded];
    [self layoutSubviews];
//    默认选中第一个
    [self btnDidClick:self.itemBtns.firstObject];
}
-(void)setItems:(NSArray<NSString *> *)items{
    _items = items;
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    for (NSString * item in items) {
        UIButton * btn = [[UIButton alloc]init];
        btn.tag = self.itemBtns.count;
        [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:item forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemNormalFont;
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

- (void)btnDidClick:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectedWithIndex:fromIndex:)]) {
        _selectIndex = btn.tag;
        [self.delegate segmentBar:self didSelectedWithIndex:btn.tag fromIndex:self.lastBtn.tag];
    }
    
    self.lastBtn.selected = NO;
    self.lastBtn.titleLabel.font = self.config.itemSelectFont;
    [self.lastBtn sizeToFit];
    self.lastBtn.CJ_height = self.contentView.CJ_height - self.config.indicatorHeight;
    
    btn.selected = YES;
    btn.titleLabel.font = self.config.itemNormalFont;
    [btn sizeToFit];
    btn.CJ_height = self.contentView.CJ_height - self.config.indicatorHeight;
    self.lastBtn = btn;
    
    if (self.config.isShowMore) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:self.lastBtn.tag inSection:0];
        [self.showDetailVC.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        [self hideDetailPane];
    }
    
    
    [UIView animateWithDuration:0.2 animations:^{
        NSString * text = btn.titleLabel.text;
        
        NSDictionary * fontDict = @{
                                    NSFontAttributeName:btn.titleLabel.font
                                    };
        CGSize size = [text sizeWithAttributes:fontDict];
        self.indicatorView.CJ_y = self.contentView.CJ_height - self.config.indicatorHeight;
        self.indicatorView.CJ_width = size.width + self.config.indicatorExtraW;
        self.indicatorView.CJ_centerX = btn.CJ_centerX;
    }];
    CGFloat scrollX = btn.CJ_centerX - self.contentView.CJ_width * 0.5;
    if (scrollX < 0) {
        scrollX = 0;
    }
    if (scrollX > self.contentView.contentSize.width - self.contentView.CJ_width) {
        scrollX = self.contentView.contentSize.width - self.contentView.CJ_width;
    }
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    for (UIButton * btn in self.itemBtns) {
        if (btn.tag == selectIndex) {
            [self btnDidClick:btn];
            break;
        }
    }
}
- (void)hideDetailPane{
    self.showMoreBtn.selected = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.showDetailVC.collectionView.CJ_height = 0;
        self.coverView.CJ_height = 0;
    } completion:^(BOOL finished) {
        self.coverView.hidden = YES;
        self.showDetailVC.collectionView.hidden = YES;
    }];
}
- (void)showDetailPane {
    self.showMoreBtn.selected = YES;
    self.showDetailVC.collectionView.hidden = NO;
    self.coverView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.showDetailVC.collectionView.CJ_height = self.showDetailVC.expectedHeight;
        self.coverView.CJ_height = CJScreenHeight;
    }];
}
- (void)showOrHide:(CJSegmentRLButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self showDetailPane];
    }else{
        [self hideDetailPane];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    if (!self.config.isShowMore) {
        self.contentView.frame = self.bounds;
        self.showMoreBtn.CJ_width = -1;
    }else{
        self.contentView.frame = CGRectMake(0, 0, self.CJ_width - CJShowMoreBtnW, self.CJ_height);
        self.showMoreBtn.frame = CGRectMake(self.CJ_width - CJShowMoreBtnW, 0, CJShowMoreBtnW, self.CJ_height);
    }
//    更多分割线设置位置
    NSString * text = self.showMoreBtn.titleLabel.text;
    NSDictionary * attrDict = @{
                                NSFontAttributeName:self.showMoreBtn.titleLabel.font
                                };
    CGSize size = [text sizeWithAttributes:attrDict];
    self.showMoreBtn.subviews.lastObject.CJ_height = size.height + 6;
    self.showMoreBtn.subviews.lastObject.CJ_centerY = self.showMoreBtn.CJ_height * 0.5;
    
    CGFloat totalBtnWidth = 0;
    for (UIButton * btn in self.itemBtns) {
        [btn sizeToFit];
        totalBtnWidth += btn.CJ_width;
    }
    CGFloat caculateMargin = (self.contentView.CJ_width - totalBtnWidth) / (self.segmentMs.count + 1);
    
    caculateMargin = caculateMargin < self.config.limitMargin ? self.config.limitMargin : caculateMargin;
    
    CGFloat btnY = 0;
    CGFloat btnHeight = self.contentView.CJ_height - self.config.indicatorHeight;
    UIButton * lastButton;
    
    for (UIButton * btn in self.itemBtns) {
        CGFloat btnX = CGRectGetMaxX(lastButton.frame) + caculateMargin;
        [btn sizeToFit];
        btn.CJ_y = btnY;
        btn.CJ_x = btnX;
        btn.CJ_height = btnHeight;
        lastButton = btn;
    }
    
    self.contentView.contentSize = CGSizeMake(CGRectGetMaxX(lastButton.frame) + caculateMargin, 0);
    if (self.itemBtns.count == 0) {
        return;
    }
    
//    UIButton * btn = self.itemBtns[self.selectIndex];
//    self.indicatorView.CJ_y = self.contentView.CJ_height - self.indicatorView.CJ_height;
//    self.indicatorView.CJ_width = btnsize.width + self.config.indicatorExtraW * 2;
//    self.indicatorView.CJ_height = self.config.indicatorHeight;
//    self.indicatorView.CJ_centerX = btn.CJ_centerX;
    
}
#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectIndex = indexPath.row;
    [self hideDetailPane];
    
}
@end
