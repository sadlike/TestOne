//
//  UIImage+Tint.m
//  TestOne
//
//  Created by metersbonweios on 16/9/2.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)

-(UIImage *)imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendModel:kCGBlendModeDestinationIn];
    

}
-(UIImage *)imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendModel:kCGBlendModeOverlay];
}
//-(void)drawInRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetAllowsAntialiasing(context, true);
//    CGContextSetShouldAntialias(context, true);
//}
-(UIImage *) imageWithTintColor:(UIColor *)tintColor blendModel:(CGBlendMode)blendModel
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    [self drawInRect:bounds blendMode:blendModel alpha:1.0f];
    if (blendModel!=kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    UIImage *tintedImg=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImg;
    
}
@end
