//
//  JTBuddySearchCell.h
//  DuBi
//
//  Created by Jason on 16/6/3.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTBuddySearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userAliasLabel;
@property (weak, nonatomic) IBOutlet UIButton *addAttentionButton;
@property (weak, nonatomic) IBOutlet UIButton *addBuddyButtton;

@end
