//
//  LYJDrawingBoardView.m
//  LYJProject
//
//  Created by LYJ on 2022/2/20.
//

#import "LYJDrawingBoardView.h"
#import <objc/runtime.h>



@interface UIBezierPath (Extension)
@property (nonatomic, strong) UIColor *lineColor;
@end
@implementation UIBezierPath (Extension)
- (void)setLineColor:(UIColor *)lineColor {
    objc_setAssociatedObject(self, @selector(lineColor), lineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)lineColor {
    return objc_getAssociatedObject(self, @selector(lineColor));
}
@end
/**=================================*/




@interface LYJDrawingBoardView ()
@property (nonatomic, strong) NSMutableArray *paths;
@end

@implementation LYJDrawingBoardView

- (NSMutableArray *)paths {
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: t.view];
    
    //创建 路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置起点
    [path moveToPoint: p];
    
    //设置线宽
    if (self.lineWidth <= 0) {
        [path setLineWidth: 0.5];
    } else {
        [path setLineWidth: self.lineWidth];
    }
    
    //设置颜色
    if (self.lineColor) {
        [path setLineColor: self.lineColor];
    } else {
        [path setLineColor: UIColor.blackColor];
    }
    
    //设置线的 拐点、起点、终点样式
    [path setLineJoinStyle: kCGLineJoinRound];
    [path setLineCapStyle: kCGLineCapRound];
    
    [self.paths addObject: path];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: t.view];
    
    //给数组的最后一个点 - 设置连线
    [self.paths.lastObject addLineToPoint: p];
    
    //重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    /**
     颜色、渲染需要在 drawRect 中实现
     */
    
    if (self.paths.count <= 0) return;
    
    for (UIBezierPath *path in self.paths) {
        //设置颜色
        [path.lineColor set];
        //渲染
        [path stroke];
    }
}


/// 清屏
- (void)clearScreen {
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}
/// 回退
- (void)backOff {
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}
/// 橡皮
- (void)rubber {
    self.lineColor = self.backgroundColor;
}

@end





