//
//  ZDPlayVedioViewController.m
//  DuBi
//
//  Created by lanou3g on 16/5/31.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDPlayVedioViewController.h"
#import "TLFZAVplayer.h"
@interface ZDPlayVedioViewController ()

@end

@implementation ZDPlayVedioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    TLFZAVplayer * player = [TLFZAVplayer shareAVPlayer];
    player.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2 );
    player.center = self.view.center;
    [player drawAVPlayer];
    [player playWithString:self.vedioUrl];
    [self.view addSubview:player];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
