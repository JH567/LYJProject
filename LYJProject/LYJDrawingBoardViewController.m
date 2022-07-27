//
//  LYJDrawingBoardViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/2/20.
//

#import "LYJDrawingBoardViewController.h"
#import "LYJDrawingBoardView.h"

@interface LYJDrawingBoardViewController ()
@property (weak, nonatomic) IBOutlet LYJDrawingBoardView *drawingBoardVw;
@end

@implementation LYJDrawingBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)handleSave:(UIBarButtonItem *)sender {
    //设置保存
    UIGraphicsBeginImageContextWithOptions(self.drawingBoardVw.bounds.size, NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.drawingBoardVw.layer renderInContext: ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //保存到相册
        UIImageWriteToSavedPhotosAlbum(image, NULL, NULL, NULL);
    });
    
}

- (IBAction)handleClearScreen:(UIBarButtonItem *)sender {
    //设置清屏
    [self.drawingBoardVw clearScreen];
}

- (IBAction)handleBackOff:(UIBarButtonItem *)sender {
    //设置回退
    [self.drawingBoardVw backOff];
}

- (IBAction)handleRubber:(UIBarButtonItem *)sender {
    //设置橡皮
    [self.drawingBoardVw rubber];
}

- (IBAction)handleLineWidth:(UISlider *)sender {
    //设置线宽
    self.drawingBoardVw.lineWidth = sender.value;
}

- (IBAction)handleLineColor:(UIButton *)sender {
    //设置线的颜色
    self.drawingBoardVw.lineColor = sender.backgroundColor;
}

@end
