//
//  ViewController.m
//  TestOne
//
//  Created by metersbonweios on 16/7/29.
//  Copyright © 2016年 metersbonwe. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "YYModel.h"
#import <QuartzCore/QuartzCore.h>

//#include "sys/unistd.h"
//#import "sys/socket.h"t

//宏定义全局并发队列
#define global_quque    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//宏定义主队列
#define main_queue       dispatch_get_main_queue()

static NSString *imgUrlOne=@"http://img7.ibanggo.com/sources/images/goods/MB/289171/289171_90_00.jpg";
static NSString *imgUrlTwo=@"http://img5.ibanggo.com/sources/images/goods/TP/810990/810990_00.jpg";
@interface ViewController ()
{
    User *user;
    
}
@property (nonatomic,strong) UIImageView *testImgView;
@property (nonatomic,strong) UIImageView *showTwoImgView;
@property (nonatomic,strong) UIImageView *leftImgView;
@property (nonatomic,strong) UIImageView *rightImgView;

@end

@implementation ViewController
@synthesize testImgView;
@synthesize showTwoImgView,leftImgView,rightImgView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNewLayber];
    [self addGraphicsLayer];

//    [self initViewLayer];
    
//    [self initView];
//    [self dispatchDownLoadImgView];
}
-(void)initViewLayer
{

    self.view.layer.backgroundColor=[UIColor orangeColor].CGColor;
    self.view.layer.cornerRadius=20.0;
    self.view.layer.frame=CGRectInset(self.view.layer.frame, 20, 20);
    CALayer *sublayer=[CALayer layer];
    sublayer.backgroundColor=[UIColor blueColor].CGColor;
    //阴影起始
    sublayer.shadowOffset = CGSizeMake(0, 3);
    //阴影透明度
    sublayer.shadowOpacity=0.8f;
    sublayer.frame=CGRectMake(30, 30, 128, 192);
    [self.view.layer addSublayer:sublayer];
    //这里设置了内容为图片的层，并且使用边界的颜色和宽度设置了一圈黑色的边界
    sublayer.contents = (id)[UIImage imageNamed:@"show"].CGImage;
    sublayer.borderColor = [UIColor blackColor].CGColor;
    sublayer.borderWidth=2.0f;
    
    /*
     圆角半径和图片内容的注意点
     现在你可能想通过cornerRadius把图片也设置成圆角效果。
     然而问题超过了咱们之前学的范围，如果你在层上设置了图片内容，图像将仍然画出圆角的边界（该属性起不了作用），你可以通过设置子层的masksToBounds为Yes，但如果你这样做，阴影效果将不会出现因为他们被盖掉了。
     
     我找到一个创造两个层的方法，在外的层是有边框和阴影带颜色的层，里面的层包含圆角图像和设置mask，这样在外的层绘制阴影，在里的层包含图像。
     [self initNewLayer]
     */
                           
}
//使用Core Graphics替代图片绘制自定义的层
-(void)addGraphicsLayer
{
    CALayer *customDrawn = [CALayer layer];
    customDrawn.delegate=self;
    customDrawn.backgroundColor=[UIColor greenColor].CGColor;
    customDrawn.frame=CGRectMake(30, 250, 128, 40);
    customDrawn.shadowOffset = CGSizeMake(0, 3);
    customDrawn.shadowRadius = 5.0;
    customDrawn.shadowColor = [UIColor blackColor].CGColor;
    customDrawn.shadowOpacity = 0.8;
    customDrawn.cornerRadius = 10.0;
    customDrawn.borderColor = [UIColor blackColor].CGColor;
    customDrawn.borderWidth=2.0;
    customDrawn.masksToBounds=YES;
    [self.view.layer addSublayer:customDrawn];
    [customDrawn setNeedsDisplay];
}
void MyDrawColoredPattern (void *info,CGContextRef content)
{
    CGColorRef dotColor = [UIColor colorWithHue:0 saturation:0 brightness:0.07 alpha:1.0].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1].CGColor;
    CGContextSetFillColorWithColor(content, dotColor);
    CGContextSetShadowWithColor(content, CGSizeMake(0, 1), 1, shadowColor);
    CGContextAddArc(content, 3, 3, 4, 0, 360, 0);
    CGContextFillPath(content);
    
    CGContextAddArc(content, 16, 16, 4, 0, 360, 0);
    CGContextFillPath(content);
}
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    
    CGColorRef bgColor = [UIColor colorWithHue:0.6 saturation:1.0 brightness:1.0 alpha:1.0].CGColor;
    CGContextSetFillColorWithColor(context, bgColor);
    CGContextFillRect(context, layer.bounds);
    
    static const CGPatternCallbacks callbacks = { 0, &MyDrawColoredPattern, NULL };
    
    CGContextSaveGState(context);
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, patternSpace);
    CGColorSpaceRelease(patternSpace);
    
    CGPatternRef pattern = CGPatternCreate(NULL,
                                           layer.bounds,
                                           CGAffineTransformIdentity,
                                           24,
                                           24,
                                           kCGPatternTilingConstantSpacing,
                                           true,
                                           &callbacks);
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextFillRect(context, layer.bounds);
    CGContextRestoreGState(context);
}
-(void)initNewLayber
{
    CALayer *sublayer=[CALayer layer];
    sublayer.backgroundColor=[UIColor blueColor].CGColor;
    sublayer.shadowOffset=CGSizeMake(0, 3);
    sublayer.shadowOpacity=0.8f;
    sublayer.shadowRadius=5.0f;
    sublayer.shadowColor=[UIColor blackColor].CGColor;
    sublayer.frame=CGRectMake(30, 30, 128, 192);
    sublayer.borderColor = [UIColor blackColor].CGColor;
    sublayer.borderWidth=2.0f;
    sublayer.cornerRadius=10.0f;
    [self.view.layer addSublayer:sublayer];
    
    CALayer *imgLabyer=[CALayer layer];
    imgLabyer.frame=sublayer.bounds;
    imgLabyer.cornerRadius=10.0f;
    imgLabyer.contents=(id)[UIImage imageNamed:@"show"].CGImage;
    imgLabyer.masksToBounds=YES;
    [sublayer addSublayer:imgLabyer];
    
}
-(void)initLabel
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    label.backgroundColor=[UIColor clearColor];
    [self.view addSubview:label];
