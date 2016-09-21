//
//  VHSSteps.h
//  TestOne
//
//  Created by metersbonweios on 16/8/31.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VHSSteps : NSObject
//你的步数的模型
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,assign) int record_no;
@property (nonatomic,strong) NSString *record_time;
@property (nonatomic,assign) int step;
//g是一个振动幅度的系数，通过一定的判断条件来判断是否做一步
@property (nonatomic,assign) double g;
@end
