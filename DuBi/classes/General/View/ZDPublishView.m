//
//  ZDPublishView.m
//  DuBi
//
//  Created by lanou3g on 16/5/21.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDPublishView.h"
#import "ZDCustomButton.h"
#import "UIView+XYWidthHeight.h"
@interface ZDPublishView ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@end

@implementation ZDPublishView
+(instancetype)publishView
{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

-(void)awakeFromNib
{

    NSArray * images = @[@"publish-text",@"publish-picture"];
    NSArray * texts = @[@"发段子",@"发图片"];
    CGFloat buttonW = 72;
    CGFloat buttonH = 72 + 30;
    CGFloat buttonY = (self.height - buttonH) / 3;
    CGFloat buttonX =( self.width - buttonW * 2) / 3;
    // button之间的距离
    CGFloat xMargin = self.width - buttonW * 2  - 2 * buttonX;
    for (int i = 0 ; i < images.count; i++) {
        ZDCustomButton * button = [[ZDCustomButton alloc]init];
        [self addSubview:button];
        [button setTitle:texts[i] forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTintColor:[UIColor colorWithRed:0.496 green:0.496 blue:0.496 alpha:1.0]];
        button.imageView.image = [UIImage imageNamed:images[i]];
        button.frame = CGRectMake(buttonX + (i * buttonW) + i * xMargin,buttonY,buttonW, buttonH);
        
        
        
        
        
    }
    
}



@end
