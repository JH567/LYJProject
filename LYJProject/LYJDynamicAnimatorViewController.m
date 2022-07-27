//
//  LYJDynamicAnimatorViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/2/20.
//

#import "LYJDynamicAnimatorViewController.h"

@interface LYJBgView : UIView
@property (nonatomic, assign) CGRect redRect;
@property (nonatomic, assign) CGPoint attachmentStart;
@property (nonatomic, assign) CGPoint attachmentEnd;
@end
@implementation LYJBgView
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(0, 300)];
    [path addLineToPoint: CGPointMake(300, 350)];
    [path stroke];
    
    
    [UIBezierPath bezierPathWithRect: self.redRect];
    
    
    UIBezierPath *attachmentPath = [UIBezierPath bezierPath];
    [attachmentPath moveToPoint: self.attachmentStart];
    [attachmentPath addLineToPoint: self.attachmentEnd];
    [attachmentPath stroke];
}
@end
//===================================




@interface LYJDynamicAnimatorViewController () <UICollisionBehaviorDelegate>
@property (nonatomic, strong) LYJBgView *bgVw;

@property (nonatomic, weak) UIView *redVw;
@property (nonatomic, weak) UIView *blueVw;
@property (nonatomic, weak) UIView *greenVw;

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachment;
@end

@implementation LYJDynamicAnimatorViewController

- (LYJBgView *)bgVw {
    if (!_bgVw) {
        //_bgVw = [[LYJBgView alloc] initWithFrame: self.view.bounds];
        _bgVw = [[LYJBgView alloc] initWithFrame: CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bgVw.backgroundColor = UIColor.whiteColor;
    }
    return _bgVw;
}

- (void)loadView {
    /*
     loadView 优先级高
     
     该函数中可以更换 self.view
     
     self.view 是懒加载的
     
     */
    self.view = self.bgVw;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UIView *redVw = [[UIView alloc] initWithFrame: CGRectMake(100, 100, 100, 100)];
    redVw.backgroundColor = UIColor.redColor;
    redVw.alpha = 0.5;
    [self.view addSubview: redVw];
    self.redVw = redVw;
    
    UIView *blueVw = [[UIView alloc] initWithFrame: CGRectMake(250, 100, 100, 100)];
    blueVw.backgroundColor = UIColor.blueColor;
    blueVw.alpha = 0.5;
    [self.view addSubview: blueVw];
    self.blueVw = blueVw;
    
    UIView *greenVw = [[UIView alloc] initWithFrame: CGRectMake(180, kScreenHeight - 150, 50, 50)];
    greenVw.backgroundColor = UIColor.greenColor;
    [self.view addSubview: greenVw];
    self.greenVw = greenVw;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /**
     1、根据某一个范围，创建动画者对象
     2、根据某一动力学行为，创建动画行为
     3、把行为添加到动画者当中
     */
    
    //[self example_one];
    //[self example_two: touches];
    //[self example_three: touches];
    //[self example_four: touches];
    [self example_five: touches];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: t.view];
    
    self.attachment.anchorPoint = p;
    
    __weak __typeof(self) weakSelf = self;
    self.attachment.action = ^{
        NSLog(@"-------------->>>>>>> move");
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        //绘制 - 连杆
        strongSelf.bgVw.attachmentStart = strongSelf.redVw.center;
        strongSelf.bgVw.attachmentEnd = p;
        [strongSelf.bgVw setNeedsDisplay];
    };
    
    
    
}

- (void)example_five:(NSSet<UITouch *> *)touches {
    /**
     自身动力学元素
     
     1、创建动画者对象
     2、创建动画行为
     3、添加动画行为
     */
        
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: t.view];
    
    if (!self.animator) self.animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems: @[self.redVw, self.greenVw]];
    [self.animator addBehavior: gravity];
    
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems: @[self.redVw, self.greenVw]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior: collision];
    
    
    //自身动力学行为
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems: @[self.redVw, self.greenVw]];
    //弹力- 0（非弹性）和1（弹性碰撞）
    itemBehavior.elasticity = 0.8;

    //摩擦力- 0表示对象之间没有摩擦
    itemBehavior.friction = 2;
    
    //密度- 1默认情况下
    itemBehavior.density = 100;
    
    //角速度阻尼- 0：无角速度阻尼
    itemBehavior.angularResistance = 1;
    [self.animator addBehavior: itemBehavior];
    
    
}

- (void)example_four:(NSSet<UITouch *> *)touches {
    
    /**
     推行为
     
     1、创建动画者对象
     2、创建动画行为
     3、添加动画行为
     */
    
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: t.view];
    
    if (!self.animator) self.animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    
    /**
     UIPushBehaviorModeContinuous       持续推力，越来越快
     UIPushBehaviorModeInstantaneous    瞬时推力，越来越慢
     */
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems: @[self.redVw] mode: UIPushBehaviorModeInstantaneous];
    
    //方向
    push.angle = M_PI_2;
    push.pushDirection = CGVectorMake(p.x - self.redVw.center.x, p.y - self.redVw.center.y); // 原点到改点的射线方向
    
    //大小
    push.magnitude = 1;
    
    [self.animator addBehavior:push];
    
    
}

