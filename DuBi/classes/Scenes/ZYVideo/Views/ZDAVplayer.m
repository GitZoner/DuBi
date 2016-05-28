//
//  ZDAVplayer.m
//  DuBi
//
//  Created by lanou3g on 16/5/28.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDAVplayer.h"

static void *PlayViewCMTimeValue = &PlayViewCMTimeValue;

static void *AVPlayerDemoPlaybackViewControllerStatusObservationContext = &AVPlayerDemoPlaybackViewControllerStatusObservationContext;


@implementation ZDAVplayer
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame WithVideoStr:(NSString *)videoStr{
    
    self = [super init];
    
    if (self) {
        
        self.frame = frame;
        
        NSURL *sourceMovieURL = [NSURL URLWithString:videoStr ];
        
         AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
        
        self.playerItem = [AVPlayerItem playerItemWithURL:sourceMovieURL];
        
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        
        playerLayer.frame = self.layer.bounds;
        
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        
        [self.layer addSublayer:playerLayer];
        
         // [self.player play];
        
        self.bottom = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40)];
        self.bottom.backgroundColor = [UIColor grayColor];
        
        UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [playBtn addTarget:self action:@selector(PlayOrPause:) forControlEvents:UIControlEventTouchUpInside];
        
        playBtn.frame = CGRectMake(5, 5, 30, 30);
        
        // playBtn.backgroundColor = [UIColor redColor];
        [playBtn setBackgroundImage: [UIImage imageNamed:@"playcount" ] forState:(UIControlStateNormal)];
        [playBtn setBackgroundImage:[UIImage imageNamed:@"playButton"] forState:(UIControlStateHighlighted)];
        [self.bottom addSubview:playBtn];
        
        [self addSubview:self.bottom];
        self.slider = [[UISlider alloc]initWithFrame:CGRectMake(45, 5, 350, 30)];
        
        self.slider.minimumValue = 0.0;
        
         self.slider.maximumValue = CMTimeGetSeconds(movieAsset.duration);
        
        self.slider.value = 0.0;//指定初始值
        
        [self.slider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventTouchUpInside];//设置响应事件
        
        [self.bottom addSubview:self.slider];
        
        // 单击的 Recognizer
        
        UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
        
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        
        [self addGestureRecognizer:singleRecognizer];
        
        [self.playerItem addObserver:self
         
                          forKeyPath:@"status"
         
                             options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
         
                             context:AVPlayerDemoPlaybackViewControllerStatusObservationContext];
        
        [self initScrubberTimer];
        
    }
    return self;
    
}

- (double)duration

{
    
    AVPlayerItem *playerItem = [[self player] currentItem];
    
    if ([playerItem status] == AVPlayerItemStatusReadyToPlay)
        
        return CMTimeGetSeconds([[playerItem asset] duration]);
    
    else
        
        return 0.f;
    
}
- (double)currentTime

{
    
    return CMTimeGetSeconds([[self player] currentTime]);
    
}

- (void)setCurrentTime:(double)time

{
    
    [[self player] seekToTime:CMTimeMakeWithSeconds(time, 1)];
    
}

- (void)PlayOrPause:(UIButton *)button
{
    
    if ([[self player] rate] == 0.0f) {
        
        if ([self currentTime] == [self duration])
        {
            [button setBackgroundImage:[UIImage imageNamed:@"playButtonPause"] forState:(UIControlStateNormal)];
            [self setCurrentTime:0.f];
           [[self player] play];
        }
    } else {
        
        [button setBackgroundImage:[UIImage imageNamed:@"playButtonPause"] forState:(UIControlStateNormal)];
   
        [[self player] pause];
    }
    CMTime time = [self.player currentTime];
    
   //  NSLog(@"%lld",self.playerItem.duration.value/self.playerItem.duration.timescale);
    
    NSLog(@"%lld",time.value/time.timescale);
    
}
#pragma mark - 手势方法

- (void)handleSingleTapFrom{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        if (self.bottom.alpha == 0.0) {
            
            self.bottom.alpha = 1.0;
            
        }else{
            
            self.bottom.alpha = 0.0;
            
        }
        
    } completion:^(BOOL finish){
        
    }];
    
}

#pragma mark - slider

- (void)updateValue:(UISlider *)slider{
    
    [self.player seekToTime:CMTimeMakeWithSeconds(slider.value, 1)];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    /* AVPlayerItem "status" property value observer. */
    
    if (context == AVPlayerDemoPlaybackViewControllerStatusObservationContext)
        
    {
        
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        
        switch (status)
        
        {
                
                /* Indicates that the status of the player is not yet known because
                 
                 it has not tried to load new media resources for playback */
                
            case AVPlayerStatusUnknown:
                
            {
                
            }
                
                break;
                
            case AVPlayerStatusReadyToPlay:
                
            {
                /* Once the AVPlayerItem becomes ready to play, i.e.
                 
                 [playerItem status] == AVPlayerItemStatusReadyToPlay,
                 
                 its duration can be fetched from the item. */
                
                [self initScrubberTimer];
                
            }
                
                break;
                
            case AVPlayerStatusFailed:
                
            {
                
            }
                
                break;
                
        }
        
    }
    
}

#pragma  maik - 监

-(void)initScrubberTimer

{
    
    double interval = .1f;
    
    CMTime playerDuration = [self playerItemDuration];
    
    if (CMTIME_IS_INVALID(playerDuration))
        
    {
        
        return;
        
    }
    
    double duration = CMTimeGetSeconds(playerDuration);
    
    if (isfinite(duration))
        
    {
        
        CGFloat width = CGRectGetWidth([self.slider bounds]);
        
        interval = 0.5f * duration / width;
        
    }
    NSLog(@"interva === %f",interval);
    
    __weak typeof(self) weakSelf = self;
    
    /* Update the scrubber during normal playback. */
    
    [weakSelf.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(interval, NSEC_PER_SEC)
     
                                                  queue:NULL /* If you pass NULL, the main queue is used. */
     
                                             usingBlock:^(CMTime time)
     
    {
        
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
  