//
//  PictureDetailController.m
//  DuBi
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "PictureDetailController.h"
#import <UIImageView+WebCache.h>
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#import "MBProgressHUD+gifHUD.h"
@interface PictureDetailController ()
//@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(strong,nonatomic)UIImageView *imgView;
@end

@implementation PictureDetailController
- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backAction:)];
    [imgView addGestureRecognizer:recognizer];
    
    self.imgView = imgView;
    // 屏幕宽度
    // 图片的宽度
    // 图片的高度
    
    CGFloat pictureW = kWidth;
    CGFloat pictureH = pictureW * self.picture.height / self.picture.width;
    if (pictureH > kHeight) {// 图片超过一个屏幕的高度的时候
        // 需要滚动查看
        imgView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
       // 就让他显示
        imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, pictureW, pictureH)];
        imgView.center = CGPointMake(kWidth * 0.5, kHeight *0.5);
    
    }
    
    
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:_picture.cdn_img]];
    [self.scrollView addSubview:imgView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveAction:(id)sender {
    // 图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"提示" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"添加成功" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
                             
                             
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
