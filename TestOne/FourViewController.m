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
#import <Security/Security.h>
@interface FourViewController ()
{
    UITextField *nameTextField;
    UITextField *passWordTextField;
    UIButton *btn;
    
    
}

@property(nonatomic,strong)RACCommand *conmmand;
@property (nonatomic,strong)RACSignal *tempSignal;

@end

@implementation FourViewController
@synthesize deleteSignal;

-(void)textKit
{
    UITextView *textView =[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 600)];
    textView.text=@"据中国民航网消息，12月1日晚22时20分，首都机场一架由北京飞往首尔仁川机场的外航货运航班在起飞后左侧发动机起火，华北空管局管制员立即启用发动机起火处置预案，指挥其余65架在地面及空中航班进行等待、避让、盘旋，保障起火航班安全返航。据了解，当晚22时20分，该趟航班从首都机场中跑到由南向北起飞，在离地100米后，即将移交给下一个管制单位时，塔台管制员发现其左侧发动机着火，立即向机组通报，机组回复稍等。稍后塔台管制员再次提醒机组检查并向机组询问检查情况，机组第二次回复稍等。经机组检查后通报塔台，确认发动机失效，并宣布紧急状态，要求立即返场落地。主任管制员随即启用发动机起火处置预案，并通知进近主管，协商落地跑道为东跑道，并向首都机场相关单位通报特情。随后，管制员立刻指挥其他飞机避让，通过雷达引导起火航班尽快返航，并限制航班起飞。主任管制员通知消防、救护立即出动，并向应急处置总指挥、东塔台主管通报就近落地，跑道为东跑道。22点26分，消防救护单位到指定地点待命，管制指挥清空相关滑行道、跑道。同时，指挥其下降高度，指挥其他航空器避让，并询问机上人数和有无危险货物。接着，管制员指挥其尽快加入落地程序，并向其通报接地点距离。同时管制员还向其询问着陆重量是否会影响着陆，并再次确认机组能否安全落地。2分钟后，东塔台主任管制员指挥地面航班进行避让，为防止因东跑道停用造成起飞飞机长时间的等待，管制员调整东跑道起飞航班使用中跑道出港。在此期间，进近管制员指挥其他冲突航班在空中进行避让。";
    [self.view addSubview:textView];
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(110, 100, 100, 102)];
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(110, 110, 100, 102)];
    [imgView setImage:[UIImage imageNamed:@"image.png"]];
    [imgView setContentMode:UIViewContentModeScaleToFill];
    [textView addSubview:imgView];
    textView.textContainer.exclusionPaths =@[circle];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

//    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 60, 300, 400)];
//    [self.view addSubview:webview];
//    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    [self textKit];
    return;
    
    btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(50, 50, 100, 50)];

    [self.view addSubview:btn];

    [btn addTarget:self action:@selector(clickme) forControlEvents:UIControlEventTouchUpInside];
    /*rac_signalForSelector 貌似不管用 7.1 代替代理*/
    [[btn rac_signalForSelector:@selector(clickme)] subscribeNext:^(id x) {
        NSLog(@"点击了按钮");
        
    }];
    //7.2 kvo  监听center属性改变转换为信号 只要值变了 就会发送信号
    [[btn rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        NSLog(@"-------sdfsd-----%@",x);
        
    }];
//    7.3 监听事件  把按钮点击事件转换为信号  点击按钮 就会发送信号
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"btn 被点击了");
        
    }];
    
    
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
    
    //7.4 代替通知   把监听到的通知转换信号
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"键盘弹出了没有啊");
        
    }];
    
    [self dispathqueue];
    
    //7.6 处理多个请求  都返回结果的时候 才做统一处理
    RACSignal *request = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       //发送请求
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    RACSignal *rquestTwo=[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"发送请求2"];
        return nil;
        
    }];
    //使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    [self rac_liftSelector:@selector(updateUIWithRl:r2:) withSignalsFromArray:@[request,rquestTwo]];
    

}
//更新ui
-(void)updateUIWithRl:(id)data r2:(id)dataTwo
{
    NSLog(@"更新ui--%@---%@",data,dataTwo);
    
}
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"，。。。。。");
    
}
//http://blog.csdn.net/jeffasd/article/details/51025703
//五个案例让你明白GCD死锁
//serial  dispatch queue  串行队列     123  顺序有序123，，
// concurrent dispatch queue  并行队列  123  顺序先后不一定

