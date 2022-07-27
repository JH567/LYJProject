//
//  LYJDrawView.m
//  LYJProject
//
//  Created by LYJ on 2022/1/28.
//

#import "LYJDrawView.h"

@interface LYJDrawView ()
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation LYJDrawView

/**
 >>>>> rect - 当前view到 bounds
 
 
 >>>>> drawRect 什么时候调用 ？
 1、当这个 view 第一次显示的时候 会调用
 2、当这个 view  进行重绘的时候 会调用
 
 
 >>>>> 如何重绘？
 1、调用某个需要重绘的 view 对象的 setNeedsDisplay
 2、调用某个需要重绘的 view 对象的 setNeedsDisplayInRect   rect:需要重绘区域
 
 
 
 >>>>> 为什么不能手动调用 drawRect
 手动调用的时候可能获取不到正确的上下文
 
 
 */
- (void)drawRect:(CGRect)rect {
    [self test_19_rect:rect];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 重绘
    //[self setNeedsDisplay];
    
    // 重绘 某一块区域
    //[self setNeedsDisplayInRect: CGRectMake(0, 0, 150, 150)];
    
    
    //[self getImageFromCurrentContext];
    
    
    //[self getNewImageFromOldImage];
    
    
    //[self getArcImageFromImage];
    
    
    //[self getWaterMarkImageFromImage];
    
    [self getScreenshotImag];
    
}

- (void)getScreenshotImag {
    /**
     截屏
     
     //获取当前 view.layer 类型的图形上下文
     UIGraphicsGetCurrentContext();
     
     //开启、创建 图片 类型的图形上下文
     UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
     
     */
    
    [self getWaterMarkImageFromImage];
    
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    //截屏 保存相册
    UIImageWriteToSavedPhotosAlbum(newImage, NULL, NULL, NULL);
    
}

- (void)getWaterMarkImageFromImage {
    /**
     添加 - 图片水印
     */
    
    //1、获取图片
    UIImage *image = [UIImage imageNamed:@"me"];
    
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    //1、绘制图片上下文
    [image drawAtPoint:CGPointZero];
    
    //2、上下文 - 绘制文字
    NSString *title = @"路飞🚀🚀🚀";
    [title drawAtPoint: CGPointMake(2, 2) withAttributes:@{
        NSFontAttributeName: [UIFont boldSystemFontOfSize:5.],
        NSForegroundColorAttributeName: UIColor.greenColor,
    }];
    
    //3、上下文 - 绘制图片
    UIImage *markImg = [UIImage imageNamed:@"dst2"];
    CGFloat ratio = 0.05;
    [markImg drawInRect: CGRectMake(0, image.size.width - 700 * ratio, 467 * ratio, 700 * ratio)];
    
    
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    //9、显示
    [self addSubview: self.imgView];
    self.imgView.hidden = NO;
    self.imgView.image = newImage;
}

- (void)getArcImageFromImage {
    /**
     带圆环的图片
     */
    
    //1、获取图片
    UIImage *image = [UIImage imageNamed:@"me"];
    
    CGFloat margin = 5;
    
    CGSize ctxSize = self.bounds.size;
    CGRect imgRect = CGRectMake(margin, margin, ctxSize.width - 2 * margin, ctxSize.height - 2 * margin);
    
    UIGraphicsBeginImageContextWithOptions(ctxSize, NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, ctxSize.width * 0.5, ctxSize.height * 0.5, MIN((ctxSize.width - margin) * 0.5, (ctxSize.height - margin) * 0.5), 0, 2 * M_PI, 1);
    CGContextSetLineWidth(ctx, margin);
    [UIColor.redColor setStroke];
    CGContextStrokePath(ctx);
    
    
    CGContextAddArc(ctx, ctxSize.width * 0.5, ctxSize.height * 0.5, MIN(imgRect.size.width * 0.5, imgRect.size.height * 0.5), 0, 2 * M_PI, 1);
    CGContextClip(ctx);
     
    
    [image drawInRect: imgRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    
    
    
    //9、显示
    [self addSubview: self.imgView];
    self.imgView.hidden = NO;
    self.imgView.image = newImage;
    
    
}


- (void)getNewImageFromOldImage {
    
    /**
     图片裁剪
     */
    
    //1、获取图片
    UIImage *image = [UIImage imageNamed:@"me"];
    
    CGSize ImageSize = image.size;
    
    //2、开启图片上下文
    UIGraphicsBeginImageContextWithOptions(ImageSize, NO, 0);
    
    //4、获取内容上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //5、画原圆形
    CGContextAddArc(ctx, ImageSize.width * 0.5, ImageSize.height * 0.5, MIN(ImageSize.width * 5, ImageSize.height * 0.5), 0, 2 * M_PI, 1);
    
    //6、裁剪
    CGContextClip(ctx);
    
    //7、画图
    //[image drawAtPoint:CGPointZero];
    [image drawInRect: CGRectMake(0, 0, ImageSize.width, ImageSize.height)];
    
    //8、获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //3、关闭图片上下文
    UIGraphicsEndImageContext();
    
   
    
    //9、显示
    [self addSubview: self.imgView];
    self.imgView.hidden = NO;
    self.imgView.image = newImage;
    
    
    
    
    //10、保存相册
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), @{@"tag": @0});
    
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSDictionary *ctxInfo = (__bridge NSDictionary *)contextInfo;
    NSLog(@"---->>>> %@-------->>>%@", contextInfo, ctxInfo[@"tag"]);
}

