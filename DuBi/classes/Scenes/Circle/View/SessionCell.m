//
//  SessionCell.m
//  DuBi
//
//  Created by Jason on 16/5/21.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "SessionCell.h"

@implementation SessionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)agreeButtonAction:(UIButton *)sender {
    EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:self.userName];
    if (!error) {
        
        [ sender setTitle:@"已同意" forState:(UIControlStateNormal)];
        sender.enabled = NO;
    }
    
}


- (IBAction)disagreeButtonAction:(UIButton *)sender {
    EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:self.userName];
    if (!error) {
        [sender setTitle:@"已拒绝" forState:(UIControlStateNormal)];
        
    }
}
@end
