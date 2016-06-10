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
#import <AVOSCloud/AVOSCloud.h>
#import "Main_marco.h"
//#import "ZYTimeLineCellModel.h"
@interface ZDSendPicture ()<WNImagePickerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *theTextView;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *insterButton;
@property (strong,nonatomic)UIImageView * insterView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jiahaojulizuojuli;


// 存放帖子图片url的数组
@property (strong, nonatomic) NSMutableArray *imgURLArray;
// 要发布帖子的图片在本地的路径
@property (strong, nonatomic) NSString *totalPath;

/*<#注释#>*/
@property (strong, nonatomic) NSMutableArray *imagesArray;

/*<#注释#>*/
@property (strong, nonatomic) AVObject *userDeliverInfo;


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
#pragma mark -- 初始化存放照片的数组 --
- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

#pragma mark -- 初始化存放帖子图片url的数组 --
- (NSMutableArray *)imgURLArray {
    if (!_imgURLArray) {
        _imgURLArray = [NSMutableArray array];
    }
    return _imgURLArray;
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
    
    
    
    AVObject *userDeliverInfo = [AVObject  objectWithClassName:@"userDeliverInfo"];// 构建对象
    [userDeliverInfo setObject:kUserDefaultGetValue(kUserInfoKey_telNum) forKey:@"name"];// 设置名称
    [userDeliverInfo setObject:@"图文混合" forKey:@"publishType"];// 设置名称
    [userDeliverInfo setObject:@1 forKey:@"priority"];// 设置优先级
    [userDeliverInfo setObject:self.theTextView.text forKey:@"msgContent"];
    [userDeliverInfo setObject:kUserDefaultGetValue(kUserInfoKey_userAlias) forKey:@"userAlias"];
    [userDeliverInfo setObject:kUserDefaultGetValue(kUserInfoKey_protrait) forKey:@"iconName"];
    [userDeliverInfo setObject:self.imgURLArray[0] forKey:@"picNamesArray"];
    self.userDeliverInfo = userDeliverInfo;
     [userDeliverInfo saveInBackground];// 保存到服务端
    [self.theTextView resignFirstResponder];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已发表成功！" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark -- 获取存放照片url的数组 --
- (void)saveImagesArray:(NSMutableArray *)imagesArray saveImagesblock:(void(^)(NSArray *imgURLArray))block{
    
    __weak ZDSendPicture * zd = self;
    
    // 收回键盘
    [zd.view endEditing:YES];
    
    
    if (self.imagesArray.count == 0) {
        
        // -- 帖子中只有文字内容 --
        block(self.imagesArray);
        
    } else {
        
        // -- 帖子中有文字内容和图片内容 --
        for (UIImage * image in imagesArray) {
            
            // 将图片保存到本地
            [self saveImage:image withName:[NSString stringWithFormat:@"%@", [NSDate date]]];
            // 生产图片url
            AVFile *file = [AVFile fileWithName:[NSString stringWithFormat:@"%@", self.userDeliverInfo.objectId] contentsAtPath:self.totalPath];
            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [zd.imgURLArray addObject:file.url];
//                    if (zd.imgURLArray.count == imagesArray.count) {
//                        // 图片url数组中的url数量和图片数量相等时，开始block传值
//                        block(zd.imgURLArray);
//                    }
                }
            }];
        }
    }
    
}

#pragma mark -- 保存要发布的图片到该程序的沙盒内 --
- (void)saveImage:(UIImage *)tempImage withName:(NSString *)imageName {
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    // 获取存放图片文件夹的沙盒路径
    self.totalPath = [documentPath stringByAppendingPathComponent:imageName];
    // 保存图片到沙盒
    [imageData writeToFile:self.totalPath atomically:YES];
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
