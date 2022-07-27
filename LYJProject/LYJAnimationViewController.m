//
//  LYJAnimationViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/2/20.
//

#import "LYJAnimationViewController.h"
#import "LYJAnimationView.h"

@interface LYJAnimationViewController ()
@property (nonatomic, weak) CALayer *layer;
@property (nonatomic, weak) CALayer *layer1;
@property (nonatomic, strong) LYJAnimationView *bgView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, assign) int imgIndex;
@end

@implementation LYJAnimationViewController

- (LYJAnimationView *)bgView {
    if (!_bgView) {
        _bgView = [[LYJAnimationView alloc] initWithFrame:self.view.bounds];
        _bgView.backgroundColor = UIColor.whiteColor;
    }
    return _bgView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 420, kScreenWidth - 20, kScreenHeight - 450)];
        _imgView.backgroundColor = UIColor.cyanColor;
        _imgView.userInteractionEnabled = YES;
    }
    return _imgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.view = self.bgView;
    
    UIView *redVw = [[UIView alloc] initWithFrame: CGRectMake(10, 100, 30, 30)];
    redVw.backgroundColor = UIColor.redColor;
    [self.view addSubview:redVw];
    self.layer = redVw.layer;
    
    UIView *redVw1 = [[UIView alloc] initWithFrame: CGRectMake(10, 100, 30, 30)];
    redVw1.backgroundColor = UIColor.redColor;
    [self.view addSubview:redVw1];
    self.layer1 = redVw1.layer;
    
    
    [self example_four];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: self.view];
    if (CGRectContainsPoint(self.imgView.frame, p)) return;
    
//    [self example_one];
    [self example_two];
//    [self example_three];
}

- (void)example_one {
    /**
     基本动画
     1、创建动画对象（做什么动画）
     2、怎样做动画
     3、添加动画（对谁做动画）
     */
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    
    {//方式一
        anim.keyPath = @"position.x";
        // from... to
        //anim.fromValue = @(10);
        //anim.toValue = @(300);
        // 在自身的基础上增加
        anim.byValue = @(-15);
    }
    
    //设置时间
    anim.duration = 1;
    
    //重复此时
    //anim.repeatCount = INT_MAX;
    
    //防止返回原来的位置
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    
    [self.layer addAnimation:anim forKey:nil];
    
    
}

- (void)example_two {
    /**
     帧动画
     1、创建对象
     2、创建动画
     3、添加动画
     */
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"position";
    
//    {//方式一
//        anim.values = @[
//            [NSValue valueWithCGPoint:CGPointMake(100, 100)],
//            [NSValue valueWithCGPoint:CGPointMake(300, 100)],
//            [NSValue valueWithCGPoint:CGPointMake(100, 400)],
//            [NSValue valueWithCGPoint:CGPointMake(300, 400)],
//        ];
//    }
    
    {//方式二
        //创建路径
        //UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 250) radius:150 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(50, 100, 300, 300)];
        anim.path = path.CGPath;
    }
    
    anim.duration = 2;
    
    //重复此时
    anim.repeatCount = INT_MAX;
    
    //禁止返回原位置
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    [self.layer addAnimation:anim forKey:nil];
    
    
    
    
    {
        //绕方形转 - 帧动画
        CAKeyframeAnimation *keyfAnim1 = [CAKeyframeAnimation animation];
        keyfAnim1.keyPath = @"position";
        keyfAnim1.path = [UIBezierPath bezierPathWithRect: CGRectMake(50, 100, 300, 300)].CGPath;
        
        keyfAnim1.duration = 2;
        //重复此时
        keyfAnim1.repeatCount = INT_MAX;
        //禁止返回原位置
        keyfAnim1.fillMode = kCAFillModeForwards;
        keyfAnim1.removedOnCompletion = NO;
        [self.layer1 addAnimation:keyfAnim1 forKey:nil];
    }
    
    
    
    
    
    
}

- (void)example_three {
    /**
     组动画
     1、创建对象
     2、做动画
     3、添加动画
     */
    
    //自旋转 - 基本动画
    CABasicAnimation *baseAnim = [CABasicAnimation animation];
    baseAnim.keyPath = @"transform.rotation";
    baseAnim.byValue = @(2 * M_PI * 5);
    
    //绕圆转 - 帧动画
    CAKeyframeAnimation *keyfAnim = [CAKeyframeAnimation animation];
    keyfAnim.keyPath = @"position";
    keyfAnim.path = [UIBezierPath bezierPathWithArcCenter: CGPointMake(200, 250) radius:150 startAngle:0 endAngle:2 * M_PI clockwise:YES].CGPath;
    //keyfAnim.path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(50, 100, 300, 300)].CGPath;
    
    //组动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[
        baseAnim,
        keyfAnim,
    ];
    group.duration = 5;
    group.repeatCount = INT_MAX;
    [self.layer addAnimation:group forKey:nil];
}

- (void)example_four {
    
    [self.view addSubview: self.imgView];
    self.imgView.image = [UIImage imageNamed:@"ca_1"];
    self.imgIndex = 1;
    
    UISwipeGestureRecognizer *swipeR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [self.imgView addGestureRecognizer:swipeR];
    
    UISwipeGestureRecognizer *swipeL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeL.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imgView addGestureRecognizer:swipeL];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)sender {
    
    NSString *subtype = kCATransitionFromTop;
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"------->>> R");
        self.imgIndex ++;
        if (self.imgIndex > 5) self.imgIndex = 1;
        subtype = kCATransitionFromLeft;
    } else if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"------->>> L");
        self.imgIndex --;
        if (self.imgIndex < 1) self.imgIndex = 5;
        subtype = kCATransitionFromRight;
    }
    
    
    /**
     转场动画
     1、创建对象
     2、创建动画
     3、添加动画
     */
    CATransition *anim = [CATransition animation];
    anim.type = @"cube";
    anim.subtype = subtype;
    [self.imgView.layer addAnimation:anim forKey:nil];
    
    
    self.imgView.image = [UIImage imageNamed: [NSString stringWithFormat:@"ca_%d", self.imgIndex]];
    
}


@end
