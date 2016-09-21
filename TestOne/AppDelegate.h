//
//  AppDelegate.h
//  TestOne
//
//  Created by metersbonweios on 16/7/29.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "VHSSteps.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) CMMotionManager *motionManager;   // 加速度传感器

@end

