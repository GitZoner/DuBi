//
//  ZDSendPicture.m
//  
//
//  Created by lanou3g on 16/6/4.
//
//

#import "ZDSendPicture.h"
#import "WNImagePicker.h"
#import "WNImapgePicker/ImageEditVC.h"
#import "ZDSendPicture.h"
#import "UIView+XYWidthHeight.h"
#import "JTCircleMainController.h"
@interface ZDSendPicture ()<WNImagePickerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *theTextView;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *insterButton;
@property (strong,nonatomic)UIImageView * insterView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jiahaojulizuojuli;

@end

@implementation ZDSendPicture

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.hidesBackButton = YES;
    
    UIButton * fabu = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [fabu setTitle:@"发布" forState:(UIControlStateNormal)];
    fabu.frame = CGRectMake(0, 10, 70, 30);
    [fabu setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    fabu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    fabu.titleLabel.font = [UIFont systemFontOfSize:15];
    [fabu setTitleColor:[UIColor greenColor] forState:(UIControlStateHighlighted)];
    [fabu addTarget:self action:@selector(fabuAction:) forControlEvents:(UIControlEventTouchUpInside)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:fabu];
    
   
    
    UIButton * quxiao = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [quxiao setTitle:@"取消" forState:(UIControlStateNormal)];
    quxiao.frame = CGRectMake(0, 10, 70, 30);
    [quxiao setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    quxiao.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    quxiao.titleLabel.font = [UIFont systemFontOfSize:15];
    [quxiao setTitleColor:[UIColor greenColor] forState:(UIControlStateHighlighted)];
    [quxiao addTarget:self action:@selector(quxiaoAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:quxiao ];
    
    
    WNImagePicker * picker = [[WNImagePicker alloc]init];
    picker.delegate = self;
    self.imgView.image = self.image;
    
    
    self.insterButton.layer.borderWidth = 1;
    self.insterButton.layer.borderColor = [UIColor grayColor].CGColor;
    

}
// 取消按钮
-(void)quxiaoAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// 发布按钮
-(void)fabuAction:(UIButton *)button
{
    // 发布到服务器
    // 发布内容
    
   //  JTCircleMainController * jtcVC = [[JTCircleMainController alloc]init];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (IBAction)tianjiaButton {
    
    WNImagePicker * picker = [[WNImagePicker alloc]init];
    self.insterView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame) + self.imgView.width + 15, CGRectGetMinY(self.imgView.frame), self.imgView.width, self.imgView.height)];
    
    self.jiahaojulizuojuli.constant += self.imgView.width + 30;
    
    // picker.delegate = self;
    [self.navigationController pushViewController:picker animated:YES];
    
}
/*
- (void)getCutImage:(UIImage *)image controller:(WNImagePicker *)vc
{
    // [vc.navigationController dismissViewControllerAnimated:NO completion:nil];
    //  ImageEditVC *editVC = [[ImageEditVC alloc]init];
    //  editVC.image = image;
    ZDSendPicture * picture = [[ZDSendPicture alloc]init];
    picture.picture.image = image;
    [vc.navigationController pushViewController:picture animated:YES];
}
*/
- (void)onCancel:(WNImagePicker *)vc
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
