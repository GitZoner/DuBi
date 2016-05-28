//
//  ZDVedioCell.m
//  DuBi
//
//  Created by lanou3g on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDVedioCell.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVKit/AVKit.h>
#import "UIView+XYWidthHeight.h"

@interface ZDVedioCell ()



@end

@implementation ZDVedioCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        [self drawView];
    }
    return self;
}

-(void)drawView{
    
    // AVplayer的播放项
    AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:_listModel.videouri]];
    self.player = [AVPlayer playerWithPlayerItem:item];
    // AVPlayer
    self.player = [[AVPlayer alloc]initWithPlayerItem:item];
    // 将layer层显示的视频内容添加到当前视图的layer层
    AVPlayerLayer * layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame = CGRectMake(0, 0, 375, 200);
    [self.contentView.layer addSublayer:layer];
    [self.player play];
    // 暂停
    [self.player pause];
    // 跳转(跳到某一时间播放)
    // 注意：参数是CMTime，不可以直接写时间
    [self.player seekToTime:CMTimeMake(60, self.player.currentTime.timescale) completionHandler:^(BOOL finished) {
        NSLog(@"跳转完成后执行的代码！");
    }];
    [self.contentView addSubview:self.player];
    
}

- (void)setListModel:(ZDList *)listModel
{
    if (_listModel != listModel) {
        _listModel = nil;
        _listModel = listModel;
    }
    // [self playerTools];
    
    //    ZDAVPlayer * players = [[ZDAVPlayer alloc]initWithFrame:self.bounds WithVideoStr:_listModel.videouri];
    //    [_playerView addSubview:players];
    
    
    
    //self.caiButton.titleLabel.text = listModel.hate;
    
    // [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:listModel.image1] placeholderImage:[UIImage imageNamed:@"wangluolianjieTB"]];
    //    self.videoTime.text = _listModel.videotime;
    // self.typeLabel.text = [NSString stringWithFormat:@"分类:%@",];
}

-(void)setInfoModel:(ZDInfo *)infoModel
{
    if (_infoModel != infoModel) {
        _infoModel = nil;
        _infoModel = infoModel;
    }
}
-(void)setThemesModel:(ZDThemes *)themesModel
{
    if (_themesModel != themesModel) {
        _themesModel =nil;
        _themesModel = themesModel;
    }
}








- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
