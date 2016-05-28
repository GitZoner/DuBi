//
//  ZDAVplayer.h
//  DuBi
//
//  Created by lanou3g on 16/5/28.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AVFoundation/AVFoundation.h"

@interface ZDAVplayer : UIView

@property(nonatomic,strong)AVPlayer *player;

@property(nonatomic,strong)UIView *bottom;

@property(nonatomic,strong)AVPlayerItem *playerItem;

@property(nonatomic,strong)UISlider *slider;

- (id)initWithFrame:(CGRect)frame WithVideoStr:(NSString *)videoStr;
- (void)PlayOrPause;

@end
