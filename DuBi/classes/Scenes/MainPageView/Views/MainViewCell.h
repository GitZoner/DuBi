//
//  MainViewCell.h
//  DuBi
//
//  Created by lanou3g on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topic.h"
#import "LWNCustomView.h"
@protocol MainViewCellDelegate
-(void)shareActionWithTopic:(Topic *)topic;
@end
@interface MainViewCell : UITableViewCell
@property(strong,nonatomic)Topic *topic;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel; // 段子标题
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;// 热门评论的标题
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commmentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property(strong,nonatomic)LWNCustomView *customView;
@property(weak,nonatomic)id<MainViewCellDelegate>delegate;
// 类方法计算文本的高度
+(CGFloat)heightForTopicLabel:(Topic *)topic;
@end
