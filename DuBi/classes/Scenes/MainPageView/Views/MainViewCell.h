//
//  MainViewCell.h
//  DuBi
//
//  Created by lanou3g on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topic.h"
@interface MainViewCell : UITableViewCell
@property(strong,nonatomic)Topic *topic;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commmentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
// 类方法计算文本的高度
+(CGFloat)heightForTopicLabel:(Topic *)topic;
@end