// 串行与并行 针对的是队列   同步与异步 针对的是线程

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
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //block调用时刻 每当有订阅者订阅信号，就会用block
        [subscriber sendNext:@1];
        //如果不在发送数据，最好在发送信号完成，内部调用 disposable 取消订阅信号
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            //信号被毁了  当信号完成或者发送错误,会自动执行这个block 取消订阅信号
            //执行block后  当前信号就不再订阅了
            NSLog(@"信号被销毁");
            
        }];
        
    }];
    //订阅信号 才会激活信号
    [signal subscribeNext:^(id x) {
        //block调用时刻:每当哟u 信号发出数据，机会调用block
        
        NSLog(@"接收到信号数据:%@",x);
        
    }];
    //RACSubscriber:表示订阅者的意思，用于发送信号  是一个协议 不是一个类，只要尊从这个协议，并且实现方法才能成为订阅着 ,通过create创建的信号 都有一个订阅着 帮助他发送数据.
    //RACDisposable:用于取消订阅或者清理资源 当信号发送完成或者发送错误的时候 就会自动触发它 。使用场景  不想坚挺某个信号的时候 可以通过它主动取消订阅信号。
    
    //RACSubject:信号提供者，自己可以当信号,又能发送信号.
    //     通常用来代替代理 有了它 就不必要定义代理了。
    //RACReplaySubject:重复提供信号类，RACSubject的子类.
    
//    RACReplaySubject与RACSubject的区别
//    1.RACReplaySubject可以先发送信号  在订阅信号, 但是 RACSubject就不可以。
    //使用场景1.如果一个信号 每被订阅一次，就需要吧之前的值重复发一遍，就得使用重复提供信号类
    //使用场景2。可以设置capacity数量来限制缓存的value的数量，即只缓存最新的几个值。
    
//    RACSubject与RACReplaySubject简单使用
    [self racSubject];
    [self racReplaySubject];
    [self racTuple];
    [self racMulticastConnection];
    [self racCommand];
    [self racDefine];
    RAC(btn,enabled) = [RACSignal combineLatest:@[passWordTextField.rac_textSignal,
                                                  nameTextField.rac_textSignal,
                                                 ] reduce:^(NSString *username,NSString *password){
                                                      return @(username.length>0&&password.length>0);
                                                 }];
    
//    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
//    [animator addBehavior:];
    
    
    
    

}
-(void)racSubject
{
    //    RACSubject使用步骤。
    //    1.创建信号[RACSubject subject];  与RACSignal不一样 创建信号时 没有block
    //    2.订阅信号-(RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    //    3.发送信号 sendNext:(id)value
    //racsubject ：底层实现与racsignal不一样
    //    1.调用 subscribenext订阅信号 只是把订阅着保存起来 并且订阅着的nextblock已经赋值了
    //    2.调用sendNext发送信号便利刚刚保存的所有订阅着 一个一个调用订阅着的nextblock.
    //    1.创建信号
    RACSubject *subject = [RACSubject subject];
    //    2.订阅信号
    [subject subscribeNext:^(id x) {
        //block调用时刻 当信号发出新值，就会调用。
        NSLog(@" 第一个调用者---%@",x);
    }];
    [subject subscribeNext:^(id x) {
        NSLog(@"第二个订阅着---%@",x);
    }];
    //3 发送信号
    [subject sendNext:@"1"];
}
-(void)racReplaySubject
{
//    1.创建信号 [RACReplaySubject subject]; 与racsignal 不一样 创建信号没有block
//    2.可以先订阅信号，也可以先发送信号
//    2.1订阅信号  -(RACDisposable*)subscribeNext:(void(^)(id x))nextBlock
//    2.2发送信号  sendNext:(id)value
//    RACReplaySubject 底层实现与racSubject不一样
//    1.调用sendNext发送信号 把值保存起来 然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextblock.
//    2.调用subscribeNext 订阅信号 遍历保存的所有值 一个一个调用订阅者的nextblock
//    ..如果想当一个信号被订阅 就重复播放之前所有值 需要先发送信号  再订阅信号  也就是闲保存值再订阅值。
//    1订阅信号
    RACReplaySubject *replaySubject =[RACReplaySubject subject];
    //2.发送信号
    [replaySubject sendNext:@"1"];
    [replaySubject sendNext:@"2"];
    //订阅信号
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者接收到的数据 ---%@",x);
    }];
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者接收到的数据 ---%@",x);
    }];
}
//元组
-(void)racTuple
{
    //元组类，类似数组
//    RACSequence:rac中的集合类，用于代替nsarray，nsdic,可以用它来快速便利数组和字典
//    1.字典传模型
//    1.遍历数组
    NSArray *numbers =@[@1,@2,@3,@4,@"abc"];
    //这里其实是三部
//    1.把数组转换成集合 racsequence numbers.rac_sequence
//    2.把几何racsequence 转换racsignal信号类，numbers.rac_sequence.signal
//    第三部：订阅信号 激活信号 会自动把集合中的所有值 遍历出来
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"1---便利数组----%@",x);
    }];
