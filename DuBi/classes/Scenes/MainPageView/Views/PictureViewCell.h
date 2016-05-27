//
//  PictureViewCell.h
//  DuBi
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Picture.h"
#import "MBProgressHUD+gifHUD.h"
#import "LWNImgView.h"
@interface PictureViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *pictureTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *hateButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
//@property(weak,nonatomic)LWNImgView *imgView;
@property(strong,nonatomic)Picture *picture;
+(CGFloat)heightFor:(Picture *)picture;
@end
