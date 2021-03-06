//
//  RootViewController.m
//  TestOne
//
//  Created by metersbonweios on 16/8/31.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import "RootViewController.h"
#import "UIImage+Tint.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "FourViewController.h"
#import "ThreeViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "ReactiveCocoa.h"
#import <Udesk.h>
#import "UdeskSDKManager.h"



@interface RootViewController()
{
    UIImageView *showImgView;
    UIButton *btn;
    CGRect original ;
    CGPoint originalPoint;
    
}
@end

@implementation RootViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
        self.fd_prefersNavigationBarHidden = NO;
        self.fd_interactivePopDisabled=YES;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
      [self changeAn];
}
-(void)initView
{
    showImgView =[[UIImageView alloc]initWithFrame:CGRectMake(50, 200, 100, 100)];
    showImgView.userInteractionEnabled=YES;
   
//    [showImgView setImage:[UIImage imageNamed:@"show"]];
    showImgView.layer.shouldRasterize = YES;//抗锯齿

    //渐变式拉伸 UIImageResizingModeStretch
//     UIImageResizingModeTile,//进行区域复制模式拉伸
//    [showImgView.image resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeTile];
//    showImgView.image=[[UIImage imageNamed:@"icon_backarrow_big"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch];
    
    
    [showImgView setImage:[[UIImage imageNamed:@"show"] imageWithGradientTintColor:[UIColor orangeColor]]];
    [self.view addSubview:showImgView];
    btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 400, 320, 50)];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    showImgView.animationRepeatCount =10000;
    original = showImgView.frame;
    originalPoint = showImgView.center;
    UITapGestureRecognizer *tapImg=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImg:)];
    [showImgView addGestureRecognizer:tapImg];
}
-(void)changeImgViewAnimationWithFrame:(CGRect)rect
{
    [UIView animateWithDuration:1 animations:^{
        showImgView.frame=rect;
        [btn setEnabled:NO];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            showImgView.frame=original;
        } completion:^(BOOL finished) {
            if (finished) {
                [btn setEnabled:YES];
            }
        }];
    }];
}

