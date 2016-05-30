//
//  ZDSendJokesControllerViewController.m
//  DuBi
//
//  Created by lanou3g on 16/5/30.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDSendJokesControllerViewController.h"

@interface ZDSendJokesControllerViewController ()

/**
 *  取消按钮
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *quXiaoMetch;

/**
 *  发表按钮
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *fabiaoBurron;

/**
 *  textView
 */
@property (weak, nonatomic) IBOutlet UITextView *textView;
/**
 *  设置地点
 */
@property (weak, nonatomic) IBOutlet UIButton *diDianButton;

/**
 *  分享到qq按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *qqButton;
/**
 *  分享到微信按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *weiXinButton;
/**
 *   带时间
 */
@property (weak, nonatomic) IBOutlet UIButton *dateButton;


@end

@implementation ZDSendJokesControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


/**
 *  取消Button
 *
 *  @param sender
 */
- (IBAction)quXiaoButton:(UIBarButtonItem *)sender {
}

/**
 *  发表按钮
 *
 *  @param sender
 */
- (IBAction)faBiaoButtonAction:(UIBarButtonItem *)sender {
}

/**
 *  地点Button
 *
 *  @param sender
 */

- (IBAction)diDianButtonAciton:(UIButton *)sender {
}

/**
 *  分享到qq
 *
 *  @param sender
 */
- (IBAction)fenXiangQQ:(UIButton *)sender {
}

/**
 *  分享到微信
 *
 *  @param sender
 */

- (IBAction)fenXiangWeiX:(UIButton *)sender {
}

/**
 *   定位当前时间
 *
 *  @param sender
 */
- (IBAction)dangQianDate:(UIButton *)sender {
}





@end
