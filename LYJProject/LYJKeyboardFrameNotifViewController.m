//
//  LYJKeyboardFrameNotifViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/1/26.
//

#import "LYJKeyboardFrameNotifViewController.h"

@interface LYJKeyboardFrameNotifViewController () <UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UITextField *textField;
@end

@implementation LYJKeyboardFrameNotifViewController

- (void)dealloc {
    NSLog(@"------>>>>> %s", __func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - SafeAreaBottomHeight - 49) style: UITableViewStylePlain];
    tableView.backgroundColor = UIColor.redColor;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(tableView.frame), kScreenWidth - 40, 49)];
    textField.borderStyle = UITextBorderStyleNone;
    textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    textField.layer.borderWidth = 1.0;
    
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.delegate = self;
    
    [self.view addSubview:textField];
    _textField = textField;
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)noteInfo {
    //NSLog(@"----->>>>> %@", noteInfo);
    /**
     
     UIKeyboardWillChangeFrameNotification; userInfo = {
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {428, 346}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {214, 1099}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {214, 753}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 926}, {428, 346}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 580}, {428, 346}}";
     UIKeyboardIsLocalUserInfoKey = 1;
     
     */
    
    // 1. ???????????????????????????????????????????????????Y???
    CGRect rectEnd = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = rectEnd.origin.y;
    
    // ????????????Y?????????????????????????????????????????????
    // 1. ???????????????????????????, ????????????????????????????????????????????????
    // 2. ??????????????????????????????, ????????????????????????????????? ???????????????????????????, ?????????Y??????????????????????????????
    CGFloat transformValue = keyboardY - self.view.frame.size.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        if (transformValue < 0) {
            self.view.transform = CGAffineTransformMakeTranslation(0, transformValue + SafeAreaBottomHeight);
        } else {
            self.view.transform = CGAffineTransformIdentity;
        }
    }];
    
    
}

//!MARK: - ---<UIScrollViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:NO];
}

//!MARK: - ---<UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