- (void)example_three:(NSSet<UITouch *> *)touches {
    /**
     附着（刚性） - 行为
     
     1、创建动画者对象
     2、创建动画行为
     3、添加动画行为
     */
    
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: t.view];
    
    if (!self.animator) {
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    }
    
    if (!self.attachment) {
        //点 与 item
        //self.attachment = [[UIAttachmentBehavior alloc] initWithItem: self.redVw attachedToAnchor: p];
        //点 与 item，有偏移
        self.attachment = [[UIAttachmentBehavior alloc] initWithItem: self.redVw offsetFromCenter: UIOffsetMake(10, 10) attachedToAnchor: p];
        
        
        //item 与 item
        //self.attachment = [[UIAttachmentBehavior alloc] initWithItem: self.redVw attachedToItem: self.blueVw];
    }
    {//刚性附着
        // 固定连杆长度
        self.attachment.length = 100;
    }

    {//弹性附着
        self.attachment.damping = 1;
        self.attachment.frequency = 0;
    }
    
    __weak __typeof(self) weakSelf = self;
    self.attachment.action = ^{
        NSLog(@"-------------->>>>>>> began");
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        //绘制 - 连杆
        strongSelf.bgVw.attachmentStart = strongSelf.redVw.center;
        strongSelf.bgVw.attachmentEnd = p;
        [strongSelf.bgVw setNeedsDisplay];
    };
    
    [self.animator addBehavior: self.attachment];
    
    
    
    //重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems: @[self.redVw]];
    [self.animator addBehavior: gravity];
    
    
    //碰撞
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems: @[self.redVw]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior: collision];
    
    
}





/**
 ===============================================================
 分界线
 ===============================================================
 */
- (void)example_two:(NSSet<UITouch *> *)touches {
    /**
     甩 - 行为
     */
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: t.view];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem: self.redVw snapToPoint:p];
    
    snap.damping = 0; //值越小-甩动越大
    
    [self.animator addBehavior: snap];
}







/**
 ===============================================================
 分界线
 ===============================================================
 */
- (void)example_one {
    /**
     重力 - 行为
     */
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    
    
    {//添加 重力 - 行为
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems: @[self.redVw]];
        //改变方向
        gravity.gravityDirection = CGVectorMake(0, 1);
        gravity.angle = M_PI_2;
        //改变重力
        //gravity.magnitude = 10;
        
        [self.animator addBehavior: gravity];
    }
    
    
    {//添加 碰撞 - 行为
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems: @[self.redVw, self.greenVw]];
        // 把引用 view(当前引用self.view) 的 bounds 变为边界
        collision.translatesReferenceBoundsIntoBoundary = YES;
        
        //添加边界
        [collision addBoundaryWithIdentifier:@"key" fromPoint: CGPointMake(0, 300) toPoint: CGPointMake(300, 350)];
        [collision addBoundaryWithIdentifier:@"key1" forPath:[UIBezierPath bezierPathWithRect: self.greenVw.frame]];
        
        //action - 系统会实时监听
        collision.action = ^{
            NSLog(@"--->>> %@", NSStringFromCGRect(self.redVw.frame));
            
            self.bgVw.redRect = self.redVw.frame;
            [self.bgVw setNeedsDisplay];
            
            if (self.redVw.frame.size.width >= 105) {
                self.redVw.backgroundColor = UIColor.purpleColor;
            } else {
                self.redVw.backgroundColor = UIColor.redColor;
            }
            
        };
        
        //代理
        collision.collisionDelegate = self;
        
        /**
         碰撞模式
         UICollisionBehaviorModeItems        仅仅item 与 item发生碰撞,
         UICollisionBehaviorModeBoundaries   仅与 边界 发生碰撞,
         UICollisionBehaviorModeEverything   与 item、边界都发生碰撞
         */
        collision.collisionMode = UICollisionBehaviorModeEverything;
        
        
        [self.animator addBehavior: collision];
    }
    
}

//!MARK: -- <UICollisionBehaviorDelegate> 监听碰撞的 item、边界
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p {
    
}
- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 {
    
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    NSString *key = (NSString *)identifier;
    if ([key isEqualToString: @"key"]) {
        self.redVw.backgroundColor = UIColor.orangeColor;
    } else {
        // The identifier of a boundary created with translatesReferenceBoundsIntoBoundary or setTranslatesReferenceBoundsIntoBoundaryWithInsets is nil
        self.redVw.backgroundColor = UIColor.redColor;
    }
}
- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier {
    
}

@end
