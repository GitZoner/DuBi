//
//  MainViewCell.m
//  DuBi
//
//  Created by lanou3g on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "MainViewCell.h"
#define kTopicLabelWidth ([UIScreen mainScreen].bounds.size.width * 0.8)
#define kCommenLabelWidth ([UIScreen mainScreen].bounds.size.width * 0.8)
@interface MainViewCell()

@end
@implementation MainViewCell
-(void)setTopic:(Topic *)topic{
    if (_topic != topic) {
        _topic = nil;
        _topic = topic;
        _topicLabel.text = topic.text;
        _topicLabel.numberOfLines = 0;
        _likeButton.titleLabel.text = topic.love;
        if (topic.top_cmt.count != 0) {
            _commentLabel.text = [topic.top_cmt firstObject][@"content"];
        }
        _commmentButton.titleLabel.text = topic.commment;
        _commentLabel.numberOfLines = 0;
        CGRect frame = _topicLabel.frame;
        frame.size.height = [[self class]heightWithString:topic.text];
        _topicLabel.frame = frame;
        CGRect frame1 = _commentLabel.frame;
        frame1.size.height = [[self class]heightWithString:(NSString *)[topic.top_cmt firstObject][@"content"]];
        _commentLabel.frame = frame1;
    }

}
// 类方法计算文本的高度
+(CGFloat)heightWithString:(NSString *)string{
    CGSize size = CGSizeMake(kTopicLabelWidth, 10000);
   NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect  rect = [string boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil];
    return rect.size.height;
}




+(CGFloat)heightForTopicLabel:(Topic *)topic{
    CGFloat height = [[self class]heightWithString:topic.text];
    
    return height * 2 + 100;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setFrame:(CGRect)frame{
    frame.origin.x = 5;
    //frame.origin.y = 5;
    frame.size.width -= 10;
    frame.size.height -= 5;
    [super setFrame:frame];
}
- (IBAction)shareAction:(id)sender {
    // 点击按钮,代理执行方法
    [_delegate shareActionWithTopic:_topic];
   }

@end
