//
//  UIView+WAIExtension.m
//  CJScrollPage
//
//  Created by Eric on 2021/1/4.
//

#import "UIView+WAIExtension.h"

@implementation UIView (WAIExtension)

- (void)setWAI_x:(CGFloat)WAI_x{
    CGRect frame = self.frame;
    frame.origin.x = WAI_x;
    self.frame = frame;
}
-(void)setWAI_y:(CGFloat)WAI_y{
    CGRect frame = self.frame;
    frame.origin.x = WAI_y;
    self.frame = frame;
}
-(void)setWAI_top:(CGFloat)WAI_top{
    CGRect frame = self.frame;
    frame.origin.y = WAI_top;
    self.frame = frame;
}
-(void)setWAI_left:(CGFloat)WAI_left{
    CGRect frame = self.frame;
    frame.origin.x = WAI_left;
    self.frame = frame;
}
-(void)setWAI_right:(CGFloat)WAI_right{
    CGRect frame = self.frame;
    frame.origin.x = WAI_right - frame.size.width;
    self.frame = frame;
}
-(void)setWAI_bottom:(CGFloat)WAI_bottom{
    CGRect frame = self.frame;
    frame.origin.y = WAI_bottom - frame.size.height;
    self.frame = frame;
}
-(void)setWAI_width:(CGFloat)WAI_width{
    CGRect frame = self.frame;
    frame.size.width = WAI_width;
    self.frame = frame;
}
-(void)setWAI_height:(CGFloat)WAI_height{
    CGRect frame = self.frame;
    frame.size.height = WAI_height;
    self.frame = frame;
}
-(void)setWAI_origin:(CGPoint)WAI_origin{
    CGRect frame = self.frame;
    frame.origin = WAI_origin;
    self.frame = frame;
}
-(void)setWAI_size:(CGSize)WAI_size{
    CGRect frame = self.frame;
    frame.size = WAI_size;
    self.frame = frame;
}
-(void)setWAI_centerX:(CGFloat)WAI_centerX{
    CGPoint center = self.center;
    center.x = WAI_centerX;
    self.center = center;
}
-(void)setWAI_centerY:(CGFloat)WAI_centerY{
    CGPoint center = self.center;
    center.y = WAI_centerY;
    self.center = center;
}
-(CGFloat)WAI_x{
    return self.frame.origin.x;
}
-(CGFloat)WAI_y{
    return self.frame.origin.y;
}
-(CGFloat)WAI_left{
    return self.frame.origin.x;
}
-(CGFloat)WAI_top{
    return self.frame.origin.y;
}
-(CGFloat)WAI_right{
    return self.frame.origin.x + self.frame.size.width;
}
-(CGFloat)WAI_bottom{
    return self.frame.origin.y + self.frame.size.height;
}
-(CGFloat)WAI_width{
    return self.frame.size.width;
}
-(CGFloat)WAI_height{
    return self.frame.size.height;
}
-(CGSize)WAI_size{
    return self.frame.size;
}
- (CGPoint)WAI_origin{
    return self.frame.origin;
}
- (CGFloat)WAI_centerX{
    return self.center.x;
}
- (CGFloat)WAI_centerY{
    return self.center.y;
}
+ (instancetype)CJ_viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
@end
