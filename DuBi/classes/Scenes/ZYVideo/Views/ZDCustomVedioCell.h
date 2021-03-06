//
//  ZDCustomVedioCell.h
//  DuBi
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"
// #import "ZDAVPlayer.h"

@interface ZDCustomVedioCell : UITableViewCell

/**
 *   ZDList 的Model
 */
@property(strong,nonatomic)ZDList * listModel;

/**
 *  ZDThemes 的Model
 */
@property(strong,nonatomic)ZDThemes * themesModel;

/**
 *  ZDInfo 的Model
 */
@property(strong,nonatomic)ZDInfo * infoModel;

/**
 * 视频播放器
 */
// @property(strong,nonatomic)ZDAVPlayer * player;

@end
