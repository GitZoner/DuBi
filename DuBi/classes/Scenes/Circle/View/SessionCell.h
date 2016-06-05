//
//  SessionCell.h
//  DuBi
//
//  Created by Jason on 16/5/21.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *declineButton;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (strong,nonatomic)NSString *userName;
@end
