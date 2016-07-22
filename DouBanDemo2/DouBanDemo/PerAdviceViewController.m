//
//  PerAdviceViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/11.
//  Copyright © 2016年 CL. All rights reserved.
//
#define TextFieldW 300
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height

#import "PerAdviceViewController.h"

@interface PerAdviceViewController ()<UIAlertViewDelegate>
{
    UITextField *_userTextField;
}
@end

@implementation PerAdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"个人建议";
    //
    [self builtUI];
    
}
- (void)builtUI{
    CGFloat textFieldW = SCR_W;
    CGFloat textFieldX = 0;
    CGFloat textFieldY = 100;
    CGFloat textFieldH = 80;
    _userTextField = [[UITextField alloc]initWithFrame:CGRectMake(textFieldX, textFieldY, textFieldW, textFieldH)];
    _userTextField.font = [UIFont systemFontOfSize:20];
    _userTextField.layer.borderWidth = 2;
    _userTextField.layer.borderColor =[UIColor orangeColor].CGColor;
    _userTextField.placeholder = @"最多不超过20个汉字";
    _userTextField.layer.cornerRadius = 5;
    _userTextField.layer.masksToBounds = YES;
    _userTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    _userTextField.clearsOnBeginEditing = YES;
    [_userTextField becomeFirstResponder];
    
    
    [self.view addSubview:_userTextField];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 300, SCR_W - 100, 50)];
    [button setTitle:@"提交建议" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 4;
    button.layer.borderColor = [UIColor orangeColor].CGColor;
    [button addTarget:self action:@selector(clickUpDataButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
 
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_userTextField resignFirstResponder];
}
- (void)clickUpDataButton:(UIButton *)sender{
    [_userTextField resignFirstResponder];
    UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"谢谢" message:@"若有其他问题联系QQ：740940545反馈" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alert show];

        
    });
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [[alertView textFieldAtIndex:buttonIndex]resignFirstResponder];

    if (buttonIndex == 0) {
        
        [_userTextField resignFirstResponder];

        [self.navigationController popViewControllerAnimated:YES];

    }
}

@end
