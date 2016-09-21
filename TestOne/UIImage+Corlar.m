//
//  UIImage+Corlar.m
//  TestOne
//
//  Created by metersbonweios on 16/8/19.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import "UIImage+Corlar.h"

@implementation UIImage_Corlar

- (UIImage *)imageWithCornerRadiuss:(CGFloat)radius
{
    CGRect rect = (CGRect){0.f, 0.f,self.size};
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);CGContextAddPath(UIGraphicsGetCurrentContext(),
                                                                                                                   [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}
@end
