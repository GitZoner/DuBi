//
//  TLFZAVplayer.m
//  TLFZAVPlayer
//
//  Created by lanou3g on 16/4/26.
//  Copyright © 2016年 潘腾龙. All rights reserved.
//

#import "TLFZAVplayer.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TLFZAVplayer ()

/******************************** 控件属性 ********************************************/
@property(strong, nonatomic) AVPlayerViewController *AVplayerVC;
@property(strong, nonatomic) AVPlayer *player;
@property(strong, nonatomic) UIButton *playOrpause;
@property(strong, nonatomic) UISlider *timeSlider;
@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) UILabel *leftLabel;
@property(strong, nonatomic) UILabel *rightLabel;
@property(strong, nonatomic) UIButton *LoginBigbutton;
@property(strong, nonatomic) UIButton *button;
@property(strong, nonatomic) UIVisualEffectView *Visua;
@property(strong, nonatomic) UIButton *button1;
/******************************** 播放状态属性 ********************************************/

@property BOOL isPlaying;

@end

#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height


@implementation TLFZAVplayer
// 创建播放器单例
static TLFZAVplayer *avPlayer = nil;

+(instancetype)shareAVPlayer{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        avPlayer = [self new];
    });

    return avPlayer;

}
#pragma mark -------------------绘制UI部分-----------------------
-(void)drawAVPlayer{
    
/************************** 播放控制器的设置 ***************************************************/
    // 播放控制器
    self.AVplayerVC = [AVPlayerViewController new];
    // 设置控制器的大小，跟随本身的大小
    self.AVplayerVC.view.frame = self.bounds;
    // 隐藏系统原生的UI
    self.AVplayerVC.showsPlaybackControls = NO;
    // 将播放器添加到自身的视图上
    [self addSubview:self.AVplayerVC.view];
    
/******************************* 模糊效果 *************************************************/
    
    // 模糊效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleExtraLight)];
    self.Visua = [[UIVisualEffectView alloc]initWithEffect:effect];
    self.Visua.frame = CGRectMake(0, kHeight*0.8, kWidth, kHeight*0.2);
    [self addSubview:self.Visua];
    
    
/********************************* 播放按钮 **********************************************/
    
    self.playOrpause = [[UIButton alloc]initWithFrame:CGRectMake(kWidth*0.02, kHeight*0.85, kWidth*0.09, kHeight*0.11)];
    [self.playOrpause setImage:[UIImage imageNamed:@"4"] forState:(UIControlStateNormal)];
    [self.playOrpause addTarget:self action:@selector(palyOrpauseAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.playOrpause];
    
/********************************* 进度条 **********************************************/
    self.timeSlider = [[UISlider alloc]initWithFrame:CGRectMake(kWidth*0.25, kHeight*0.82, kWidth*0.5, 34)];
    //[self.timeSlider setThumbImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
    self.timeSlider.minimumValue = 0;
    [self.timeSlider addTarget:self action:@selector(timersliderAction) forControlEvents:(UIControlEventValueChanged)];
    self.timeSlider.minimumTrackTintColor = [UIColor whiteColor];
    [self addSubview:self.timeSlider];

/********************************* 时间label **********************************************/

    // 左时间
    self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth*0.16, kHeight*0.87, kWidth*0.1, kHeight*0.05)];
    self.leftLabel.text = @"00:00";
    self.leftLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.leftLabel];
    
    // 右时间
    self.rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth*0.76, kHeight*0.87, kWidth*0.1, kHeight*0.05)];
    self.rightLabel.text = @"99:99";
    self.rightLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.rightLabel];

/********************************* 进入全屏 **********************************************/
    
    // 进入全屏按钮
    self.LoginBigbutton = [[UIButton alloc]initWithFrame:CGRectMake(kWidth*0.88, kHeight*0.85, kWidth*0.1, kHeight*0.1)];
    [self.LoginBigbutton setImage:[UIImage imageNamed:@"3"] forState:(UIControlStateNormal)];
    [self.LoginBigbutton addTarget:self action:@selector(ACtion1) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.LoginBigbutton];

/********************************* 大的播放按钮 **********************************************/
    
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kWidth*0.2, kHeight*0.25)];
    self.button.center = self.AVplayerVC.view.center;
    [self.button setImage:[UIImage imageNamed:@"6"] forState:(UIControlStateNormal)];
    [self.button addTarget:self action:@selector(ACtion) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.button];
    
