//
//  PersonIconViewController.m
//  DouBanDemo
//
//  Created by qianfeng on 16/7/11.
//  Copyright © 2016年 CL. All rights reserved.
//
#define SCR_W self.view.bounds.size.width
#define SCR_H self.view.frame.size.height
#import "PersonIconViewController.h"
#import "ImageTool.h"
#import "AppDelegate.h"
@interface PersonIconViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *_iconImageView;
}
@end

@implementation PersonIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"个人头像";
    self.view.backgroundColor = [UIColor blackColor];
    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 150, SCR_W, SCR_W)];
    _iconImageView.layer.borderWidth = 1;
    _iconImageView.layer.cornerRadius = 5;
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;

    _iconImageView.backgroundColor = [UIColor whiteColor];
    _iconImageView.image = self.image;
    [self.view addSubview:_iconImageView];
    
    [self addSelectPicButton];
    
}
- (void)setImage:(UIImage *)image{
    
    _image = image;
    
    _iconImageView.image = image;
}
- (void)addSelectPicButton{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button setTitle:@"选择" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickSelectPicButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = bar;

    
}
- (void)clickSelectPicButton:(UIButton *)sender{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 点击按钮触发
        [self openImageWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    
    UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 点击按钮触发
        // 点击按钮触发
        [self openImageWithType:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }];
    

    
    UIAlertAction *actionThree = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 点击按钮触发
        
    }];
    
    
    [alertC addAction:actionOne];
    [alertC addAction:actionTwo];
    [alertC addAction:actionThree];
    // 显示提示
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //completion  结束后需要执行的代码
    [delegate.window.rootViewController presentViewController:alertC animated:YES completion:nil];
}
- (void)savePicAndReturn{
    
    self.picBlock(_iconImageView.image);
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)openImageWithType:(UIImagePickerControllerSourceType )type
{
    // 1. 判断设备有没有摄像头
    NSArray *array = [UIImagePickerController availableMediaTypesForSourceType:type];
    if (array.count > 0 && [UIImagePickerController isSourceTypeAvailable:type]) {
        UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
        pickerC.delegate = self;
        pickerC.sourceType = type;
        // 允许对图片进行编辑
        pickerC.allowsEditing = YES;
        [self presentViewController:pickerC animated:YES completion:nil];
        
    }else{ // 不可以拍摄
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示⚠️" message:@"该设备不支持拍照" preferredStyle:UIAlertControllerStyleAlert];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //completion  结束后需要执行的代码
        [delegate.window.rootViewController presentViewController:alertC animated:YES completion:nil];
        
        //GCD 延时执行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
        
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 获取选中的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    // tool处理图片
    ImageTool *tool = [ImageTool shareTool];
    // 返回图片的大小
    // 处理的图片
    UIImage *toolImage =[tool resizeImageToSize:CGSizeMake(400, 400) sizeOfImage:image];
    _iconImageView.image = toolImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    // 点击按钮触发
    [self savePicAndReturn];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    // 点击取消按钮
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
