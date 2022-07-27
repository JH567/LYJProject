//
//  LYJTouchView.m
//  LYJProject
//
//  Created by LYJ on 2022/2/16.
//

#import "LYJTouchView.h"

//===单点触摸====================================
@interface LYJTouchView ()
@property (nonatomic, weak) UIView *squareView;
@end

@implementation LYJTouchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        
        UIView *squareView = [[UIView alloc] initWithFrame: CGRectMake(100, 100, 100, 100)];
        squareView.backgroundColor = UIColor.blueColor;
        [self addSubview:squareView];
        _squareView = squareView;
    }
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    //1、获取触摸事件
//    UITouch *t = touches.anyObject;
//    //2、获取 在 其坐标系(self\self.superview\t.view) 的 点击位置
//    CGPoint p = [t locationInView: _squareView.superview];
//    //3、改变位置
//    _squareView.center = p;
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: t.view];
    CGPoint lastP = [t previousLocationInView: t.view];
    CGFloat offsetX = p.x - lastP.x;
    CGFloat offsetY = p.y - lastP.y;
    _squareView.center = CGPointMake(_squareView.center.x + offsetX, _squareView.center.y + offsetY);
    //_squareView.center = CGPointMake(_squareView.center.x + offsetX, _squareView.center.y);
    return;
    
//    UITouch *t = touches.anyObject;
//    CGPoint p = [t locationInView: self];
//    _squareView.center = p;
}


@end




//===多点触摸====================================
@interface LYJTouchSparkView ()
@property (nonatomic, strong) NSArray *images;
@end

@implementation LYJTouchSparkView

- (NSArray *)images {
    if (!_images) {
        _images = @[
            [UIImage imageNamed:@"spark_green"],
            [UIImage imageNamed:@"spark_red"]
        ];
    }
    return _images;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //开启多点触摸
        self.multipleTouchEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self addSpark:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self addSpark:touches];
}

- (void)addSpark:(NSSet<UITouch *> *)touches {
    
    int i = 0;
    for (UITouch *t in touches) {
        
        //1、获取触摸对象
        //UITouch *t = touches.anyObject;
        //2、获取在其坐标系的 点击位置
        CGPoint p = [t locationInView: t.view];
        
        //3、创建 图片
        UIImageView *imgView = [[UIImageView alloc] initWithImage: self.images[i]];
        [self addSubview:imgView];
        
        //4、改变 图片 位置
        imgView.center = p;
        
        //5、开启动画
        [UIView animateWithDuration:2 animations:^{
            imgView.alpha = 0;
        } completion:^(BOOL finished) {
            [imgView removeFromSuperview];
        }];
        
        i++;
    }
    
}

@end





//===手势解锁====================================
@interface LYJGestureNodeView ()
@property (nonatomic, strong) NSMutableArray *lineBtns; //连线按钮
@property (nonatomic, strong) NSMutableArray *btns; //所有按钮
@property (nonatomic, assign) CGPoint currentPoint; //连线到手指位置
@property (nonatomic, strong) UIImageView *screenshotView; //截图显示
@end
@implementation LYJGestureNodeView

- (UIImageView *)screenshotView {
    if (!_screenshotView) {
        _screenshotView = [[UIImageView alloc] init];
        _screenshotView.backgroundColor = UIColor.clearColor;
        _screenshotView.hidden = YES;
        [self addSubview:_screenshotView];
    }
    return _screenshotView;
}

- (NSMutableArray *)lineBtns {
    if (!_lineBtns) {
        _lineBtns = [NSMutableArray array];
    }
    return _lineBtns;
}

- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
        
        for (int i = 0; i < 9; i ++) {
            UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
            
            btn.tag = i; // 用于获取密码
            
            // 交互禁用
            btn.userInteractionEnabled = NO;
            
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateDisabled];
            
            [self addSubview: btn];
            [_btns addObject:btn];
        }
    }
    return _btns;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //截图隐藏
    self.screenshotView.hidden = YES;
    self.screenshotView.image = nil;
    
    [self gestureNode:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self gestureNode:touches];
    //重绘
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 去掉最后一条多余的线，并重绘
    self.currentPoint = [self.lineBtns.lastObject center];
    //重绘
    [self setNeedsDisplay];
    
    
    
    //截图显示 连线结果
    self.screenshotView.hidden = NO;
    self.screenshotView.image = [self getScreenshotImag];
    
    
    
    //设置密码错误
    for (int i = 0; i < self.lineBtns.count; i ++) {
        UIButton *btn = self.lineBtns[i];
        btn.selected = NO;
        btn.enabled = NO;
    }
    
    
    
    //验证 密码
    NSString *passworld = @"";
    for (int i = 0; i < self.lineBtns.count; i ++) {
        UIButton *btn = self.lineBtns[i];
        passworld = [passworld stringByAppendingString:[NSString stringWithFormat:@"%ld", btn.tag]];
    }
    NSLog(@"<<<<-----passworld----->>>> %@", passworld);
    
    if (self.passworldBlock) {
        if (self.passworldBlock(passworld)) {
            NSLog(@"<<<<-----密码正确----->>>>");
        } else {
            NSLog(@"<<<<-----密码错误----->>>>");
        }
    }
    
    
    
    
    //关闭用户交互
    self.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //开启用户交互
        self.userInteractionEnabled = YES;
        [self clear];
    });
}

- (UIImage *)getScreenshotImag {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)clear {
    for (int i = 0; i < self.btns.count; i ++) {
        UIButton *btn = self.btns[i];
        btn.selected = NO;
        btn.enabled = YES;
    }
    //移除画线点
    [self.lineBtns removeAllObjects];
    //重绘
    [self setNeedsDisplay];
    
}

- (void)gestureNode:(NSSet<UITouch *> *)touches {
    UITouch *t = touches.anyObject;
    
    CGPoint p = [t locationInView: t.view];
    
    self.currentPoint = p;
    
    for (int i = 0; i < self.btns.count; i ++) {
        UIButton *btn = self.btns[i];
        
        if (CGRectContainsPoint(btn.frame, p)) {
            btn.selected = YES;
            
            //添加画线的点
            if (![self.lineBtns containsObject: btn]) {
                [self.lineBtns addObject: btn];
            }
            
        }
    }
    
}



- (void)drawRect:(CGRect)rect {
    //没有连线按钮 不绘图
    if (self.lineBtns.count <= 0) return;
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];

    for (int i = 0; i < self.lineBtns.count; i ++) {
        UIButton *btn = self.lineBtns[i];
        if (i == 0) { //第一个点为起点
            [path moveToPoint: btn.center];
        } else {
            [path addLineToPoint: btn.center];
        }
    }

    // 连线到手指
    [path addLineToPoint: self.currentPoint];

    [path setLineJoinStyle: kCGLineJoinRound];
    [path setLineCapStyle: kCGLineCapRound];

    [path setLineWidth: 10];
    [UIColor.whiteColor set];

    [path stroke];

    return;
    
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < self.lineBtns.count; i ++) {
        UIButton *btn = self.lineBtns[i];
        if (i == 0) { //第一个点为起点
            CGContextMoveToPoint(ctx, btn.center.x, btn.center.y);
        } else {
            CGContextAddLineToPoint(ctx, btn.center.x, btn.center.y);
        }
    }
    
    CGContextAddLineToPoint(ctx, self.currentPoint.x, self.currentPoint.y);
    
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    CGContextSetLineWidth(ctx, 10);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    
    CGContextStrokePath(ctx);
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger col = 3;
    CGFloat w = 74;
    CGFloat h = w;
    CGFloat margin = (self.bounds.size.width - col * w) / 4;
    
    for (int i = 0; i < self.btns.count; i ++) {
        CGFloat x = (i % col) * (w + margin) + margin;
        CGFloat y = (i / col) * (w + margin) + margin * 2;
        [self.btns[i] setFrame: CGRectMake(x, y, w, h)];
    }
    
    
    
    CGFloat ssW = 100;
    CGFloat ssH = ssW * self.bounds.size.height / self.bounds.size.width;
    CGFloat ssX = (self.bounds.size.width - ssW) * 0.5;
    CGFloat ssY = CGRectGetMaxY([self.btns.lastObject frame]) + 20;
    self.screenshotView.frame = CGRectMake(ssX, ssY, ssW, ssH);
    
}


@end