- (void)getImageFromCurrentContext {
    
    /**
     开启 - 图片上下文，
     画图，
     渲染，
     获取新的图片，
     保存在沙盒
     
     
     UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale)
     size   -   大小
     opaque -   是否透明，yes不透明
     scale  -   缩放系数 - 一般为 0，不缩放，相当于 [UIScreen mainScreen].scale
     
     */
    
    //1、绘图 - 转换成 - image
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    //UIGraphicsBeginImageContext(self.bounds.size); === UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(ctx, self.bounds.size.width * 0.5, self.bounds.size.height * 0.5, 120, 0, 2 * M_PI, 1);
    
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, self.bounds.size.width, self.bounds.size.height);
    
    CGContextMoveToPoint(ctx, self.bounds.size.width * 0.1, self.bounds.size.height * 0.1);
    CGContextAddLineToPoint(ctx, self.bounds.size.width * 0.9, self.bounds.size.height * 0.1);

    
    CGContextStrokePath(ctx);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //2、保存沙盒
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"------>>>>> docPath: %@",docPath);
    docPath = [docPath stringByAppendingPathComponent:@"lyjxxx.png"];
    
    //NSData *imgData = UIImageJPEGRepresentation(image, 1);
    NSData *imgData = UIImagePNGRepresentation(image);
    [imgData writeToFile:docPath atomically:YES];
    
    
    
    
    
    //3、显示
    [self addSubview: self.imgView];
    self.imgView.hidden = NO;
    self.imgView.image = image;
    
}


- (void)test_0_rect:(CGRect)rect {
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //拼接路径，同时把路径添加到上下文当中
    CGContextMoveToPoint(ctx, 50, 50); //起点
    CGContextAddLineToPoint(ctx, 100, 100); //终点
    CGContextAddLineToPoint(ctx, 150, 150);

    CGContextMoveToPoint(ctx, 50, 200);
    CGContextAddLineToPoint(ctx, 200, 200);
    
    //渲染
    CGContextStrokePath(ctx);
}

- (void)test_1_rect:(CGRect)rect {
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //拼接路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 50);
    CGPathAddLineToPoint(path, NULL, 100, 200);
    CGPathAddLineToPoint(path, NULL, 150, 200);
    
    CGPathMoveToPoint(path, NULL, 20, 50);
    CGPathAddLineToPoint(path, NULL, 20, 200);
    
    //把路径添加到上下文
    CGContextAddPath(ctx, path);
    
    //渲染
    CGContextStrokePath(ctx);
    
    //内存释放
    CFRelease(path);
}

- (void)test_2_rect:(CGRect)rect {
    //上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //拼接路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint: CGPointMake(10, 10)];
    [path addLineToPoint: CGPointMake(50, 50)];
    [path addLineToPoint: CGPointMake(50, 100)];
    
    [path moveToPoint: CGPointMake(10, 10)];
    [path addLineToPoint: CGPointMake(10, 100)];
    
    //加载路径
    CGContextAddPath(ctx, path.CGPath);
    
    //渲染
    CGContextStrokePath(ctx);
}

- (void)test_3_rect:(CGRect)rect {
    //上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //拼接路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 10, 10);
    CGPathAddLineToPoint(path, NULL, 50, 40);
    
    UIBezierPath *path_b = [UIBezierPath bezierPathWithCGPath:path];
    [path_b addLineToPoint: CGPointMake(79, 300)];
    
    [path_b moveToPoint: CGPointMake(10, 10)];
    [path_b addLineToPoint: CGPointMake(10, 300)];
    
    //加载路径
    CGContextAddPath(ctx, path_b.CGPath);
    
    //渲染
    CGContextStrokePath(ctx);
    
    //内存释放
    CFRelease(path);
}