//改变大小改变frame
-(void)changeFrame
{
    showImgView.frame =CGRectMake(50, 200, 100, 100);
    CGRect rect = CGRectMake(showImgView.frame.origin.x-20, showImgView.frame.origin.y-120, 100, 100);
    [self changeImgViewAnimationWithFrame:rect];
}
//拉伸 改变bounds
-(void)changeBounds
{
    CGRect rect=CGRectMake(0, 0, 300, 120);
    [UIView animateWithDuration:1 animations:^{
        showImgView.bounds=rect;
        [btn setEnabled:NO];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            showImgView.bounds=original;
        } completion:^(BOOL finished) {
            if (finished) {
                [btn setEnabled:YES];
            }
        }];
    }];
}
//转移改变center
-(void)changeCenter
{
    CGPoint newPoint = CGPointMake(showImgView.center.x, showImgView.center.y+100);
    [UIView animateWithDuration:0.3 animations:^{
        showImgView.center=newPoint;
        [btn setEnabled:NO];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            showImgView.center=originalPoint;
        } completion:^(BOOL finished) {
            if (finished) {
                [btn setEnabled:YES];
            }
        }];
    }];
}
//旋转
-(void)changeTrans
{
    CGAffineTransform originalTransform= showImgView.transform;
//    [UIView animateWithDuration:2 animations:^{
//        showImgView.transform =CGAffineTransformMakeRotation(4.0f);
////        showImgView.transform = CGAffineTransformMakeScale(0.6, 0.6);//缩放
////        showImgView.transform =CGAffineTransformMakeTranslation(60, -60);//旋转
//        [btn setEnabled:NO];
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:2 animations:^{
//            showImgView.transform=originalTransform;
//            
//        } completion:^(BOOL finished) {
//            if (finished) {
//                [btn setEnabled:YES];
//            }
//        }];
//    }];
    [UIView animateWithDuration:4 delay:0 options:UIViewAnimationOptionRepeat animations:^{
            [btn setEnabled:NO];
         showImgView.transform =CGAffineTransformMakeRotation(M_PI);
//        CGAffineTransformMakeRotation(-M_PI);也是旋转的

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            showImgView.transform=originalTransform;
  
        } completion:^(BOOL finished) {
            if (finished) {
                [btn setEnabled:YES];
            }
        }];
    }];
}
//透明度
-(void)changeAlpa
{
    [UIView animateWithDuration:2 animations:^{
        showImgView.alpha=0.3;
        [btn setEnabled:NO];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
           showImgView.alpha=1;
        } completion:^(BOOL finished) {
            if (finished) {
                [btn setEnabled:YES];
            }
        }];
    }];
}
//改变背景颜色
-(void)changeBackGroundColor
{
    
    
    [UIView animateKeyframesWithDuration:9.0 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.f relativeDuration:1.0/4 animations:^{
            showImgView.backgroundColor=[UIColor colorWithRed:0.9475 green:0.1921 blue:0.1746 alpha:1.0];
//            [showImgView setImage:[[UIImage imageNamed:@"show"] imageWithGradientTintColor:[UIColor colorWithRed:0.9475 green:0.1921 blue:0.1746 alpha:1.0]]];
        }];
        [UIView addKeyframeWithRelativeStartTime:1.0  relativeDuration:1.0 animations:^{
            showImgView.backgroundColor = [UIColor colorWithRed:0.1064 green:0.6052 blue:0.0334 alpha:1.0];
//                 [showImgView setImage:[[UIImage imageNamed:@"show"] imageWithGradientTintColor:[UIColor colorWithRed:0.1064 green:0.6052 blue:0.0334 alpha:1.0]]];
        }];
        [UIView addKeyframeWithRelativeStartTime:2.0  relativeDuration:2.0  animations:^{
            showImgView.backgroundColor = [UIColor colorWithRed:0.1366 green:0.3017 blue:0.8411 alpha:1.0];
//                 [showImgView setImage:[[UIImage imageNamed:@"show"] imageWithGradientTintColor:[UIColor colorWithRed:0.1366 green:0.3017 blue:0.8411 alpha:1.0]]];
        }];
        [UIView addKeyframeWithRelativeStartTime:3.0  relativeDuration:3.0  animations:^{
           showImgView.backgroundColor =[UIColor  colorWithRed:0.619 green:0.037 blue:0.6719 alpha:1.0] ;
//                 [showImgView setImage:[[UIImage imageNamed:@"show"] imageWithGradientTintColor:[UIColor  colorWithRed:0.619 green:0.037 blue:0.6719 alpha:1.0]]];
        }];
        [UIView addKeyframeWithRelativeStartTime:11 relativeDuration:1.0 animations:^{
//            showImgView.backgroundColor = [UIColor whiteColor];
//                 [showImgView setImage:[[UIImage imageNamed:@"show"] imageWithGradientTintColor: [UIColor whiteColor]]];
        }];
    } completion:^(BOOL finished) {
            NSLog(@"动画结束");
    }];
    
    
}
-(void)toIm
{
    //使用push 推出聊天页面
    UdeskSDKManager *chat = [[UdeskSDKManager alloc] initWithSDKStyle:[UdeskSDKStyle defaultStyle]];
    [chat pushUdeskViewControllerWithType:UdeskIM viewController:self completion:^{
        
    }];
    //    [chat presentUdeskViewControllerWithType:UdeskIM viewController:self completion:^{
    
    //    }];
}
-(void)toRobot
{
//    UdeskSDKManager *robot = [[UdeskSDKManager alloc]initWithSDKStyle:[UdeskSDKStyle defaultStyle]];
//    [robot pushUdeskViewControllerWithType:UdeskIM viewController:self completion:^{
//        
//    }];
    UdeskSDKManager *chat = [[UdeskSDKManager alloc] initWithSDKStyle:[UdeskSDKStyle defaultStyle]];
    
    NSDictionary *dict = @{                                                                                               @"productImageUrl":@"http://img.club.pchome.net/kdsarticle/2013/11small/21/fd548da909d64a988da20fa                           0ec124ef3_1000x750.jpg",
                                                                                                                          @"productTitle":@"测试测试测试测你测试测试测你测试测试测你测试测试测你测试测试测                                       你测试测试测你！",
                                                                                                                          @"productDetail":@"¥88888.088888.088888.0",
                                                                                                                          @"productURL":@"http://www.baidu.com"
                                                                                                                          };
    [chat setProductMessage:dict];
//    [chat pushUdeskViewControllerWithType:UdeskIM viewController:self];
    [chat pushUdeskViewControllerWithType:UdeskIM viewController:self completion:^{
        
    }];
    
    
}
-(void)clickBtn
{
//    [self changeFrame];
//    [self changeBounds];
//    [self changeCenter];
//    [self changeTrans];
//    [self changeAlpa];
//    [self changeAn];
    [self changeBackGroundColor] ;
    [self toRobot];
    
//    [self toIm];
    
    return;
    
    //使用present
//    [chat presentUdeskViewControllerWithType:UdeskIM viewController:self];
    
    
    FourViewController *four=[[FourViewController alloc]init];
//    UINavigationController *NAV=[[UINavigationController alloc]initWithRootViewController:FOU];
    four.deleteSignal=[RACSubject subject];
    [four.deleteSignal subscribeNext:^(id x) {
        NSLog(@"点击了通知按钮---%@",x);
    }];
    
    [self.navigationController pushViewController:four animated:YES];

}
-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"《《《《《《《《《《《《《《《《");
    
}
//左右晃动
-(void)changeAn
{
    //开始动画
    
    CABasicAnimation *momAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    momAnimation.fromValue = [NSNumber numberWithFloat:-0.5];
    
    momAnimation.toValue = [NSNumber numberWithFloat:0.5];
    
    momAnimation.duration = 2;
    
    momAnimation.repeatCount = CGFLOAT_MAX;
    
    momAnimation.autoreverses = YES;
    
    momAnimation.delegate = self;
    
    [showImgView.layer addAnimation:momAnimation forKey:@"animateLayer"];
}
static int timeS=0;
//暂停动画，图片未复位
-(void)tapImg:(UITapGestureRecognizer *)tapGest
{
           UIView *tapView=[tapGest view] ;
    if(timeS%2==0)
    {//暂停
      [self pauseLayer:tapView.layer];
    }
    else
    {//继续
        [self resumeLayer:tapView.layer];
    }
    timeS++;
    [self clickBtn];
    
}
//暂停
-(void)pauseLayer:(CALayer*)layer
{
    
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    layer.speed = 0.0;
    
    layer.timeOffset = pausedTime;
    
}
//重新开始动画
-(void)resumeLayer:(CALayer*)layer{
    
    CFTimeInterval pausedTime = [layer timeOffset];
    
    layer.speed = 1.0;
    
    layer.timeOffset = 0.0;
    
    layer.beginTime = 0.0;
    
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    
    layer.beginTime = timeSincePause;
}
@end
