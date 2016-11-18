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
    //jhjhkjhkjhkjh
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 60, 300, 400)];
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    
    
    
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
    
    
    [self dispathqueue];
    
    

}
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"，。。。。。");
    
}
//http://blog.csdn.net/jeffasd/article/details/51025703
//五个案例让你明白GCD死锁
//serial  dispatch queue  串行队列     123  顺序有序123，，
// concurrent dispatch queue  并行队列  123  顺序先后不一定

// 串行与并行 针对的是队列   同步与异步 针对的是现成

//dispatch_get_global_queue  全局队列 也是一个并行队列
//dispatch_get_main_queue    主队列 在主线程中国年运行，因为主线程就一个  所以这是一个串行队列


-(void)dispathqueue
{
//    dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);//串行队列
//    dispatch_queue_create("com.demo.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);//并行队列
//    dispatch_sync(...., ^{block    //同步
//    });
//    dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)//异步
    
//    [self testDispatchOne];
//    [self testDispatchTwo];
    
    
}
-(void)testDispatchOne
{
    NSLog(@"****1******任务1");//
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"****1******任务2");
    });
    NSLog(@"*****1*****任务3");
}
-(void)testDispatchTwo
{
    NSLog(@"*****2*****任务1");
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"****2******任务2");
    });
    NSLog(@"*****2*****任务3");
}
-(void)testDispatchThree
{
//    dispatch_queue_t quensse = dispatch_queue_create(@"com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
    
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
