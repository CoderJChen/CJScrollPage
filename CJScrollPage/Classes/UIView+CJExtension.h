//
//  UIView+CJExtension.h
//  CJScrollPage
//
//  Created by Eric on 2021/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJExtension)
@property (nonatomic,assign) CGFloat CJ_x;
@property (nonatomic,assign) CGFloat CJ_y;
@property (nonatomic,assign) CGFloat CJ_left;
@property (nonatomic,assign) CGFloat CJ_top;
@property (nonatomic,assign) CGFloat CJ_height;
@property (nonatomic,assign) CGFloat CJ_right;
@property (nonatomic,assign) CGFloat CJ_bottom;
@property (nonatomic,assign) CGFloat CJ_width;
@property (nonatomic,assign) CGPoint CJ_origin;
@property (nonatomic,assign) CGSize  CJ_size;
@property (nonatomic,assign) CGFloat CJ_centerX;
@property (nonatomic,assign) CGFloat CJ_centerY;
+ (instancetype)CJ_viewFromXib;
@end

NS_ASSUME_NONNULL_END
