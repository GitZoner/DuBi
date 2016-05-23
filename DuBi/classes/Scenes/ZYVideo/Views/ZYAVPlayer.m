//
//  ZYAVPlayer.m
//  DuBi
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZYAVPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVKit/AVKit.h>

#define AV_WIDTH 374
#define AV_HEIGHT 230


@interface ZYAVPlayer ()

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


@end


@implementation ZYAVPlayer

- (instancetype)initWithUrl:(NSString *)urlString {
    
    if (self = [super initWithFrame:CGRectMake(0, 0, 374, 230)]) {
        
        [self drawPlyer:(NSString *)urlString];
    }
    return self;
}
- (void)drawPlyer:(NSString *)urlString{
    
#pragma mark --AVPlayer的播放项
    self.item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlString]];

#pragma mark --暂停播放
    self.playButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _playButton.center = self.center;
    [_playButton setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
    [_playButton setImage:[UIImage imageNamed:@""] forState:(UIControlStateHighlighted)];
    [_playButton addTarget:self action:@selector(playButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_playButton];
    
#pragma mark -- 时间标签
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 15)];
    
    
}
/**
 *  点击播放按钮触发的方法
 *
 *  @param button 点击的哪个按钮
 */
- (void)playButton:(UIButton *)button{
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