//    2.遍历字典，遍历出来的健值对会包装成ractuple(元组对象)
     NSDictionary *dict = @{@"name":@"xmg",@"age":@18,@"gender":@"男"};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        //解包元组，会把元组的值 按顺序给参数里面的变量赋值
        RACTupleUnpack(NSString *key,NSString *value) = x;
        //此句的写法 相当于 NSString *key =x[0];NSString *value =x[1];
        NSLog(@"--key---%@----value---%@",key,value);
        
    }];
    
    
}
//RACTupleUnpack
-(void)racMulticastConnection
{
//    RACMulticastConnection 用于当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block 造成副作用.可以使用这个类处理
//    RACMulticastConnection通过racsignal的-publish或者-muticast：方法来创建
// RACMulticastConnection使用步骤
//    1创建信号+(RACSignal *)createSignal:(RACDisposable *(^)(id <RACSubscriber> subscriber))didSubscribe
//    2创建链接  RACMulticastConnection *connect = [signal publish];
//    3.订阅信号，注意 订阅的不再是之前的信号 ，而是链接的信号 [connect.signal subscribeNext:nextBlock];
//    4.链接[connect connect];
// RACMulticastConnection 底层原理：
//    1 创建connect，connet.sourceSignal ->RACSignal(原始信号) connect.signal ->RACSubject
//    2.订阅connect.signal, 会调用 RACSubject的subscribeNext,创建订阅者，而且把订阅着保存起来 不会执行block
//    3.[connect connect] 内部会订阅RACSignal(原始信号),并且订阅者是RACSubject
//       3.1 订阅原始信号，就会调用原始信号中的didSubscribe
//       3.2 didSubscribe, 拿到订阅着调用sendNext 其实调用RACSubject的sendNext
//    4. RACSubject的sendNext  会遍历RACSubject 所有订阅着发送信号。
//          4.1因为刚刚第二部 都是在订阅RACSubject,因此会拿到第二步所有的订阅者，调用他们的nextBlock
    
    //1.创建请求信号  执行完会发现 2次发送请求
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"2次发送请求");
        return nil;
    }];
    //2.订阅信号
    [signal subscribeNext:^(id x) {
        NSLog(@"接收数据");
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"再次接收数据");
    }];
//    RACMulticastConnection;解决重复请求问题
//    1.创建信号
    RACSignal *sigle = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送请求");
        [subscriber sendNext:@"abc"];
        return nil;
    }];
    //2.创建链接
    RACMulticastConnection *connect = [sigle publish];
    //3.订阅信号    注意 订阅信号，也不能激活信号，只是保存订阅者到数组，必须通过链接。
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者-信号");
    }];
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者 二信号");
    }];
//    4.链接 激活信号
    [connect connect];
}
//RACCommand :rac中用于处理事件的类，可以把事件如何处理，事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程  使用场景：坚挺按钮点击，网络请求

-(void)racCommand
{
    //一。raccommand使用步骤
//    1.创建命令 initWithSiganlBlock:(RACSignal* (^)(id input))signalBlock
//    2.在signalBlock中 创建 racsignal 并且作为signalBlock的返回值
//    3.执行命令 -(racsignal *)execute:(id)input
//    二。raccommand  使用注意
//    1.signalBlock必须要返回一个信号 ，不能传nil
//    2.如果不想要传递信号，直接创建空的信号 【racsignal empty】;
//    3.raccommand 中信号如果数据传递完，必须调用【subscriber sendcompleted】这时命令彩绘执行完毕，否则永远处于执行中
//    三。raccommand设计思想， 内部signalblock 位什么要返回一个信号，这个信号有什么用。
//    1.在rac开发中通常会吧网络请求封装到raccommand 直接执行某个raccommand就能发送请求
//    2.当raccommand 内部请求到数据的时候 需要把请求的数据传递给外界，这时候就需要通过signalblock返回的信号传递了／
//    四。如何拿到raccommand中的 返回信号发出的数据
//    1.raccommand 有个执行信号源 executionSignals，这个是signal of signals (信号的信号) 意思是信号发出的数据是信号  不是普通的类型
//    2.订阅 executionsignals 就能拿到raccommand中返回的信号 然后订阅signalblock 返回的信号就能获取发出的值
//    五／ 监听当前命令是否正在执行executing
//    六 使用场景 监听按钮点击 网络请求deng

    
    
    //1.创建命令
    RACCommand  *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"执行命令");
        //1/创建空信号,必须返回信号 return [RACSignal empty];
