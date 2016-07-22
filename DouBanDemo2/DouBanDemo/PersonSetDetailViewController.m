//
//  PersonSetDetailViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/11.
//  Copyright © 2016年 CL. All rights reserved.
//
#define TextFieldW 300
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height
#import "PersonSetDetailViewController.h"

@interface PersonSetDetailViewController ()<UITextFieldDelegate>
{
    UITextField *_userTextField;
}
@end

@implementation PersonSetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self setDetailPersonalInfo];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickSaveButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = bar;

}
- (void)clickSaveButton:(UIButton *)sender{
    
    NSString *str = _userTextField.text;
    self.block(str);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setDetailPersonalInfo{
    
    CGFloat textFieldW = SCR_W;
    CGFloat textFieldX = 0;
    CGFloat textFieldY = 100;
    CGFloat textFieldH = 50;
    _userTextField = [[UITextField alloc]initWithFrame:CGRectMake(textFieldX, textFieldY, textFieldW, textFieldH)];
    _userTextField.font = [UIFont systemFontOfSize:20];
    _userTextField.layer.borderWidth = 2;
    _userTextField.layer.borderColor =[UIColor orangeColor].CGColor;
    _userTextField.layer.cornerRadius = 5;
    _userTextField.layer.masksToBounds = YES;
    _userTextField.delegate = self;
    _userTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    _userTextField.clearsOnBeginEditing = YES;
    [_userTextField becomeFirstResponder];
    [self.view addSubview:_userTextField];
  
}
-  (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    _userTextField.text = self.contenstr;
   
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_userTextField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_userTextField resignFirstResponder];
    
}

@end
