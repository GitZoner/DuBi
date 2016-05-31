//
//  TLFZAVplayer.h
//  TLFZAVPlayer
//
//  Created by lanou3g on 16/4/26.
//  Copyright © 2016年 潘腾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLFZAVplayer : UIView





// 创建单例
+(instancetype)shareAVPlayer;

// 绘制视频播放器
-(void)drawAVPlayer;
// 传入网址播放视频
-(void)playWithString:(NSString*)urlString;
// 播放
-(void)palyOrpauseAction;
@end