//        2.创建信号 用来传递数据
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"请求数据"];
            //数据传递万 最好调用sendcompleted 这时命令才执行完毕
            [subscriber sendCompleted];
            return nil;
        }];
        
    }];
    //强引用命令 不要被销毁，否则接受不到数据
    _conmmand = command;
    //3.执行命令
    
    [self.conmmand execute:@1];
    //4.订阅raccommand中的信号
    [command.executionSignals subscribeNext:^(id x) {
        [x subscribeNext:^(id x) {
            NSLog(@"---订阅raccommand--%@",x);
        }];
        
    }];
    //rac高级用法  switchtolatest 用户signal of  signals 获取 signal of  signals 发出的最新信号，也就是 可以字节拿到raccommand中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"————-%@---command",x);
        
    }];
    //5 监听命令是否执行完毕  默认会来一次，可以直接跳过，skip 表示跳过第一次信号
    [[command.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            NSLog(@"正在执行");
        }
        else
        {
            NSLog(@"执行完成");
        }
    }];
    //
    //RACScheduler:rac中的队列 用gcd封装
    //    RACUnit：表示stream不包含有意义的值，也就是看到这个 可以直接理解为nil
    //    RACEvent  把数据包封装成信号事件（signal event）它主要通过racsignal 的-materialize 来使用
    
//    七。reactivecocoa 开发中常见用法
// ****************************************   常见用法     *************************

    //7.1代替代理
        //rac_signalForSelector: 用于代替代理
    //7.2代替kvo

    //rac_valuesAndChangesForKeyPath:用于监听某个对象的属性改变
    //7.3监听事件

    //rac_signalForControlEvents:用于监听某个事件
    //7.4代替通知

    //rac_addObserverForName:用于监听某个通知
    //7.5监听文本框文字改变

    //rac_textSignal:只要文本框发出改变 就会发出这个信号
    //7.6处理界面有多次请求时，需要都获取到数据时，才能展示界面
    //rac_liftSelector:withSignalsFromArray:Signals:当传入的signals（信号数组） 每一个signal都至少sendnext过一次，就会去出发第一个selector参数的方法
    //注意  几个信号 参数一的方法就几个参数 每个参数对应信号发出的数据

    
}
//rac 常见宏
-(void)racDefine
{
//1.RAC(TARGET,[KEYPAHT,[NIL_VALUE]]);用于给某个对象的某个属性绑定
    //基本用法
    //只要文本框文字改变，就会修改label的文字
    RAC(btn,titleLabel.text) = passWordTextField.rac_textSignal;
    
//2.RACObserve(<#TARGET#>, <#KEYPATH#>) 监听某个对象的某个属性 返回的是信号
    [RACObserve(self.view, center) subscribeNext:^(id x) {
        NSLog(@"racobserve---%@",x);
        
    }];
//3.@weakify(obj);@strongify(obj) 一般是配套使用 解决循环引用问题
//4.racTuplePack：把数据包装成ractuple(元组类)
    RACTuple *tuple =RACTuplePack(@10,@20);
         NSLog(@"tuple---%@",tuple);
//5.ractupleUnpack:把ractuple（元组类）解包成对应的数据
      RACTuple *tupleu =RACTuplePack(@"xmg",@20);
    //解包元组会把元组的值，按顺序给参数里面的变量赋值
//    name=@"xmg"  age=@20
    RACTupleUnpack(NSString *name,NSNumber *age ) = tupleu;
    NSLog(@"name--%@----age===%@",name,age);
    
    
}
-(void)clickme
{
    btn.center=CGPointMake(150, 100);
    
    //通知第一个控制器 按钮被点击了
    if(self.deleteSignal)
    {
        //有值才通知
        [self.deleteSignal sendNext:@"点击了啥啊"];
        
    }
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
-(void)operation
{
    NSBlockOperation *theOp=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"beginning----");
    }];
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
