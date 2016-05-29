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

#import "UIView+XYWidthHeight.h"


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
    
     [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:listModel.image1] placeholderImage:[UIImage imageNamed:@"wangluolianjieTB"]];
   
    [self.dingButton setTitle:_listModel.comment forState:(UIControlStateNormal)];
    [self.caiButton setTitle:_listModel.cai forState:(UIControlStateNormal)];
    [self.fengxiangButton setTitle:_listModel.repost forState:(UIControlStateNormal)];
    [self.pinglunButton setTitle:_listModel.comment forState:(UIControlStateNormal)];
    
    
   [self playerTools];
//    self.videoTime.text = _listModel.videotime;
    

    
    // self.typeLabel.text = [NSString stringWithFormat:@"分类:%@",];
}



-(void)layoutSubviews
{

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
    
// self.typeLabel.text = [NSString stringWithFormat:@"分类:%@",_themesModel.themeName];
    
}





/*
-(void)flage
{
    if (_flag == NO) {
        _flag = YES;
        _bgImgView.hidden = YES;
        _typeLabel.hidden = YES;
        _contentLabel.hidden = YES;
        _centerButton.hidden = YES;
    }else{
        _flag = NO;
        _bgImgView.hidden = NO;
        _typeLabel.hidden = NO;
        _contentLabel.hidden = NO;
        _centerButton.hidden = NO;
    }
}

// 点击中间播放按钮的事件
- (IBAction)playerButton:(UIButton *)sender {
    // [self flage];
   _player = [[ZDAVPlayer alloc]initWithFrame:CGRectMake(8, 0, _bgImgView.frame.size.width, _bgImgView.frame.size.height) WithVideoStr:_listModel.videouri];
    [self.contentView addSubview:_player];
}
*/

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
