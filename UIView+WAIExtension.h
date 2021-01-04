//
//  UIView+WAIExtension.h
//  CJScrollPage
//
//  Created by Eric on 2021/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WAIExtension)
@property (nonatomic,assign) CGFloat WAI_x;
@property (nonatomic,assign) CGFloat WAI_y;
@property (nonatomic,assign) CGFloat WAI_left;
@property (nonatomic,assign) CGFloat WAI_top;
@property (nonatomic,assign) CGFloat WAI_height;
@property (nonatomic,assign) CGFloat WAI_right;
@property (nonatomic,assign) CGFloat WAI_bottom;
@property (nonatomic,assign) CGFloat WAI_width;
@property (nonatomic,assign) CGPoint WAI_origin;
@property (nonatomic,assign) CGSize  WAI_size;
@property (nonatomic,assign) CGFloat WAI_centerX;
@property (nonatomic,assign) CGFloat WAI_centerY;
+ (instancetype)CJ_viewFromXib;
@end

NS_ASSUME_NONNULL_END
