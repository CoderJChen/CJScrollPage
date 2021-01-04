//
//  CJSegmentViewController.h
//  CJFM
//
//  Created by 陈杰 on 2019/1/26.
//  Copyright © 2019 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJSegmentBar.h"
#import "NSString+SegmentModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface CJSegmentViewController : UIViewController
@property (nonatomic,weak) CJSegmentBar * segmentBar;

- (void)setUpWithItems:(NSArray <id<CJSegmentModelProtocol>>*)items childVC:(NSArray <UIViewController *>*)childVCs andSegBarPositionTop:(CGFloat)top andSegmentH:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
