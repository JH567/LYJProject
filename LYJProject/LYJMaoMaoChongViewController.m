//
//  LYJMaoMaoChongViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/2/24.
//

#import "LYJMaoMaoChongViewController.h"

@interface LYJMaoMaoChongViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachment;
@property (nonatomic, strong) NSMutableArray *bodys;
@end

@implementation LYJMaoMaoChongViewController

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    }
    return _animator;
}

- (NSMutableArray *)bodys {
    if (!_bodys) {
        _bodys = [NSMutableArray array];
    }
    return _bodys;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupUI];
    
}

- (void)setupUI {
    
    CGFloat H = 30;
    CGFloat W = H;
    CGFloat Y = 100;
    
    for (int i = 0; i < 9; i ++) {
        
        CGFloat X = i * W;
        
        UIView *vw = [[UIView alloc] initWithFrame: CGRectMake(X, Y, W, H)];
        vw.backgroundColor = UIColor.redColor;
        
        if (i == 8) {
            vw.frame = CGRectMake(X, Y - H * 0.5, 2 * W, 2 * H);
            vw.backgroundColor = UIColor.blueColor;
            
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(handlePan:)];
            [vw addGestureRecognizer: pan];
        }
        
        vw.layer.cornerRadius = vw.bounds.size.height * 0.5;
        vw.layer.masksToBounds = YES;
        
        [self.view addSubview: vw];
        [self.bodys addObject: vw];
    }
    
    
    //创建附着行为
    for (int i = 0; i < self.bodys.count - 1; i ++) {
        UIAttachmentBehavior *attchment = [[UIAttachmentBehavior alloc] initWithItem: self.bodys[i] attachedToItem: self.bodys[i + 1]];
        [self.animator addBehavior: attchment];
    }
    
    //创建重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems: self.bodys];
    [self.animator addBehavior: gravity];
    
    //创建碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems: self.bodys];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior: collision];
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {
    
    /**
     1、创建动画者对象
     2、创建动画行为
     3、添加动画行为
     */
    
    CGPoint p = [sender locationInView: self.view];
    
    //附着行为
    if (!self.attachment) {
        self.attachment = [[UIAttachmentBehavior alloc] initWithItem: sender.view attachedToAnchor:p];
    }
    self.attachment.anchorPoint = p;
    
    [self.animator addBehavior: self.attachment];
    
    
    //拖拽结束时，删除附着行为
    if (sender.state == UIGestureRecognizerStateEnded) {
        //[self.animator removeBehavior: self.attachment];
    }
    
}

@end
