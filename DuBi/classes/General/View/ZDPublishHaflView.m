//
//  ZDPublishHaflView.m
//  DuBi
//
//  Created by lanou3g on 16/5/26.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDPublishHaflView.h"
#import "ZDCustomButton.h"
#import "UIView+XYWidthHeight.h"
#import "JTTabBar.h"
#import <POP.h>
#import "ZDSendJokes.h"


#define kpresent [UIApplication sharedApplication].keyWindow.rootViewController
@interface ZDPublishHaflView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property(strong,nonatomic)UIImagePickerController * pickerController;
@end

@implementation ZDPublishHaflView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        [self  drawView];
    }
    return self;
}

-(void)drawView{

    
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shareBottomBackground"]];
    imageView.frame = [UIScreen mainScreen].bounds;
    imageView.userInteractionEnabled = YES;
    // [self insertSubview:imageView atIndex:0];
       [self addSubview:imageView];
  
    NSArray * images = @[@"publish-text",@"publish-picture",@"publish-video",@"publish-audio"];
    NSArray * texts = @[@"发段子",@"发图片",@"发视频",@"发位置"];
    
    CGFloat buttonW = 72;
    CGFloat buttonH = 72 + 30;
    CGFloat buttonY = self.frame.size.height / 4;
    CGFloat buttonX =( [UIScreen mainScreen].bounds.size.width - buttonW * 3) / 4;
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width , self.height)];
    scrollView.contentSize = CGSizeMake((buttonW + ((self.width -buttonW * 3) / 4)) * texts.count  + (self.width -buttonW * 3) / 4, self.height);
    scrollView.pagingEnabled = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.0];
    // scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shareBottomBackground"]];
    [imageView addSubview:scrollView];
    
   
    // button之间的距离
    // CGFloat xMargin = self.width - buttonW * 2  - 2 * buttonX;
    for (int i = 0 ; i < texts.count; i++) {
        self.button = [[ZDCustomButton alloc]init];
        [scrollView addSubview:self.button];
        
        [self.button setTitle:texts[i] forState:(UIControlStateNormal)];
        [self.button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.button.tag = i + 101;
        self.button.titleLabel.font = [UIFont systemFontOfSize:15];
        self.button.titleLabel.textColor = [UIColor blackColor];
        [self.button addTarget:self action:@selector(buttonsAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.button setTintColor:[UIColor colorWithRed:0.496 green:0.496 blue:0.496 alpha:1.0]];
        self.button.imageView.image =[UIImage imageNamed:images[i]];
        self.button.frame = CGRectMake(buttonX + (i * buttonW) + i * buttonX,buttonY,buttonW, buttonH);
        // 添加动画
        POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.button.center.x,self.button.center.y + self.height)];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(self.button.center.x, self.button.center.y)];
        anim.springSpeed = 20;
        anim.springBounciness = 20;
        // anim.beginTime = CACurrentMediaTime() + 0.5 * i;
        [self.button pop_addAnimation:anim forKey:nil];
  
    }
    UIView * fenGeX = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 31, self.width, 1)];
    fenGeX.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.7];
    [self addSubview:fenGeX];

}

static UIWindow * window;
// 点击button响应的事件
-(void)buttonsAction:(UIButton *)button
{
    
    if (button.tag == 101) { // 发段子
        NSLog(@"button1");
        if (_myDelegate && [_myDelegate respondsToSelector:@selector(hidderWindow)]) {
            [_myDelegate hidderWindow];
        }
    
        ZDSendJokes * nc =[ZDSendJokes new];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nc animated:NO completion:nil];
        
    }else if (button.tag == 102){ // 发图片
        if (_myDelegate && [_myDelegate respondsToSelector:@selector(hidderWindow)]) {
            [_myDelegate hidderWindow];
        }
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择模式" message:@"相册or相机" preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            // 调用系统相册
            [self invokePhoto];
            
            
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [alert addAction:action3];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        
        
        
        
        
     
        
        
        NSLog(@"button2");
    }else if (button.tag == 103){
        NSLog(@"button3");
        
        if (_myDelegate && [_myDelegate respondsToSelector:@selector(hidderWindow)]) {
            [_myDelegate hidderWindow];
        }
        
        ZDSendJokes * nc =[ZDSendJokes new];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nc animated:NO completion:nil];
        

        
        
        
    }else{
        NSLog(@"button4");
    }
}

// 调用系统相册
-(void)invokePhoto
{
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 设置代理
    self.pickerController.delegate = self;
    // 允许编辑图片
    self.pickerController.allowsEditing = YES;
    // 设置相册选完照片，是否跳到编辑模式，进行图片的剪辑
    [kpresent presentViewController:self.pickerController animated:YES completion:nil];
}

-(UIImagePickerController *)pickerController
{
    if (!_pickerController) {
        _pickerController = [UIImagePickerController new];
    }
    
    return _pickerController;
}


// 代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage  * image = nil;
    // 判断从哪获取图片
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        // 修改前的image
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }else{
        // 可编辑UIImagePickerControlerEditrdImage(获取编辑后的图片)
        image = [info objectForKey:UIImagePickerControllerEditedImage];
        
    }
}

// 进入相册



@end
