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
// 未播放显示的内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
// 未播放显示的字
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

//
@property (weak, nonatomic) IBOutlet UIButton *centerButton;


@property(assign,nonatomic)BOOL flag;

@property (weak, nonatomic) IBOutlet UILabel *videoTime;
@property (weak, nonatomic) IBOutlet UIView *playerView;



@end

@implementation ZDCustomVedioCell

#pragma mark  --- Model
- (void)setListModel:(ZDList *)listModel
{
    if (_listModel != listModel) {
        _listModel = nil;
        _listModel = listModel;
    }
    // [self playerTools];
    
    
    
    
    //self.caiButton.titleLabel.text = listModel.hate;
    
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:listModel.image1] placeholderImage:[UIImage imageNamed:@"wangluolianjieTB"]];
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
    
    self.typeLabel.text = [NSString stringWithFormat:@"分类:%@",_themesModel.themeName];
    
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





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
