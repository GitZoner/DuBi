//
//  ZDPlayer.m
//  DuBi
//
//  Created by lanou3g on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVKit/AVKit.h>
#import "UIView+XYWidthHeight.h"
@interface ZDPlayer ()

/**
 *  播放器对象
 */
@property(strong,nonatomic)AVPlayer * player;

/**
 *  视频对象
 */
@property(strong,nonatomic)AVPlayerItem * avPlayerItem;
/**
 *  视频播放控制器
 */
@property(strong,nonatomic)AVPlayerViewController * platerVC;
/**
 *  下方工具条
 */
@property(strong,nonatomic)UIView * bottomView;

/**
 *   进度条 slider
 */
@property(strong,nonatomic)UISlider * slider;

/**
 * 播放暂停按钮
 */
@property(strong,nonatomic)UIButton * playerBtn;

/**
 *  视频时间label
 */
@property(strong,nonatomic)UILabel * timeLabel;

/**
 *  中间按钮
 */
@property(strong,nonatomic)UIButton * centerBut;

// 播放状态
@property(assign,nonatomic)BOOL flag;
@end


@implementation ZDPlayer

-(instancetype)initWithFrame:(CGRect)frame vedioUrl:(NSString *)vedioStr
{
    if (self = [super init]) {
        self.frame =frame;
        
        _flag = YES;
        
        NSURL * sourceMovieUrl = [NSURL URLWithString:vedioStr];
        
        // 多媒体文件的属性
        AVAsset * movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieUrl options:nil];
        // 播放项
        self.avPlayerItem =[AVPlayerItem playerItemWithAsset:movieAsset];
        
        // 实例播放器对象
        self.player = [AVPlayer playerWithPlayerItem:self.avPlayerItem];
        AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        playerLayer.frame = self.layer.bounds;
        playerLayer.videoGravity = AVLayerVideoGravityResize;
        [self.layer addSublayer:playerLayer];
        
        
        // 下边的工具条
        self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 40, self.width, 40)];
        self.bottomView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        
        // 播放按钮
        self.playerBtn = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        self.playerBtn.frame = CGRectMake(5, 5, 30, 30);
        [self.playerBtn addTarget:self action:@selector(playerBtnStraAndPause) forControlEvents:(UIControlEventTouchUpInside)];
        [self.playerBtn setBackgroundImage:[UIImage imageNamed:@"full_play_btn"] forState:(UIControlStateNormal)];
        [self addSubview:self.bottomView];
        [self.bottomView addSubview:self.playerBtn];
        
        // 进度条
        self.slider =  [[UISlider alloc]initWithFrame:CGRectMake(45, 5, self.width - 90, 30)];
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = 1.0;
        self.slider.value = 1.0; // 指定初始化
        // 响应事件
        [self.slider addTarget:self action:@selector(updataValue:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.bottomView addSubview:self.slider];
        
        self.centerBut = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.centerBut.frame = CGRectMake(0, 0, 50, 50);
        self.centerBut.center = self.center;
        [self.centerBut addTarget:self action:@selector(centerButAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.centerBut];
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
        tap.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:tap];

    }
    return self;
}

 /**
 *  左边的播放按钮事件
 */
-(void)playerBtnStraAndPause
{
    if ([[self player] rate] == 0.0f && _flag == YES) {
        _flag = NO;
        [self.player play];
    }else
    {
        _flag = YES;
        [self.player pause];
    }
}
/**
 *  中间的播放阿牛
 */
-(void)centerButAction
{
    if ([[self player] rate] == 0.0f && _flag == YES) {
        _flag = NO;
        [self.player play];
    }else
    {
        _flag = YES;
        [self.player pause];
    }
}

 /**
 *  slider的响应方式
 */
-(void)updataValue:(UISlider *)slider
{
    [self.player seekToTime:CMTimeMakeWithSeconds(slider.value, 1)];
}

// 点击事件
-(void)handleSingleTapFrom
{
    [UIView animateWithDuration:0.5 animations:^{
        if (self.bottomView.alpha == 0.0) {
            self.bottomView.alpha = 1.0;
        }else{
            self.bottomView.alpha = 0.0;
        }
    }];
}


// 播放
-(void)stater
{
    
}

// 暂停
-(void)pasue
{
    
}

@end
