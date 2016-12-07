//
//  UIViewController+Tracking.m
//  TestOne
//
//  Created by metersbonweios on 2016/11/30.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import "UIViewController+Tracking.h"
#import <objc/runtime.h>

@implementation UIViewController (Tracking)
+(void)load
{
    // 交换方法viewWillAppear：
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(viewWillAppear:)),class_getInstanceMethod(self, @selector(tracking_viewWillAppear:)));
    //交换方法viewWillDisappear：
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(viewWillDisappear:)), class_getInstanceMethod(self, @selector(tracking_viewWillDisappear:)));
}
-(void)tracking_viewWillAppear:(BOOL)animated{
    
    [self tracking_viewWillAppear:animated];
    //统计打点事件
    NSString *viewControl = NSStringFromClass([self class]);
    NSString *vcValue =   [self controllerMapWithController:viewControl];
    /*
     *
     */
//    [self getAllCategory];
    
    NSLog(@"当前的viewWillAppearController---%@-匹配的value-%@",NSStringFromClass([self class]),vcValue);
}
-(void)tracking_viewWillDisappear:(BOOL)animated{

    [self tracking_viewWillDisappear:animated];
    /**/
    NSLog(@"当前的WillDisappearController---%@",NSStringFromClass([self class]));
}
-(NSString *)controllerMapWithController:(NSString *)controller
{
    NSString *value=nil;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"controllerValue" ofType:@"plist"];
    NSDictionary *controllerValue=[NSDictionary dictionaryWithContentsOfFile:plistPath];
//    NSLog(@"---%@--当前vc-",controllerValue);
    value = [controllerValue objectForKey:controller];
    
    return  value;
    
}
//输出项目中的所有类
-(void)getAllCategory
{
    int numClasses;
    Class *classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    NSLog(@"number of classe :%d",numClasses);
    if (numClasses>0) {
        classes = (__unsafe_unretained Class*)malloc(sizeof(Class)*numClasses);
        numClasses = objc_getClassList(classes,numClasses);
        for (int i=0; i<numClasses; i++) {
            NSLog(@"classname ----%s",class_getName(classes[i]));
        }
    }
 
}
@end
