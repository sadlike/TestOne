//
//  AppDelegate.m
//  TestOne
//
//  Created by metersbonweios on 16/7/29.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "VHSSteps.h"

// 计步器开始计步时间（秒）
#define ACCELERO_START_TIME 2

// 计步器开始计步步数（步）
#define ACCELERO_START_STEP 8

// 数据库存储步数采集间隔（步）
#define DB_STEP_INTERVAL 100
@interface AppDelegate ()
{
    RootViewController *rvc;
    NSMutableArray *arrAll;                 // 加速度传感器采集的原始数组

}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    rvc=[[RootViewController alloc]init ];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:rvc];
    
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];
//    [self initAccelerometer];
//    [self startAccelerometer];
    
    return YES;
}
//加速计
-(void)initAccelerometer
{
    self.motionManager = [[CMMotionManager alloc]init];
    //检查穿干洗到底在设备上是否可用
    if(!self.motionManager.accelerometerAvailable)
    {
        return;
    }else
    {//更新频率是100hz
        self.motionManager.accelerometerUpdateInterval = 1.0/40;
        
    }
}
-(void)startAccelerometer
{
    if (!self.motionManager.isAccelerometerAvailable) {
        //此句代码是用来查看加速度器的状态是否启动
        //采集原始数据
        if(arrAll==nil)
        {
            arrAll = [[NSMutableArray alloc]init];
        }else
        {
            [arrAll removeAllObjects];
        }
        
        /*
         在swift中，可以使用!和?来表示一个对象是optional的还是non-optional，如view?和view!。而在Objective-C中则没有这一区分，view即可表示这个对象是optional，也可表示是non-optioanl。
         
         这样就会造成一个问题：在Swift与Objective-C混编时，Swift编译器并不知道一个Objective-C对象到底是optional还是non-optional，因此这种情况下编译器会隐式地将Objective-C的对象当成是non-optional。
         
         为了解决这个问题，苹果在Xcode 6.3引入了一个Objective-C的新特性：nullability annotations。
         
         这一新特性的核心是两个新的类型注释：__nullable和__nonnull。从字面上我们可以猜到，__nullable表示对象可以是NULL或nil，而__nonnull表示对象不应该为空。当我们不遵循这一规则时，编译器就会给出警告。
         
         */
    //获取accelerometer数据 队列来显示－－主动获取加速计的数据
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            //三个方向的加速度值
            double x = accelerometerData.acceleration.x;
            double y = accelerometerData.acceleration.y;
            double z = accelerometerData.acceleration.z;
            //g 是一个double 值  判断是否计算为1步
            //sqrt 平方根函数  pow(x,y)求 x 的 y 次幂/方
            double g = sqrt(pow(x, 2)+pow(y, 2)+pow(z, 2))-1;
          //数据保存在步数模型里
            VHSSteps *stepsAll = [[VHSSteps alloc]init];
            stepsAll.date=[NSDate date];
            NSDateFormatter *df = [[NSDateFormatter alloc]init];
            df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *strYmd = [df stringFromDate:stepsAll.date];
            df = nil;
            stepsAll.record_time= strYmd;
            stepsAll.g = g;
            //加速度传感器采集数组
            [arrAll addObject: stepsAll];
            
            //每采集10条，大约1.2秒 进行数据分析
            if(arrAll.count==10)
            {
                //步数缓存数组
                NSMutableArray *arrBuff =[[NSMutableArray alloc]init];
                arrBuff = [arrAll copy];
                
            }
        }];
        
        
        
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