/********************************* 返回按钮 **********************************************/
    
    self.button1 = [[UIButton alloc]initWithFrame:CGRectMake(0, -40, kWidth*0.2, kHeight*0.25)];
    [self.button1 setImage:[UIImage imageNamed:@"6"] forState:(UIControlStateNormal)];
    [self.button1 addTarget:self action:@selector(ACtion2) forControlEvents:(UIControlEventTouchUpInside)];
    self.button1.hidden = YES;
    [self addSubview:self.button1];

    
    
    
    
    
 }

#pragma mark --------------------拖拽进度条事件-------------------------

-(void)timersliderAction{

    [self.timer invalidate];// 计时器暂停
    [self.player pause]; // 视频停止
    // 视频当前播放时间为人为拖动的滑块的值
    [self.player seekToTime:CMTimeMakeWithSeconds(self.timeSlider.value, self.player.currentTime.timescale)];
    
    // 重启timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    // 视频播放
    [self.player play];





}


#pragma mark --------------------大按钮事件-------------------------
-(void)ACtion{

    
    [self palyOrpauseAction1];

}




#pragma mark --------------------定时器执行-------------------------
-(void)zhixing{

    // 开始播放后执行timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    

}


#pragma mark --------------------定时器事件-------------------------
-(void)timerAction{
    
     self.timeSlider.maximumValue =self.player.currentItem.duration.value/self.player.currentItem.duration.timescale;
    
      self.timeSlider.value = self.player.currentTime.value/self.player.currentTime.timescale;
    
      self.leftLabel.text = [self calculateWithTime:self.player.currentTime.value/self.player.currentTime.timescale];
    
      self.rightLabel.text = [self calculateWithTime:((self.player.currentItem.duration.value/self.player.currentItem.duration.timescale) - (self.player.currentTime.value/self.player.currentTime.timescale))];


}

#pragma mark --------------------播放事件-------------------------

-(void)playWithString:(NSString*)urlString{

    
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("myConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(concurrentQueue, ^{
           
        });

    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, concurrentQueue, ^{
        
        // 播放项目
        AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:urlString]];
        // 播放器关联网址
        self.player = [AVPlayer playerWithPlayerItem:item];
        // 关联控制器和播放器
        self.AVplayerVC.player = self.player;
        // 开始播放
        [self.AVplayerVC.player play];


    });
    dispatch_group_notify(group, concurrentQueue, ^{
        sleep(1.5);
        [self performSelectorOnMainThread:@selector(zhixing) withObject:nil waitUntilDone:NO];

    });
    // 开始播放后，两秒后隐藏按钮
    [self performSelector:@selector(hiddenAction:) withObject:nil afterDelay:2];
    self.button.hidden = YES;
    
}


#pragma mark ------------------隐藏播放按钮的方法------------------
// 隐藏所有按钮
-(void)hiddenAction:(BOOL)flag{

    
    self.playOrpause.hidden = YES;
    self.leftLabel.hidden = YES;
    self.rightLabel.hidden = YES;
    self.LoginBigbutton.hidden = YES;
    self.timeSlider.hidden = YES;
    self.Visua.hidden = YES;
}

#pragma mark -------------------播放/暂停按钮------------------------
-(void)palyOrpauseAction1
{
    if (_isPlaying) {
    _isPlaying = NO;
    [self.playOrpause setImage:[UIImage imageNamed:@"5"] forState:(UIControlStateNormal)];
    [self.playOrpause setImage:[UIImage imageNamed:@"5"] forState:(UIControlStateHighlighted)];
    [self.player pause];
    [self.timer invalidate];
    self.button.hidden = NO;
    

}else{
    
    _isPlaying = YES;
    [self.playOrpause setImage:[UIImage imageNamed:@"4"] forState:(UIControlStateNormal)];
    [self.playOrpause setImage:[UIImage imageNamed:@"4"] forState:(UIControlStateHighlighted)];
    self.button.hidden = YES;
    [self.player play];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    
}

    
}
// 播放
-(void)palyOrpauseAction{

    [self palyOrpauseAction1];
    
}

#pragma mark -------------------换算------------------------

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
#pragma mark -------------------点击事件------------------------
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    self.button.hidden = YES;
    self.playOrpause.hidden = NO;
    self.leftLabel.hidden = NO;
    self.rightLabel.hidden = NO;
    self.LoginBigbutton.hidden = NO;
    self.timeSlider.hidden = NO;
    self.Visua.hidden = NO;
    [self performSelector:@selector(hiddenAction:) withObject:nil afterDelay:5];



}


#pragma mark -------------------进入全屏------------------------

-(void)ACtion1{

    
    self.frame = self.superview.bounds;
    [self hiddenAction:(BOOL)YES];
    
    self.AVplayerVC.showsPlaybackControls = YES;


}

-(void)ACtion2{


}


- (void)drawRect:(CGRect)rect {
    
}


@end
