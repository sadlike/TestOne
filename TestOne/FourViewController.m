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
    UITextField *passWordTextField;
    
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
//    [self.view addSubview:showLabel];
    passWordTextField =[[UITextField alloc]initWithFrame:CGRectMake(50, 250, 250, 50)];
    passWordTextField.backgroundColor=[UIColor clearColor];
    passWordTextField.layer.borderWidth=1.0;
    passWordTextField.layer.borderColor=[UIColor redColor].CGColor;
    [self.view addSubview:passWordTextField];
    
    [nameTextField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"--下一个字符－%@",x);
        showLabel.text=[NSString stringWithFormat:@"%@",x];
        
    }];
//    RACSignal *validNameSignal=[nameTextField.rac_textSignal map:^id(id value) {
//        return nil;
//    }];
    RACSignal *usernameSourceSignal = nameTextField.rac_textSignal;
    RACSignal *filterduset=[usernameSourceSignal filter:^BOOL(id value) {
        NSString *text = value;
        return text.length>3;
        
    }];
    [filterduset subscribeNext:^(id x) {
        NSLog(@"。。。。。%@",x );
        
    }];
    
    [[nameTextField.rac_textSignal filter:^BOOL(id value) {
        NSString *text =value;
        return text.length>3;
     }] subscribeNext:^(id x) {
         NSLog(@"。。长度多于3才输出文本－%@",x );
     }];
    
    [[[nameTextField.rac_textSignal map:^id(NSString * text) {
        
        
        return @(text.length);
        
    }]
      filter:^BOOL(NSNumber * length) {
          
          return [length integerValue]>3;
      }]
     
     subscribeNext:^(id x) {
         
         NSLog(@"输出文本的长度－－－%@",x);
         
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
