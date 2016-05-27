//
//  JTCircleCell.m
//  DuBi
//
//  Created by Jason on 16/5/25.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTCircleCell.h"
#import <Masonry.h>
#import "UIView+XYWidthHeight.h"
@interface JTCircleCell ()
@property (strong,nonatomic)UIImageView *protrait; // 头像
@property (strong,nonatomic)UILabel *nameLabel; // 用户名
@property (strong,nonatomic)UIView *pushContentView; // 内容区域视图
@property (strong,nonatomic)UIView *pannelView; // 放置点赞 ，分享， 收藏 ，发布时间的标签的面板
@property (strong,nonatomic)UILabel *postTimeLabel; // 发布时间标签
@property (strong,nonatomic)UIButton *agressButton; // 点赞按钮
@property (strong,nonatomic)UIButton *shareButton; // 分享按钮
@property (strong,nonatomic)UIButton *collectionButton;  //收藏按钮
@property (strong,nonatomic)UIView *commentView;  // 用于放置评论内容的View区域

@end
@implementation JTCircleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews {
    __weak typeof (JTCircleCell *) cell = self;
    // 分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    // 头像
    self.protrait = [[UIImageView alloc] init];
    self.protrait.backgroundColor = [UIColor redColor];
    self.protrait.layer.cornerRadius = 17.5;
    self.protrait.layer.masksToBounds  = YES;
    [self.contentView addSubview:self.protrait];
    
    [self.protrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
        make.left.equalTo(cell.contentView.mas_left).offset(10);
        make.top.equalTo(cell.contentView.mas_top).offset(5);
    }];
    
    
    // 用户名
    self.nameLabel = [UILabel new];
    self.nameLabel.text = @"陨落星辰";
    [self.contentView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(cell.protrait.mas_trailing).offset(5);
        make.centerY.equalTo(cell.protrait.mas_centerY);
        make.trailing.equalTo(cell.contentView.mas_trailing).offset(-10);
        make.height.equalTo(cell.protrait.mas_height);
    }];
    
    // 内容区域
    self.pushContentView = [UIView new];
    self.pushContentView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.pushContentView];
    
    [self.pushContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.protrait.mas_bottom).offset(5);
        make.leading.equalTo(cell.protrait.mas_leading);
        make.trailing.equalTo(cell.contentView.mas_trailing).offset(-10);
        make.height.mas_equalTo(cell.contentView.width).multipliedBy(9 / 9);
    }];
    
    // 操作区域
    self.pannelView = [UIView new];
    [self.contentView addSubview:self.pannelView];
    self.pannelView.backgroundColor = [UIColor grayColor];
    
    [self.pannelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.pushContentView.mas_bottom).offset (5);
        make.leading.equalTo(cell.pushContentView.mas_leading);
        make.trailing.equalTo(cell.pushContentView.mas_trailing);
        make.height.mas_equalTo(15);
        
    }];
    
    // 评论区
    self.commentView = [UIView new];
    self.commentView .backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.commentView];
    
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.pannelView.mas_bottom).offset (5);
        make.leading.equalTo(cell.protrait.mas_leading);
        make.trailing.equalTo (cell.contentView.mas_trailing).offset (-10);
        make.height.mas_equalTo(100);
        
    }];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    
}

@end
