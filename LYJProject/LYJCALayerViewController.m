//
//  LYJCALayerViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/2/18.
//

#import "LYJCALayerViewController.h"
#import "LYJTimeLoop.h"
#import "LYJProxy.h"

@interface LYJCALayerViewController ()
@property (nonatomic, weak) CALayer *layer;
@property (nonatomic, weak) CALayer *second;

@property (nonatomic, copy) NSString *timerTag;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) CADisplayLink *link;

@end

@implementation LYJCALayerViewController

- (void)dealloc {
    NSLog(@"------>>>>>> %s", __func__);
    [LYJTimeLoop cancelTimeLoop: self.timerTag];
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (self.link) {
        [self.link invalidate];
        self.link = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
//    CAAnimation
//    CAAnimationGroup
//    CATransition
//    CABasicAnimation
//    CAKeyframeAnimation
    
    //[self example_one];
    
    //[self example_two];
    
    [self example_three];
}

- (void)example_one {
    
    UIView *redVw = [[UIView alloc] init];
    redVw.frame =CGRectMake(100, 100, 100, 100);
    redVw.backgroundColor = UIColor.redColor;
    
    //边框
    redVw.layer.borderWidth = 10;
    redVw.layer.borderColor = UIColor.grayColor.CGColor;
    
    //阴影
    redVw.layer.shadowOffset = CGSizeMake(5, 5);
    redVw.layer.shadowColor = UIColor.blueColor.CGColor;
    redVw.layer.shadowRadius = 6;
    redVw.layer.shadowOpacity = 1;
    
    //圆角
    redVw.layer.cornerRadius = 50;
    redVw.layer.masksToBounds = YES;
    
    //设置图片内容
    redVw.layer.contents = (__bridge id)[UIImage imageNamed: @"me"].CGImage;
    
    
    //bounds / position
    //redVw.layer.bounds = CGRectMake(0, 0, 200, 200);
    //redVw.layer.position = CGPointZero;
    //redVw.layer.frame - 给layer设置frame，在取值时会有问题。使用bounds、和 position。
    
    
    [self.view addSubview: redVw];
    self.layer = redVw.layer;
    
}

- (void)example_two {
    CALayer *layer = [CALayer layer];
    layer.position = CGPointMake(200, 200);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = UIColor.orangeColor.CGColor;
    layer.contents = (__bridge id)[UIImage imageNamed:@"me"].CGImage;
    
    [self.view.layer addSublayer: layer];
    self.layer = layer;
}

- (void)example_three {
    
    //时钟
    
    CALayer *clock = [CALayer layer];
    clock.bounds = CGRectMake(0, 0, 200, 200);
    clock.position = CGPointMake(self.view.center.x, 200);
    
    clock.cornerRadius = 100;
    clock.masksToBounds = YES;
    
    clock.contents = (__bridge id)[UIImage imageNamed:@"clock"].CGImage;
    [self.view.layer addSublayer:clock];
    
    
    CALayer *second = [CALayer layer];
    second.bounds = CGRectMake(0, 0, 2, 100);
    second.position = clock.position;
    second.backgroundColor = UIColor.redColor.CGColor;
    
    /**
     设置 锚点 - 定位点, 表示层边界矩形的中心
     如，(0,0)、(1,0)、(0,1)、(1,1)，表示矩形的中心点在四个角的位置，
     */
    second.anchorPoint = CGPointMake(0.5, 0.8);
    [self.view.layer addSublayer:second];
    self.second = second;
    
    

//    //开启定时器
//    __weak __typeof(self) weakSelf = self;
//    self.timerTag = [LYJTimeLoop timeLoopTodoSomething:^{
//        __strong __typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf timeChange];
//    } delayTime:0 stepTime:1 repeat:YES mainThread:YES];
    
    
//    {
//        //开启定时器 - 需要解决循环饮用问题，target 指向别的类
//        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:[LYJProxy proxyWithTarget:self] selector:@selector(timeChange)];
//        self.link = link;
//        //加入到runloop中，帧数刷新，一秒60帧
//        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode: NSRunLoopCommonModes];
//    }
//
//
//    {
//        //开启定时器 - 需要解决循环饮用问题，target 指向别的类
//        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[LYJProxy proxyWithTarget:self] selector:@selector(timeChange) userInfo:nil repeats:YES];
//        self.timer = timer;
//        [self timeChange];
//    }
    
}

- (void)timeChange {
    NSLog(@"-------->>>>>>>");
    
    //获取时间角度，一秒钟旋转的角度
    CGFloat angle = 2 * M_PI / 60;
    
    NSDate *date = [NSDate date];
    
//    {
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"ss";
//        CGFloat second = [[formatter stringFromDate:date] floatValue];
//    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    CGFloat second = [calendar component:NSCalendarUnitSecond fromDate:date];
    
    self.second.affineTransform = CGAffineTransformMakeRotation(second * angle);
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    return;
    
    {
        //旋转
        self.layer.transform = CATransform3DRotate(self.layer.transform, M_PI, 0, 1, 0);

        //缩放 z 无效
        self.layer.transform = CATransform3DScale(self.layer.transform, 1, 1, 0.5);
        
        //平移 z 无效
        self.layer.transform = CATransform3DTranslate(self.layer.transform, 2, 2, 10);
    }
    
    
    
//    {
//        self.layer.opacity = 0;
//        self.layer.bounds = CGRectMake(0, 0, 200, 200);
//    }
    
    
    
    
//    {
//        UITouch *t = touches.anyObject;
//        CGPoint p = [t locationInView: t.view];
//
//
//        //禁用隐式动画
//        [CATransaction begin]; //开启事务
//        [CATransaction setDisableActions: YES]; //禁用隐式动画
//        //需要执行动画的 代码
//        self.layer.position = p;
//        [CATransaction commit]; //提交事务
//    }
    
}

@end
