//
//  LYJGestureRecognizerViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/2/17.
//

#import "LYJGestureRecognizerViewController.h"

@interface LYJGestureRecognizerViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation LYJGestureRecognizerViewController

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = UIColor.cyanColor;
        _imgView.userInteractionEnabled = YES;
    }
    return _imgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.imgView.bounds = CGRectMake(0, 0, 100, 100);
    self.imgView.center = self.view.center;
    [self.view addSubview: self.imgView];
    
    
    
    /**
     手势--->> UIGestureRecognizer
     
     UILongPressGestureRecognizer
     解释长按手势的离散手势识别器。
     UIPanGestureRecognizer
     解释平移手势的离散手势识别器。
     UIPinchGestureRecognizer
     一个离散的手势识别器，它解释涉及两次触摸的捏合手势。
     UIRotationGestureRecognizer
     一个离散的手势识别器，它解释涉及两个触摸的旋转手势。
     UIScreenEdgePanGestureRecognizer
     一个离散的手势识别器，它解释在屏幕边缘附近开始的平移手势。
     UISwipeGestureRecognizer
     一种离散的手势识别器，可以解释在一个或多个方向上的滑动手势。
     UITapGestureRecognizer
     一个离散的手势识别器，可以解释单个或多个点击。
     UIHoverGestureRecognizer
     一个离散的手势识别器，它解释指针在视图上的移动。
     
     */
    
    //单点
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTapsRequired = 2; //点击次数
    tap.numberOfTouchesRequired = 2; //触摸点个数
    [self.imgView addGestureRecognizer: tap];

    //长按
    UILongPressGestureRecognizer *longPrss = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPrss:)];
    longPrss.minimumPressDuration = 3; //长按反应时长
    longPrss.allowableMovement = 100; //手势失效前的最大移动量，误差范围
    [self.imgView addGestureRecognizer: longPrss];
    
    //轻扫
    UISwipeGestureRecognizer *swiperR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swiperR.direction = UISwipeGestureRecognizerDirectionRight; //从左向右 轻扫
    [self.imgView addGestureRecognizer: swiperR];
    UISwipeGestureRecognizer *swipeL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeL.direction = UISwipeGestureRecognizerDirectionLeft; //从右向左 轻扫
    [self.imgView addGestureRecognizer: swipeL];

    //旋转
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [self.imgView addGestureRecognizer: rotation];

    //捏合
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinch.delegate = self;
    [self.imgView addGestureRecognizer: pinch];
    
    //拖拽
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.imgView addGestureRecognizer: pan];
    
    
    
    
    

}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    self.imgView.transform = CGAffineTransformScale(self.imgView.transform, recognizer.scale, recognizer.scale);
    //恢复初始值
    recognizer.scale = 1;
}

- (void)handleRotation:(UIRotationGestureRecognizer *)recognizer {
    self.imgView.transform = CGAffineTransformRotate(self.imgView.transform, recognizer.rotation);
    //恢复初始值
    recognizer.rotation = 0;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint p = [recognizer translationInView: recognizer.view];
    NSLog(@"------->>>> %@", NSStringFromCGPoint(p));
    //更新坐标
    self.imgView.transform = CGAffineTransformTranslate(self.imgView.transform, p.x, p.y);
    //self.imgView.center = CGPointMake(self.imgView.center.x + p.x, self.imgView.center.y + p.y);
    //恢复初始值
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"------->>>> %ld", recognizer.direction);
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"----->>>>向右 轻扫");
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"----->>>>向左 轻扫");
    }
}

- (void)handleLongPrss:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"------->>>> %ld", recognizer.state);
    }
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"------->>>> %ld", recognizer.state);
}


// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //解决旋转、缩放的冲突，需要实现该代理方法。
    return YES;
}

@end
