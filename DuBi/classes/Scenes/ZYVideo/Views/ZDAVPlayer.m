//
//  ZDAVPlayer.m
//  DuBi
//
//  Created by lanou3g on 16/5/26.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDAVPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVKit/AVKit.h>
#import "UIView+XYWidthHeight.h"

#define AV_WIDTH 374
#define AV_HEIGHT 230

static void *PlayViewCMTimeValue = &PlayViewCMTimeValue;
static void *AVPlayerDemoPlaybackViewControllerStatusObservationContext = &AVPlayerDemoPlaybackViewControllerStatusObservationContext;


@interface ZDAVPlayer ()

@property(strong,nonatomic)UIButton * playBtn;

/**
 *  播放器对象
 */
@property (strong, nonatomic) AVPlayer *player;
/**
 *  暂停、播放按钮
 */
@property (strong, nonatomic) UIButton *playButton;
/**
 *   进度条
 */
@property (strong, nonatomic) UISlider *slider;
/**
 *  视频对象
 */
@property (strong, nonatomic) AVPlayerItem *item;
/**
 *  播放器控制器
 */
@property (strong, nonatomic) AVPlayerViewController *playerVC;
/**
 *  时间标签
 */
@property (strong, nonatomic) UILabel *timeLabel;

@property(strong,nonatomic)UIButton *centerPlayBty;

@end



@implementation ZDAVPlayer

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame WithVideoStr:(NSString *)videoStr
{
    self = [super init];
    if (self) {
        self.frame = frame;
        NSURL * sourceMovieUrl = [NSURL URLWithString:videoStr];
        
        // 多媒体文件的属性.
        AVAsset * movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieUrl options:nil];
        // 播放项
        self.playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        
        // 实例播放器对象
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        
        AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        playerLayer.frame = self.layer.bounds;
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.layer addSublayer:playerLayer];
        // [self.player play];
        
        
        // 中间按钮
        self.centerPlayBty = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        self.centerPlayBty.center = self.center;
        [self.centerPlayBty setBackgroundImage:[UIImage imageNamed:@"playcount"] forState:(UIControlStateNormal)];
        [self.centerPlayBty addTarget:self action:@selector(centerPlayBtyAction) forControlEvents:(UIControlEventTouchUpInside)];
       // [self addSubview:self.centerPlayBty];
        
        
        // 下边的工具条
        self.bottom = [[UIView alloc]initWithFrame:CGRectMake(0,self.height - 40, self.width, 40)];
        self.bottom.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        self.playBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.playBtn addTarget:self action:@selector(PlayOrPause) forControlEvents:(UIControlEventTouchUpInside)];
        self.playBtn.frame = CGRectMake(5, 5, 30, 30);
        // playBtn.backgroundColor = [UIColor redColor];
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"play_disable"] forState:(UIControlStateNormal)];
//        [playBtn setBackgroundImage:[UIImage imageNamed:@"pause_disable"] forState:(UIControlStateHighlighted)];
        [self addSubview:self.bottom];
        [self.bottom addSubview:self.playBtn];
        
        
        
        // silder
        self.slider = [[UISlider alloc]initWithFrame:CGRectMake(45, 5, self.width - 90, 30)];
        self.slider.minimumValue = 0.0;
        self.slider.maximumValue = CMTimeGetSeconds(movieAsset.duration);
        self.slider.value = 0.0; // 指定初始化
        // 响应事件
        [self.slider addTarget:self action:@selector(updattValue:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.bottom addSubview:self.slider];
        
        // 单击Recognizer
        UITapGestureRecognizer * singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        [self addGestureRecognizer:singleRecognizer];
        
        [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:AVPlayerDemoPlaybackViewControllerStatusObservationContext];
        
        [self initScrubberTimer];
    }
    return self;
}



//
-(double)duration
{
    AVPlayerItem * playerItem = [[self player]currentItem];
    if ([playerItem status] == AVPlayerItemStatusReadyToPlay) {
        return CMTimeGetSeconds([[playerItem asset] duration]);
    }else{
        return 0.f;
    }
}