//    //设置斜体字
//    NSMutableAttributedString *mabstring = [[NSMutableAttributedString alloc]initWithString:@"This is a test of characterAttribute. 中文字符"];
//    CGFontRef font =CGFontCreateWithFontName(CFSTR("Georgia"));
    
}

-(void)initView
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.view.userInteractionEnabled=YES;
    testImgView=[[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    testImgView.userInteractionEnabled=YES;
    
    [self.view addSubview:testImgView];
    showTwoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(200, 50, 100, 100)];
    [self.view addSubview:showTwoImgView];
    leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 250, 100, 100)];
    [self.view addSubview:leftImgView];
    rightImgView  = [[UIImageView alloc]initWithFrame:CGRectMake(200, 250, 100, 100)];
    [self.view addSubview:rightImgView];
//
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImgView)];
    [testImgView addGestureRecognizer:tap];
    
//    或者
}
-(void)tapImgView
{
//    exit(0);

    //在这里我们给图像做一个简单的镜面反射效果，
    CALayer *reflectLayer = [CALayer layer];
    reflectLayer.contents =testImgView.layer.contents;
    reflectLayer.bounds = testImgView.layer.bounds;
    reflectLayer.position = CGPointMake(testImgView.layer.bounds.size.width/2, testImgView.layer.bounds.size.height*1.5);
    
    //在CALayer上所做的Transform，使用的是CATransform3D,其支持x y z 三个方向的旋转，第一参数是旋转的角度，后3个参数，代表的是旋转的向量，可以想想下，在3D坐标下，同样是旋转90度，沿着X轴的旋转和沿着Y轴的旋转，得到的结果是不一样的，在这里设置的值是（M_PI,1,0,0）它不同于在平面内垂直于Z轴旋转180度（M_PI,0,0,1），而是相当于垂直于X轴的翻转。
    reflectLayer.transform =CATransform3DMakeRotation(M_PI, 1, 0, 0);
    //给reflection加个半透明的 layer
    CALayer *blackLayer = [CALayer layer];
    blackLayer.backgroundColor = [UIColor blackColor].CGColor;
    blackLayer.bounds = reflectLayer.bounds;
    blackLayer.position = CGPointMake(blackLayer.bounds.size.width/2, blackLayer.bounds.size.height/2);
    blackLayer.opacity = 0.6;
    [reflectLayer addSublayer:blackLayer];
    
    // 给该reflection加个mask
    CAGradientLayer *mask = [CAGradientLayer layer];
    mask.bounds = reflectLayer.bounds;
    mask.position = CGPointMake(mask.bounds.size.width/2, mask.bounds.size.height/2);
    mask.colors = [NSArray arrayWithObjects:
                   (__bridge id)[UIColor clearColor].CGColor,
                   (__bridge id)[UIColor whiteColor].CGColor, nil];
    mask.startPoint = CGPointMake(0.5, 0.35);
    mask.endPoint = CGPointMake(0.5, 1.0);
    reflectLayer.mask = mask;
    // 作为layer的sublayer
    [testImgView.layer addSublayer:reflectLayer];
    
}
-(void)handlerData
{
   NSDictionary *userDic = [self getJsonWithJsonName:@"SimpleModel"];
    user = [User yy_modelWithDictionary:userDic];
    NSLog(@"user－－－%@",user);
    
    // Convert model to json:
    NSDictionary *jsonConvert = [user yy_modelToJSONObject];
    NSLog(@"jsonCovert-%@",jsonConvert);
    
}
//获取json数据，读取本地点json数据
-(NSDictionary *)getJsonWithJsonName:(NSString *)jsonName{
    NSString *path = [[NSBundle mainBundle]pathForResource:jsonName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}
- (NSArray *) getJsonArrayWithJsonName:(NSString *)jsonName {
    //从本地读取json数据（这一步你从网络里面请求）
    NSString *path = [[NSBundle mainBundle]pathForResource:jsonName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

-(void)dispatchDownLoadImgView
{
    //创建一个队列组
    dispatch_group_t group = dispatch_group_create();
    __weak __typeof(self) weakSelf = self;
    
    //下载任务1
    __block UIImage *image1=nil;
    dispatch_group_async(group, global_quque, ^{
        image1 = [self imageWithUrl:imgUrlOne];
        [self handlerData];
        
        NSLog(@"显示图片1---%@－－－%@",[NSThread currentThread],user.name);
        user.name=@"wwp";
        
    });
    //下载任务2
    __block UIImage *image2 = nil;
    dispatch_group_async(group, global_quque, ^{
        image2= [self imageWithUrl:imgUrlTwo];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            weakSelf.showTwoImgView.image=image2;
            
        });
        
    });
    //12 同是下载
    
    dispatch_group_notify(group, main_queue, ^{
        
        weakSelf.testImgView.image =image1;
        //        weakSelf.showTwoImgView.image=image2;
        //合并两张图片
        //注意最后一个参数是浮点数（0.0），不要写成0。
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 100), NO, 0.0);
        [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
        [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
         weakSelf.leftImgView.image=UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
        NSLog(@"图片合并完成---%@--%@",[NSThread currentThread],user.name);
    });
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"...one1.");
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-2");
    });
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-1");
    });
    NSLog(@"..two.");
    dispatch_barrier_async(concurrentQueue, ^(){
        NSLog(@"dispatch-barrier");
    });
        NSLog(@"..three.");
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-3111");
    });
    NSLog(@"whre");
    dispatch_async(concurrentQueue, ^(){
        NSLog(@"dispatch-4");
    });
    NSLog(@"..four.");
}
-(UIImage *)imageWithUrl:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSError *error;
    NSData *data = [[NSData alloc]initWithContentsOfURL:url options:0 error:&error];
    if (error) {
        return nil;
    }

    UIImage *image =[UIImage imageWithData:data];
        
    return image;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
