//
//  UIControl+Tracking.m
//  TestOne
//
//  Created by metersbonweios on 2016/11/30.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import "UIControl+Tracking.h"
#import <objc/runtime.h>
@implementation UIControl (Tracking)
+(void)load
{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(sendAction:to:forEvent:)), class_getInstanceMethod(self, @selector(tracking_sendAction:to:forEvent:)));
}
-(void)tracking_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [self tracking_sendAction:action to:target forEvent:event];
   
    NSString *method = NSStringFromSelector(action);
   NSLog(@"点击事件能接收到吗-------%@---%@------%@",method,target,event);
    
    
}
@end
