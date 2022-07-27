//
//  LYJDatePickerViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/1/27.
//

#import "LYJDatePickerViewController.h"

@interface LYJDatePickerViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation LYJDatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;

    self.textField.frame = CGRectMake(20, SafeAreaTopHeight, kScreenWidth - 40, 49);
    [self.view addSubview: self.textField];
    
    self.textField.inputView = self.datePicker;
    self.textField.inputAccessoryView = self.toolbar;
    
}


- (void)cancelItemClick {
    [self.view endEditing:YES];
}

- (void)confirmItemClick {
    
    NSDate *date = self.datePicker.date;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy年MM月dd日";
    
    self.textField.text = [format stringFromDate:date];
    
    [self cancelItemClick];
}


//!MARK: - ------懒加载--------
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _textField.layer.borderWidth = 1.0;
        
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
        _textField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}

- (UIToolbar *)toolbar {
    if (!_toolbar) {
        // 只需要高度
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemClick)];
        UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(confirmItemClick)];
        UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        _toolbar.items = @[cancelItem, flexibleSpaceItem, confirmItem];
    }
    return _toolbar;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        //自动占用键盘位置
        _datePicker = [[UIDatePicker alloc] init];
        //日期模式
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        //本地化
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
    }
    return _datePicker;
}

@end
