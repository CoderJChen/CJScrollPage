//
//  UIView+CJExtension.m
//  CJScrollPage
//
//  Created by Eric on 2021/1/4.
//

#import "UIView+CJExtension.h"

@implementation UIView (CJExtension)

- (void)setCJ_x:(CGFloat)CJ_x{
    CGRect frame = self.frame;
    frame.origin.x = CJ_x;
    self.frame = frame;
}
-(void)setCJ_y:(CGFloat)CJ_y{
    CGRect frame = self.frame;
    frame.origin.x = CJ_y;
    self.frame = frame;
}
-(void)setCJ_top:(CGFloat)CJ_top{
    CGRect frame = self.frame;
    frame.origin.y = CJ_top;
    self.frame = frame;
}
-(void)setCJ_left:(CGFloat)CJ_left{
    CGRect frame = self.frame;
    frame.origin.x = CJ_left;
    self.frame = frame;
}
-(void)setCJ_right:(CGFloat)CJ_right{
    CGRect frame = self.frame;
    frame.origin.x = CJ_right - frame.size.width;
    self.frame = frame;
}
-(void)setCJ_bottom:(CGFloat)CJ_bottom{
    CGRect frame = self.frame;
    frame.origin.y = CJ_bottom - frame.size.height;
    self.frame = frame;
}
-(void)setCJ_width:(CGFloat)CJ_width{
    CGRect frame = self.frame;
    frame.size.width = CJ_width;
    self.frame = frame;
}
-(void)setCJ_height:(CGFloat)CJ_height{
    CGRect frame = self.frame;
    frame.size.height = CJ_height;
    self.frame = frame;
}
-(void)setCJ_origin:(CGPoint)CJ_origin{
    CGRect frame = self.frame;
    frame.origin = CJ_origin;
    self.frame = frame;
}
-(void)setCJ_size:(CGSize)CJ_size{
    CGRect frame = self.frame;
    frame.size = CJ_size;
    self.frame = frame;
}
-(void)setCJ_centerX:(CGFloat)CJ_centerX{
    CGPoint center = self.center;
    center.x = CJ_centerX;
    self.center = center;
}
-(void)setCJ_centerY:(CGFloat)CJ_centerY{
    CGPoint center = self.center;
    center.y = CJ_centerY;
    self.center = center;
}
-(CGFloat)CJ_x{
    return self.frame.origin.x;
}
-(CGFloat)CJ_y{
    return self.frame.origin.y;
}
-(CGFloat)CJ_left{
    return self.frame.origin.x;
}
-(CGFloat)CJ_top{
    return self.frame.origin.y;
}
-(CGFloat)CJ_right{
    return self.frame.origin.x + self.frame.size.width;
}
-(CGFloat)CJ_bottom{
    return self.frame.origin.y + self.frame.size.height;
}
-(CGFloat)CJ_width{
    return self.frame.size.width;
}
-(CGFloat)CJ_height{
    return self.frame.size.height;
}
-(CGSize)CJ_size{
    return self.frame.size;
}
- (CGPoint)CJ_origin{
    return self.frame.origin;
}
- (CGFloat)CJ_centerX{
    return self.center.x;
}
- (CGFloat)CJ_centerY{
    return self.center.y;
}
+ (instancetype)CJ_viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
@end
