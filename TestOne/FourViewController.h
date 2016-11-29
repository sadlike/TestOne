//
//  FourViewController.h
//  TestOne
//
//  Created by metersbonweios on 16/9/9.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

@interface FourViewController : UIViewController
@property (nonatomic,strong) RACSubject *deleteSignal;
@end
