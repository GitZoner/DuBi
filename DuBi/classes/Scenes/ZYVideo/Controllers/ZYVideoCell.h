//
//  ZYVideoCell.h
//  DuBi
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYButton.h"
@interface ZYVideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *collectionButton;

@property (weak, nonatomic) IBOutlet UIView *videoView;

@property (strong, nonatomic) ZYButton *button;


@end
