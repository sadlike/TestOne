//
//  UIImage+Tint.h
//  TestOne
//
//  Created by metersbonweios on 16/9/2.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)
-(UIImage *)imageWithTintColor:(UIColor *)tintColor;
-(UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;
//-(void)drawInRect:(CGRect)rect;

@end
