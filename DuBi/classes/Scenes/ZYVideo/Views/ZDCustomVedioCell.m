//
//  ZDCustomVedioCell.m
//  DuBi
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDCustomVedioCell.h"
#import "DataModels.h"
#import <UIImageView+WebCache.h>
#import "ZDAVPlayer.h"
#import "UIView+XYWidthHeight.h"
//#import "TLFZAVplayer.h"
#import "ZDPlayVedioViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ZDAVPlayer.h"

@interface ZDCustomVedioCell ()
// 背景图片
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

// 顶
@property (weak, nonatomic) IBOutlet UIButton *dingButton;

// 分享按钮
@property (weak, nonatomic) IBOutlet UIButton *fengxiangButton;
// 菜按钮
@property (weak, nonatomic) IBOutlet UIButton *caiButton;

// 评论
@property (weak, nonatomic) IBOutlet UIButton *pinglunButton;




@property(assign,nonatomic)BOOL flag;

@property (weak, nonatomic) IBOutlet UIView *toolsView;

//@property(strong,nonatomic)TLFZAVplayer * player;

// @property(strong,nonatomic)MPMoviePlayerViewController * playerVC;

@property(strong,nonatomic)ZDAVPlayer * zdPlayer;

@end

// 点赞    踩    转发量    评论
@implementation ZDCustomVedioCell



#pragma mark  --- Model
- (void)setListModel:(ZDList *)listModel
{
    if (_listModel != listModel) {
        _listModel = nil;
        _listModel = listModel;
    }
    // [self playerTools];
    
     [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:listModel.image1] placeholderImage:[UIImage imageNamed:@"video_placeholder"]];
   
    [self.dingButton setTitle:_listModel.comment forState:(UIControlStateNormal)];
    [self.caiButton setTitle:_listModel.cai forState:(UIControlStateNormal)];
    [self.fengxiangButton setTitle:_listModel.repost forState:(UIControlStateNormal)];
    [self.pinglunButton setTitle:_listModel.comment forState:(UIControlStateNormal)];


    
  // [self playerTools];
//    self.videoTime.text = _listModel.videotime;
    

    
    // self.typeLabel.text = [NSString stringWithFormat:@"分类:%@",];
}



-(void)layoutSubviews
{
//    self.player.frame = self.bgImgView.frame;
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

//-(MPMoviePlayerViewController *)playerVC
//{
//    if (_playerVC == nil) {
//        NSURL * url = [NSURL URLWithString:_listModel.videouri];
//        _playerVC = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
//    }
//    return _playerVC;
//}


- (IBAction)playerButton:(UIButton *)sender {

  //   [[UIApplication sharedApplication].keyWindow.rootViewController presentMoviePlayerViewControllerAnimated:self.playerVC];
    self.zdPlayer = [[ZDAVPlayer alloc]initwithFrame:self.bgImgView.bounds vedioUrl:self.listModel.videouri];
    [self.contentView addSubview:self.zdPlayer];
}


// 播放视频
-(void)playerTools
{
     dispatch_queue_t mainQueue =dispatch_get_main_queue();
    
    // 给队列添加任务
     dispatch_async(mainQueue, ^{
        
    self.bgImgView.userInteractionEnabled = YES;
         
         NSLog(@"第一个任务%d",[NSThread isMainThread]);
     });


    
}






-(void)setFrame:(CGRect)frame
{
//    frame.origin.x = 2;
    //frame.origin.y = 5;
//    frame.size.width -= 4;
    frame.size.height -= 5;
    //  NSLog(@"%f",frame.size.height);
    [super setFrame:frame];
}




/**
 *
 *  属性button的一些事件
 *
 */
- (IBAction)pinglunButton:(UIButton *)sender {
    
    [sender setImage:[UIImage imageNamed:@"mainCellCommentClick"] forState:(UIControlStateNormal)];
    
}


- (IBAction)fenxiangButton:(UIButton *)sender {
    int fenxiang = [self.listModel.comment intValue];
    fenxiang += 1;
    [self.dingButton setTitle:[NSString stringWithFormat:@"%zd",fenxiang]  forState:(UIControlStateNormal)];
    
//    [self.caiButton setTitle:_listModel.cai forState:(UIControlStateNormal)];
//    [self.fengxiangButton setTitle:_listModel.repost forState:(UIControlStateNormal)];
//    [self.pinglunButton setTitle:_listModel.comment forState:(UIControlStateNormal)];

   

}


- (IBAction)caiButton:(UIButton *)sender {
    
   
}


- (IBAction)dingButton:(UIButton *)sender {
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   //   ZDAvPlayer * player = [[ZDAvPlayer alloc]initWithFrame:CGRectMake(0, 0, self.width,self.height - 35) vedioStr:_listModel.videouri];
 //   [self.contentView addSubview:player];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