- (void)test_4_rect:(CGRect)rect {

    // 创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // 拼接路径
    [path moveToPoint: CGPointMake(100, 100)];
    [path addLineToPoint: CGPointMake(200, 300)];
    [path addLineToPoint: CGPointMake(300, 300)];
    
    [path moveToPoint: CGPointMake(10, 10)];
    [path addLineToPoint: CGPointMake(10, 200)];
    
    // 渲染
    [path stroke];
}

- (void)test_5_rect:(CGRect)rect {
    // 矩形
    //[[UIBezierPath bezierPathWithRect:CGRectMake(10, 10, rect.size.width - 20, rect.size.height - 20)] stroke];
    
    // 圆角矩形
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, rect.size.width - 20, rect.size.height - 20) cornerRadius:10] stroke];
}

- (void)test_6_rect:(CGRect)rect {
    // 椭圆
    //[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, rect.size.width - 20, rect.size.height * 0.4)] stroke];
    
    
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(cxt, CGRectMake(10, 100, rect.size.width - 20, rect.size.height * 0.4));
    CGContextStrokePath(cxt);
}

- (void)test_7_rect:(CGRect)rect {
    // 画弧度
    /**
     arcCenter - 圆心
     radius - 半径
     startAngle - 开始 位置:  M_PI  ---------- 0
     endAngle - 结束位置
     clockwise - 是否顺时针
     
             -M_PI_2
                +
                +
     M_PI  -----+----- 0
                +
                +
             M_PI_2
     */
    
    
    //[[UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:YES] stroke];
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, 111, 111, 100, 0, 2 * M_PI, 1);
    CGContextSetLineWidth(ctx, 10);
    CGContextStrokePath(ctx);

}

- (void)test_8_rect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(20, 50)];
    [path addLineToPoint: CGPointMake(200, 200)];
    [path addLineToPoint: CGPointMake(350, 50)];


    //设置线宽
    [path setLineWidth:30];

    //设置连接处样式
    [path setLineJoinStyle: kCGLineJoinRound];

    //设置头尾样式
    [path setLineCapStyle:kCGLineCapRound];

    //设置描边颜色
    [UIColor.redColor setStroke];

    [path stroke];
    return;
    
    
    
    // C 方式
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //拼接路径，同时把路径添加到上下文当中
    CGContextMoveToPoint(ctx, 20, 50);
    CGContextAddLineToPoint(ctx, 200, 200);
    CGContextAddLineToPoint(ctx, 350, 50);
    
    //设置线宽
    CGContextSetLineWidth(ctx, 20);
    
    /** 设置连接处样式
     kCGLineJoinMiter, 默认
     kCGLineJoinRound, 圆角
     kCGLineJoinBevel. 切角
     */
    CGContextSetLineJoin(ctx, kCGLineJoinMiter);
    
    /** 设置头尾样式
     kCGLineCapButt, 默认
     kCGLineCapRound, 圆角
     kCGLineCapSquare, 相当于 增加 线宽一半 的内边距
     */
    CGContextSetLineCap(ctx, kCGLineCapSquare);
    
    //设置描边颜色
    CGContextSetRGBStrokeColor(ctx, 0.1, 0.5, 1, 1);
    //[UIColor.orangeColor setStroke];
    
    CGContextStrokePath(ctx);
}

- (void)test_9_rect:(CGRect)rect {
    /**
     渲染方式： 描边、 填充
     */
    
    UIBezierPath *path = [UIBezierPath bezierPath];

    [path moveToPoint: CGPointMake(50, 50)];
    [path addLineToPoint: CGPointMake(100, 100)];
    [path addLineToPoint: CGPointMake(150, 50)];
    [path closePath];

    [path setLineWidth: 10.0];

    [UIColor.orangeColor setFill];
    [UIColor.blueColor setStroke];
    
    // [UIColor.purpleColor set]; - 同时执行 描边、填充颜色

    //渲染 - 描边、填充
    [path stroke];
    [path fill];

    return;
    
    
    //上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    //拼接路径
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 150, 50);
    //CGContextAddLineToPoint(ctx, 50, 50);
    //关闭路径 - 当前路径 与 起点相连
    CGContextClosePath(ctx);
    
    CGContextSetLineWidth(ctx, 10);
    
    //设置颜色
    [UIColor.orangeColor setStroke];
    [UIColor.redColor setFill];
    
    //渲染 - 描边
    //CGContextStrokePath(ctx);
    //渲染 - 填充
    //CGContextFillPath(ctx);
    
    
    //渲染 - 描边
    //CGContextDrawPath(ctx, kCGPathStroke);
    //渲染 - 填充
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

