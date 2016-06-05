//
//  JTBuddySearchCell.m
//  DuBi
//
//  Created by Jason on 16/6/3.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTBuddySearchCell.h"
#import "JTBuddyManager.h"
#import "XHToast.h"
#import "Main_marco.h"
@implementation JTBuddySearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addBuddyAction:(UIButton *)sender {
    [[JTBuddyManager sharedJTBuddyManager] addContact:_telNum message:[NSString stringWithFormat:@"%@想添加你为好友",kUserDefaultGetValue(kUserInfoKey_userAlias)] successed:^{
        
        [sender setTitle:@"已发送" forState:(UIControlStateNormal)];
        sender.enabled = NO;
        
    } failed:^(NSError *error) {
        
        [XHToast showBottomWithText:@"添加失败，请稍后重新添加" bottomOffset:100 duration:3];
        
    }];
}
- (IBAction)addAttentionAction:(UIButton *)sender {
}



@end