-(double)currentTime
{
    return CMTimeGetSeconds([[self player] currentTime]);
}


-(void)setcurrentTime:(double)time
{
    [[self player] seekToTime:CMTimeMakeWithSeconds(time, 1)];
}


// 播放按钮的事件
-(void)PlayOrPause
{
    if ([[self player] rate] != 1.f) {
        if ([self currentTime] == [self duration]) {
            [self setcurrentTime:0.f];
        }
        [[self player] play];
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"playButtonPause"] forState:(UIControlStateNormal)];
    }else{
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"play_disable"] forState:(UIControlStateNormal)];
       [[self player] pause];
        
    }
    
    CMTime time = [self.player currentTime];
    NSLog(@"%lld",self.playerItem.duration.value / self.playerItem.duration.timescale);
    NSLog(@"%lld",time.value / time.timescale);
}

#pragma mark  ---- handleSingleTapFrom 手势
-(void)handleSingleTapFrom
{
    [UIView animateWithDuration:0.5 animations:^{
        
        if (self.bottom.alpha == 0.0) {
            self.bottom.alpha = 1.0;
        }else
        {
            self.bottom.alpha = 0.0;
        }

    } completion:^(BOOL finished) {
        
    }];
}

// 中间播放按钮
-(void)centerPlayBtyAction
{
    if ([[self player] rate] != 1.f) {
        if ([self currentTime] == [self duration]) {
            [self setcurrentTime:0.f];
        }
        [[self player] play];
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"playButtonPause"] forState:(UIControlStateNormal)];
    }else{
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"play_disable"] forState:(UIControlStateNormal)];
        [[self player] pause];
        
    }
    
    CMTime time = [self.player currentTime];
    NSLog(@"%lld",self.playerItem.duration.value / self.playerItem.duration.timescale);
    NSLog(@"%lld",time.value / time.timescale);

}

// silder 的方法
-(void)updattValue:(UISlider *)slider
{
    [self.player seekToTime:CMTimeMakeWithSeconds(slider.value, 1)];
    if (slider.value == 1) {
    
        [self.playBtn setBackgroundImage:[UIImage imageNamed:@"play_disable"] forState:(UIControlStateNormal)];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    /* AVPlayerItem "status" property value observer */
    if (context == AVPlayerDemoPlaybackViewControllerStatusObservationContext) {
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status) {
            case AVPlayerStatusUnknown:
                
                break;
            case AVPlayerStatusReadyToPlay:
                [self initScrubberTimer];
                break;
            case AVPlayerStatusFailed:
                
                break;
            
            default:
                
                break;
        }
    }
}

#pragma mark --- 监听
-(void)initScrubberTimer
{
    
    double interval = .1f;
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration)) {
        return;
    }
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration)) {
        CGFloat width = CGRectGetWidth([self.slider bounds]);
        interval = 0.5f * duration / width;
    }
    NSLog(@"interva === %f",interval);
    
    __weak typeof(self) weakSelf = self;
    [weakSelf.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(interval, NSEC_PER_SEC) queue:NULL usingBlock:^(CMTime time) {
        [self syncScrubber];
    }];
}

/* Set the scrubber based on the player current time. */
- (void)syncScrubber
{
    NSLog(@"syncScrubber");
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration))
    {
        self.slider.minimumValue = 0.0;
        return;
    }
    
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration))
    {
        float minValue = [self.slider minimumValue];
        float maxValue = [self.slider maximumValue];
        double time = CMTimeGetSeconds([self.player currentTime]);
        NSLog(@"时间 :: %f",(maxValue - minValue) * time / duration + minValue);
        [self.slider setValue:(maxValue - minValue) * time / duration + minValue];
    }
}

- (CMTime)playerItemDuration
{
    AVPlayerItem *playerItem = [self.player currentItem];
    NSLog(@"%ld",playerItem.status);
    if (playerItem.status == AVPlayerItemStatusReadyToPlay)
    {
        return([playerItem duration]);
    }
    
    return(kCMTimeInvalid);
}






@end