- (void)test_10_rect:(CGRect)rect {
    /**
     奇偶填充规则：
     
     某一个点或者某一块区域，
     被覆盖了偶数次，不填充
     被覆盖了奇数次，填充
     
     */
    
    
   
    UIBezierPath *path_ = [UIBezierPath bezierPathWithRect: CGRectMake(100, 100, 200, 100)];
   
    [path_ addArcWithCenter: CGPointMake(150, 150) radius:100 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    path_.usesEvenOddFillRule = YES;
   
    [path_ fill];
   
    return;
    
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
//    CGContextAddArc(ctx, 120, 180, 100, 0, M_PI * 2, 1);
//    CGContextAddRect(ctx, CGRectMake(10, 100, rect.size.width - 20, 160));
//    CGContextAddRect(ctx, CGRectMake(180, 20, 50, rect.size.height - 40));
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect: CGRectMake(10, 100, rect.size.width - 20, 160)];
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter: CGPointMake(120, 180) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRect: CGRectMake(180, 20, 50, rect.size.height - 40)];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextAddPath(ctx, path1.CGPath);
    CGContextAddPath(ctx, path2.CGPath);
    
    
    CGContextDrawPath(ctx, kCGPathEOFill);
    
    return;
}

- (void)test_11_rect:(CGRect)rect {
    /**
     非零环绕数 - 规则：
     默认填充规则：（非零绕数规则）从左到右跨过 +1
     从右到左跨过 -1。
     最后如果为0，那么不填充，否则填充
     
     
     选取 一个点、或者一块区域，任意方向画一条射线。会出现一个或者多交点。
     顺时针（从右到左 -1）跨过焦点，
     逆时针（从左到右 +1）跨过焦点，
     最后如果为0，那么不填充，否则填充
     
     */
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(ctx, 180, 180, 100, 0, M_PI * 2, 1);
    CGContextAddArc(ctx, 180, 180, 70, 0, M_PI * 2, 0);

    
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter: CGPointMake(180, 180) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
//    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter: CGPointMake(180, 180) radius:70 startAngle:0 endAngle:M_PI * 2 clockwise:NO];
//
//    CGContextAddPath(ctx, path.CGPath);
//    CGContextAddPath(ctx, path1.CGPath);
    
    
    CGContextFillPath(ctx);
}

- (void)test_12_rect:(CGRect)rect {
    /**
     扇形
     */
    
    NSArray *array = @[@0.3, @0.1, @0.2, @0.4];
    
    CGFloat startAngle = 0;
    CGFloat endAngle = 0;
    
    for (int i = 0; i < array.count; i ++) {
        
        endAngle = 2 * M_PI * [array[i] floatValue] + startAngle;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter: CGPointMake(150, 150) radius:120 startAngle:startAngle endAngle:endAngle clockwise:YES];
        
        [path addLineToPoint: CGPointMake(150, 150)];
        
        [[UIColor colorWithRed:((CGFloat)arc4random_uniform(256)/255.0) green:((CGFloat)arc4random_uniform(256)/255.0) blue:((CGFloat)arc4random_uniform(256)/255.0) alpha:1] set];
        
        [path fill];
        
        startAngle = endAngle;
    }
    
    
    
}

- (void)test_13_rect:(CGRect)rect {
    /**
     柱状图
     */
    NSArray *array = @[@0.8, @0.5, @0.7, @0.3, @0.1, @0.6];
    
    
    for (int i = 0; i < array.count; i ++) {
        //计算 rect ，先计算宽高
        CGFloat Margin = 20;
        CGFloat W = 20;
        CGFloat H = [array[i] floatValue] * rect.size.height;
        CGFloat X = (W + Margin) * i;
        CGFloat Y = rect.size.height - H - 30;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect: CGRectMake(X, Y, W, H)];
        
        [[UIColor colorWithRed:((CGFloat)arc4random_uniform(256)/255.0) green:((CGFloat)arc4random_uniform(256)/255.0) blue:((CGFloat)arc4random_uniform(256)/255.0) alpha:1] set];
        
        [path fill];
    }
    
    
    
}

