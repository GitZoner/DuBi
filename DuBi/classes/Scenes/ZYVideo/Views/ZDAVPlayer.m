//
//  ZDAVPlayer.m
//  ZDAVPlayer
//
//  Created by lanou3g on 16/6/8.
//  Copyright © 2016年 张达. All rights reserved.
//

#import "ZDAVPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "Masonry.h"
#define MP4_URL @"http://dd.yinyuetai.com/uploads/videos/common/9CB00154421D3966D6A52374737DEEDF.mp4?sc=ba429cd48fedf72c&br=405&rd=Android"


@interface ZDAVPlayer ()

// 播放器
@property(strong,nonatomic)AVPlayer * player;
@property(strong,nonatomic)AVPlayerItem * playerItem;
@property(strong,nonatomic)AVPlayerLayer * playerLayer;

// 上部工具条View
@property(strong,nonatomic)UIView   * topView;
// 返回按钮
@property(strong,nonatomic)UIButton * colseBtn;


// 下边的工具条View
@property(strong,nonatomic)UIView   * bottomView;
// 进度slider
@property(strong,nonatomic)UISlider * progressSlider;
// 开始按钮
@property(strong,nonatomic)UIButton * playOrpauseBtn;
// 剩余时间
@property(strong,nonatomic)UILabel  * timeLabel;
// 全屏播放的按钮
@property(strong,nonatomic)UIButton * fullScreenBtn;

// 播放状态
@property(assign,nonatomic)BOOL isPlayer;
// 计时器
@property(strong,nonatomic)NSTimer * timer;

@end

@implementation ZDAVPlayer

-(instancetype)initwithFrame:(CGRect)frame vedioUrl:(NSString *)url
{
    if (self == [super init]) {
        self.frame = frame;
        // NSLog(@"%d",_isPlayer);
        self.backgroundColor = [UIColor blackColor];
        // 播放器的初始化
        self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame = self.layer.bounds;
        [self.layer addSublayer:self.playerLayer];
        // 开始播放
        [self.player play];
        
        // 下边的View
        self.bottomView = [[UIView alloc] init];
        [self addSubview:self.bottomView];
        self.bottomView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self).with.offset(0);
        }];
        // 禁止自动布局子视图
        [self setAutoresizesSubviews:NO];
        
        // 开始or暂停的按钮
        self.playOrpauseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.playOrpauseBtn.showsTouchWhenHighlighted = YES;
        [self.playOrpauseBtn addTarget:self action:@selector(playOrpauseAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.playOrpauseBtn setImage:[UIImage imageNamed:@"stop"] forState:(UIControlStateNormal)];
        [self.playOrpauseBtn setImage:[UIImage imageNamed:@"player"] forState:(UIControlStateSelected)];
        [self.bottomView addSubview:self.playOrpauseBtn];
        [self.playOrpauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.bottomView).with.offset(5);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.bottomView).with.offset(0);
            make.width.mas_equalTo(40);

        }];
        
        self.progressSlider = [[UISlider alloc]init];
        self.progressSlider.minimumValue = 0.0;
        [self.progressSlider setThumbImage:[UIImage imageNamed:@"clear"] forState:(UIControlStateNormal)];
        self.progressSlider.minimumTrackTintColor = [UIColor greenColor];
        self.progressSlider.maximumValue = 1;
        // 初始值
        self.progressSlider.value = 0.0;
        // 进度条拖拽事件
        [self.progressSlider addTarget:self action:@selector(stratDragSlider:) forControlEvents:(UIControlEventValueChanged)];
        // 进度条的点击事件
        [self.progressSlider addTarget:self action:@selector(updataProgress:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.bottomView addSubview:self.progressSlider];
        [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.playOrpauseBtn).with.offset(45);
            make.right.equalTo(self.bottomView).with.offset(-120);
            make.top.equalTo(self.bottomView).with.offset(0);
            make.height.mas_equalTo(40);
            
        }];
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.textColor = [UIColor whiteColor];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.font = [UIFont systemFontOfSize:11];
        self.timeLabel.text = @"00:00/00:00";
        [self.bottomView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.bottomView).with.offset(-30);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(90);
            
        }];
        // 显示在前边
        [self bringSubviewToFront:self.bottomView];
        
        
        self.fullScreenBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.fullScreenBtn.showsTouchWhenHighlighted = YES;
        [self.fullScreenBtn addTarget:self action:@selector(fullScreenBtnAcction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.fullScreenBtn setImage:[UIImage imageNamed:@"quanping1"] forState:(UIControlStateNormal)];
        [self.fullScreenBtn setImage:[UIImage imageNamed:@"shouqi1"] forState:(UIControlStateSelected)];
        [self.bottomView addSubview:self.fullScreenBtn];
        [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.bottomView).with.offset(-5);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(self.bottomView).with.offset(0);
            make.width.mas_equalTo(40);
        }];
        
        self.topView = [[UIView alloc]init];
        self.topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:self.topView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self).with.offset(0);
            make.top.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(10);
            make.height.mas_equalTo(30);
        }];
        
        
        // 返回按钮
        self.colseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.colseBtn.showsTouchWhenHighlighted = YES;
        [self.colseBtn addTarget:self action:@selector(colseTheVideo:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.colseBtn setImage:[UIImage imageNamed:@"backtu"] forState:(UIControlStateNormal)];
        [self.colseBtn setImage:[UIImage imageNamed:@"backtu"] forState:(UIControlStateSelected)];
        self.colseBtn.layer.cornerRadius = 30 / 2;
        [self.topView addSubview:self.colseBtn];
        [self.colseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.topView).with.offset(5);
            make.height.mas_equalTo(30);
            make.top.equalTo(self.topView).with.offset(2);
            make.width.mas_equalTo(30);
        }];
        // 单击事件
        UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap)];
        singleTap.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:singleTap];
        
     [UIView animateWithDuration:6 animations:^{
         self.topView.alpha = 0;
         self.bottomView.alpha = 0;
     }];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(zdtimerAction) userInfo:nil repeats:YES];
        
    }
    return self;
}
#pragma mark  NSTimer执行的方法 
-(void)zdtimerAction
{
    
    
    if (self.playerItem.duration.timescale != 0 ) {
        self.progressSlider.maximumValue = 1; // 总时长
        // 当前进度
        self.progressSlider.value = CMTimeGetSeconds([self.playerItem currentTime]) / (self.playerItem.duration.value / self.playerItem.duration.timescale);
        // 当前时长进度
        // 当前秒
        NSInteger proMin = (NSInteger)CMTimeGetSeconds([self.player currentTime]) / 60;
        // 当前分钟
        NSInteger proSec = (NSInteger)CMTimeGetSeconds([self.player currentTime]) % 60;
        
        // 总时长
        // 总秒  // 总帧数除60（每秒60帧）
        NSInteger durMin = (NSInteger)self.playerItem.duration.value / self.playerItem.duration.timescale / 60;
        // 总分钟
        NSInteger durSec = (NSInteger)self.playerItem.duration.value / self.playerItem.duration.timescale / 60;
        
        self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld/%02ld:%02ld",proMin,proSec,durMin,durSec];
        
    }
    
    
    
    
    
    
    
//    self.progressSlider.maximumValue = self.player.currentItem.duration.value / self.player.currentItem.duration.timescale;
//    self.progressSlider.value = self.player.currentTime.value / self.player.currentTime.timescale;
//    self.timeLabel.text = [NSString stringWithFormat:@"%@:%@",[self calculateWithTime:(self.player.currentTime.value / self.player.currentTime.timescale)],[self calculateWithTime:((self.player.currentItem.duration.value / self.player.currentItem.duration.timescale) - (self.player.currentTime.value / self.player.currentTime.timescale))]];
}
// 字符串和NSInteger的换算
-(NSString*)calculateWithTime:(NSTimeInterval) interval{
    
    // 200 ->3:20
    // 181 ->3:01
    // 10 ->0:10
    // 1 ->0.01
    
    // 获取分钟数
    int minute = interval/60;
    // 获取秒
    int sec = (interval - minute*60);
    
    return [NSString stringWithFormat:@"%d:%02d",minute,sec];
    
}



