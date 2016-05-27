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


@interface ZDCustomVedioCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *fengxiangButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *pinglunButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playerButton;


@end

@implementation ZDCustomVedioCell

- (void)setListModel:(ZDList *)listModel
{
    if (_listModel != listModel) {
        _listModel = nil;
        _listModel = listModel;
    }
    self.caiButton.titleLabel.text = listModel.hate;
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:listModel.image1] placeholderImage:[UIImage imageNamed:@"wangluolianjieTB"]];
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








- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