- (void)test_14_rect:(CGRect)rect {
    
    /**
     矩阵操作：旋转、平移、缩放
     
     矩阵操作 在 拼接 路径之前。
     */
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddArc(path, NULL, rect.size.width * 0.5, rect.size.height * 0.5, 120, 0,  2 * M_PI, 1);
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, rect.size.width, rect.size.height);
    
    // 缩放
    CGContextScaleCTM(ctx, 0.5, 0.5);
    
    
    CGContextAddPath(ctx, path);
    
    
    CGContextSetLineWidth(ctx, 7);
    
    
    CGContextStrokePath(ctx);
    
    
    //内存释放
    CGPathRelease(path);
    
    
    
    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//
//    // 旋转
//    //CGContextRotateCTM(ctx, M_PI_4);
//    // 平移
//    //CGContextTranslateCTM(ctx, 50,  50);
//    // 缩放
//    CGContextScaleCTM(ctx, 0.5, 0.5);
//
//    CGContextAddArc(ctx, rect.size.width * 0.5,  rect.size.height * 0.5, 150, 0, 2 * M_PI, 1);
//    CGContextMoveToPoint(ctx, 0, 0);
//    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
//
//    CGContextSetLineWidth(ctx, 7);
//
//
//    CGContextStrokePath(ctx);
    
    
}

- (void)test_15_rect:(CGRect)rect {
    
    /**
     获取上下文状态：栈管理
     */
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //备份状态 一
    CGContextSaveGState(ctx);

    CGContextAddArc(ctx, rect.size.width * 0.5,  rect.size.height * 0.5, 120, 0, 2 * M_PI, 1);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);

    CGContextSetLineWidth(ctx, 7);
    
    //备份状态 二
    CGContextSaveGState(ctx);
    
    
    [UIColor.redColor set];

    CGContextStrokePath(ctx);
    
    
    
    
    //恢复状态 二
    CGContextRestoreGState(ctx);
    //恢复状态 一
    CGContextRestoreGState(ctx);
    
    CGContextMoveToPoint(ctx, rect.size.width * 0.1, rect.size.height * 0.1);
    CGContextAddLineToPoint(ctx, rect.size.width * 0.9, rect.size.height * 0.1);
    
    CGContextStrokePath(ctx);
    
    
}

- (void)test_16_rect:(CGRect)rect {
    /**
     绘制文字
     */
    
    NSString *str = @"hello world!";
    str = @"hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world! hello world!";
    
    NSShadow *s = [NSShadow new];
    s.shadowOffset = CGSizeMake(10, 10);
    s.shadowBlurRadius = 1;
    s.shadowColor = UIColor.orangeColor;
    
    NSDictionary *attributes = @{
        NSFontAttributeName: [UIFont boldSystemFontOfSize:17.f],
        NSForegroundColorAttributeName: UIColor.redColor,
//        NSBackgroundColorAttributeName: UIColor.greenColor,
//        NSUnderlineStyleAttributeName: @(1),
//        NSUnderlineColorAttributeName: UIColor.purpleColor,
        NSShadowAttributeName: s,
    };
    
    //绘制方法一: 在某一点开始绘制
    //[str drawAtPoint:CGPointZero withAttributes:nil];
    
    //绘制方法二： 在某一区域开始绘制
    [str drawInRect: CGRectMake(0, 0, rect.size.width, rect.size.height * 0.3) withAttributes:attributes];

    
}

- (void)test_17_rect:(CGRect)rect {
    /**
     绘制图片
     */
    //UIImage *img = [UIImage imageNamed:@"me"];
    UIImage *img = [UIImage imageNamed:@"bg"];
    //UIImage *img = [UIImage imageNamed:@"dst2"];
    
    // 某一点绘制
    //[img drawAtPoint:CGPointZero];
    
    
    // 某一区域绘制 - 拉伸
    //[img drawInRect: rect];
    
    
    // 某一区域绘制 - 平铺
    [img drawAsPatternInRect: rect];
    

}

- (void)test_18_rect:(CGRect)rect {
    /**
     裁剪
     */
    
    UIImage *img = [UIImage imageNamed:@"me"];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(ctx, rect.size.width * 0.5, rect.size.height * 0.5, rect.size.width * 0.5, 0, 2 * M_PI, 1);
    
    
    // 裁剪
    CGContextClip(ctx);
    
    
    
    // 某一区域绘制 - 拉伸
    [img drawInRect: rect];}

- (void)test_19_rect:(CGRect)rect {
    
}

- (void)test_20_rect:(CGRect)rect {
    
}

- (void)test_21_rect:(CGRect)rect {
    
}

- (void)test_22_rect:(CGRect)rect {
    
}




//!MARK: - ------懒加载-------
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame: self.bounds];
        _imgView.hidden = YES;
    }
    return _imgView;
}

@end
