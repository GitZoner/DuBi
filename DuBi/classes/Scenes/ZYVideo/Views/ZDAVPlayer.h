//
//  ZDAVPlayer.h
//  DuBi
//
//  Created by lanou3g on 16/5/26.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVKit/AVKit.h>
@interface ZDAVPlayer : UIView

//  下边的View
@property(nonatomic,strong)UIView *bottom;
@property(nonatomic,strong)AVPlayerItem *playerItem;

- (id)initWithFrame:(CGRect)frame WithVideoStr:(NSString *)videoStr;

- (void)PlayOrPause;
@end