#pragma mark    点击开始或者暂停的方法
-(void)playOrpauseAction:(UIButton *)btn
{
    if (_isPlayer == NO) {
        [self.player pause];
        [self.playOrpauseBtn setImage:[UIImage imageNamed:@"player"] forState:(UIControlStateNormal)];
        self.isPlayer = YES;
    }else{
        [self.player play];
        [self.playOrpauseBtn setImage:[UIImage imageNamed:@"stop"] forState:(UIControlStateNormal)];
        self.isPlayer = NO;
    }
}

#pragma mark   进度条的拖拽与点击事件
// 拖拽事件
-(void)stratDragSlider:(UISlider *)slider
{
    /*
    [self.timer invalidate];
    
    float seconds = self.progressSlider.value;
    
    CMTime startTime = CMTimeMakeWithSeconds(seconds, self.playerItem.currentTime.timescale);
    [self.player seekToTime:startTime completionHandler:^(BOOL finished) {
        if (finished) {
            [self.player play];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        }
    }];
     */
    
    [self.timer invalidate];
    [self.player pause];
    // 视频当前播放时间为人为拖动的滑块的值
    [self.playOrpauseBtn setImage:[UIImage imageNamed:@"stop"] forState:(UIControlStateNormal)];

    [self.player seekToTime:CMTimeMakeWithSeconds(self.progressSlider.value, self.player.currentTime.timescale)];
    // 重启timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                                selector:@selector(zdtimerAction) userInfo:nil repeats:YES];
    if (self.progressSlider.value == self.progressSlider.maximumValue) {
        
       //  [self.playOrpauseBtn setImage:[UIImage imageNamed:@"player"] forState:(UIControlStateSelected)];
        self.progressSlider.value = 0;
        self.isPlayer = YES;
    }
 
}

// 点击事件
-(void)updataProgress:(UISlider *)slider
{
    
}
       
#pragma Mark --- 全屏按钮的事件

-(void)fullScreenBtnAcction:(UIButton * )btn
{
    
    
    self.frame = self.superview.bounds;
    // [self hiddenAction:(BOOL)YES];
}

#pragma mark --- 返回按钮的事件
-(void)colseTheVideo:(UIButton *)btn
{
    
}


#pragma mark  -- 单击事件
-(void)handleSingleTap
{
    if (self.bottomView.alpha == 1) {
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomView.alpha = 0;
            self.topView.alpha =0;
        }];
       
    }else
    {
        [UIView animateWithDuration:0.5 animations:^{
        self.bottomView.alpha = 1;
        self.topView.alpha =1;
    }];
    }
}


#pragma mark  -- 横屏代码
//// 当前viewcontroller是否支持转屏
//-(BOOL)shouldAutorotate
//{
//    return NO;
//}
//// 当前viewcontroller支持哪些转屏方向
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return  UIInterfaceOrientationMaskLandscape;
//}
//-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return  UIInterfaceOrientationLandscapeRight;
//}
//-(BOOL)prefersStatusBarHidden
//{
//    // 返NO表示要显示，返回YES将hiden
//    return NO;
//}






















@end
