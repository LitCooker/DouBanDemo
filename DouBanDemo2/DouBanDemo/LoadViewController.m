//
//  LoadViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/8.
//  Copyright © 2016年 CL. All rights reserved.
//
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height
#define TextFieldW 300
#define UseName @"123456"
#define Pwd @"AppleIOS"
#import "LoadViewController.h"
#import "AppDelegate.h"
@interface LoadViewController ()<UITextFieldDelegate>
{
    UITextField *_userTextField;
    UITextField *_pwdTextField;
}
@end

@implementation LoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    //
    [self resetUserAndPwd];
    //
    [self builtUI];
    
    //
    [self addClickButtons];
}
- (void)resetUserAndPwd{
     NSString *logo  = [[NSUserDefaults standardUserDefaults]objectForKey:@"logo"];
    if (!logo) {
        NSMutableDictionary *userDictM = [NSMutableDictionary dictionary];

        [userDictM setObject:Pwd forKey:UseName];
        
        [[NSUserDefaults standardUserDefaults]setObject:userDictM forKey:@"user"];
        [[NSUserDefaults standardUserDefaults]setObject:@"logo" forKey:@"logo"];

    }
}
- (void)builtUI{
    CGFloat textFieldW = TextFieldW;
    CGFloat textFieldX = (SCR_W - TextFieldW)/2;
    CGFloat textFieldY = 100;
    CGFloat textFieldH = 50;
    _userTextField = [[UITextField alloc]initWithFrame:CGRectMake(textFieldX, textFieldY, textFieldW, textFieldH)];
    _userTextField.placeholder = @"帐户:  手机/邮箱/其他";
    _userTextField.font = [UIFont systemFontOfSize:20];
    _userTextField.layer.borderWidth = 1;
    _userTextField.layer.borderColor =[UIColor orangeColor].CGColor;
    _userTextField.layer.cornerRadius = 5;
    _userTextField.layer.masksToBounds = YES;
    _userTextField.delegate = self;
    _userTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    _userTextField.clearsOnBeginEditing = YES;
    [_userTextField becomeFirstResponder];
    [self.view addSubview:_userTextField];
    
    _pwdTextField =  [[UITextField alloc]initWithFrame:CGRectMake(textFieldX, textFieldY + textFieldH + 20, textFieldW, textFieldH)];
    _pwdTextField.layer.borderWidth = 1;
    _pwdTextField.layer.borderColor = [UIColor orangeColor].CGColor;
    _pwdTextField.layer.masksToBounds = YES;
    _pwdTextField.layer.cornerRadius = 5;
    _pwdTextField.placeholder = @"密码:  字母/数字/下划线组成";
    _pwdTextField.delegate = self;
    _pwdTextField.font = [UIFont systemFontOfSize:20];
    _pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTextField.secureTextEntry = YES;
    [_pwdTextField becomeFirstResponder];
    [self.view addSubview:_pwdTextField];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [_pwdTextField resignFirstResponder];
    [_userTextField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_userTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
    
}
- (void)addClickButtons{
    
    CGFloat buttonX = _pwdTextField.frame.origin.x;
    CGFloat buttonW = 100;
    CGFloat buttonY = CGRectGetMaxY(_pwdTextField.frame) + 20;
    CGFloat buttonH = _pwdTextField.frame.size.height;
    NSArray *titleArrary = @[@"登录",@"注册"];
    CGFloat margin = _pwdTextField.frame.size.width - 2 * buttonW;
    for (int i = 0; i < titleArrary.count; i++) {
        buttonX = margin *  i + buttonW * i + _pwdTextField.frame.origin.x;
         UIButton * loadButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [loadButton setTitle:titleArrary[i] forState:UIControlStateNormal];
        [loadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       
        loadButton.layer.cornerRadius = 5;
        loadButton.layer.masksToBounds =YES;
        loadButton.layer.borderWidth = 2;
        loadButton.layer.borderColor = [UIColor orangeColor].CGColor;
        loadButton.tag = 200 + i;
        [loadButton addTarget:self action:@selector(clickLoadButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loadButton];
    }
    
}
- (void)clickLoadButton:(UIButton *)sender{
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    NSMutableDictionary *userDictM = [NSMutableDictionary dictionaryWithDictionary:dict];
      NSString *passWord =[userDictM objectForKey:_userTextField.text];
    NSString *user = _userTextField.text;
    NSString *pass = _pwdTextField.text;
    if (![user isEqualToString:@""] && ![pass isEqualToString:@""]) {
        if (sender.tag == 201) {
            if (passWord) {
                //加提示；
               
                NSString *content = @"帐户已经存在";
                [self popTitle:content];
                return;
            }
            //
         
            NSString *content = @"注册成功";
            [self popTitle:content];
            [userDictM setObject:_pwdTextField.text forKey:_userTextField.text];
            [[NSUserDefaults standardUserDefaults]setObject:userDictM forKey:@"user"];
        }
        
        if (sender.tag == 200) {
            
            if (!passWord) {
            
                NSString *content = @"帐户不存在";
                [self popTitle:content];
            }else{
                if ([_pwdTextField.text isEqualToString:passWord]) {
                    NSString *content = @"登录成功";
                    [self popTitle:content];
                    self.loadBlock(user);
                    [self.navigationController popToRootViewControllerAnimated:YES];
                   
                    
                    
                }else{
                    NSString *content = @"登录失败";
                    [self popTitle:content];
                    
                }
            }
        }

    }else{
        NSString *content = @"帐户或密码不能为空";
        [self popTitle:content];
    }
    
}
- (void)popTitle:(NSString *)content{
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //1.
    UIAlertAction *alertActionOne = [UIAlertAction actionWithTitle:content style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertSheet addAction:alertActionOne];
    //2.
    UIAlertAction *alertActionTwo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertSheet addAction:alertActionTwo];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //completion  结束后需要执行的代码
    [delegate.window.rootViewController presentViewController:alertSheet animated:YES completion:nil];
}
@end
