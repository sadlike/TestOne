//
//  FourViewController.m
//  TestOne
//
//  Created by metersbonweios on 16/9/9.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import "FourViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "ReactiveCocoa.h"

@interface FourViewController ()
{
        UITextField *nameTextField;
}
@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    nameTextField=[[UITextField alloc]initWithFrame:CGRectMake(50, 150, 250, 50)];
    nameTextField.layer.borderWidth=1.0;
    nameTextField.layer.borderColor=[UIColor redColor].CGColor;
    [self.view addSubview:nameTextField];
    UILabel *showLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 250, 250, 50)];
    showLabel.backgroundColor=[UIColor clearColor];
    showLabel.layer.borderWidth=1.0;
    showLabel.layer.borderColor=[UIColor redColor].CGColor;
    [self.view addSubview:showLabel];
    [nameTextField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"--下一个字符－%@",x);
        showLabel.text=[NSString stringWithFormat:@"%@",x];
        
    }];

}
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"，。。。。。");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
