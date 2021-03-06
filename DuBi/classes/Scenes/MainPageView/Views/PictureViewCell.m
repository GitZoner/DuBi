//
//  PictureViewCell.m
//  DuBi
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "PictureViewCell.h"
#define kImgViewWidth ([UIScreen mainScreen].bounds.size.width * 0.8)
#import <UIImageView+WebCache.h>
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#import "LWNImgView.h"
#define kMaxHeight 1000
#define kBreakHeight 250;
@interface PictureViewCell ()

@property(weak,nonatomic)LWNImgView *lwnView;
@property(assign,nonatomic)CGFloat ImgWidth;
@property(assign,nonatomic)CGFloat ImgHeight;
@end


@implementation PictureViewCell
// 懒加载
-(LWNImgView *)lwnView{
    if (!_lwnView) {
        LWNImgView *lwnView = [LWNImgView imgView];
        [self.contentView addSubview:lwnView];
        _lwnView = lwnView;
    }
    return _lwnView;
}

-(void)setPicture:(Picture *)picture{
    if (_picture != picture) {
        _picture = nil;
        _picture = picture;
        if (picture.type == 10) {// 图片类型
            // 布局
           
            // 添加封装的视图
            self.lwnView.picture = picture;
            CGFloat ImgWidth = kWidth - 4;
            CGFloat ImgHeight = ImgWidth * picture.height / picture.width;
            if (ImgHeight >= kMaxHeight) {
                ImgHeight = kBreakHeight;
            }
            
            self.lwnView.frame = CGRectMake(CGRectGetMinX(self.pictureTextLabel.frame), CGRectGetMaxY(self.pictureTextLabel.frame) + 10, ImgWidth, ImgHeight);
            [_headerImgView sd_setImageWithURL:[NSURL URLWithString:picture.profile_image]];
            CGRect nameRect = _nameLabel.frame;
            nameRect.size.height = [[self class]heightWithString:picture.text];
            self.nameLabel.frame = nameRect;
            // 内容
            _pictureTextLabel.text = picture.text;
            _pictureTextLabel.numberOfLines = 0;
            CGRect textRect = _pictureTextLabel.frame;
            textRect.size.height = [[self class]heightWithString:picture.text];
            self.pictureTextLabel.frame = textRect;

        }else if (picture.type == 29){ // 段子类型
            // 布局
            CGRect frame = _pictureTextLabel.frame;
            frame.size.height = [[self class]heightWithString:picture.text];
            _pictureTextLabel.frame = frame;

        
        }
        // 显示
        // 用户名
        _nameLabel.text = picture.name;
        // 头像
        [_headerImgView sd_setImageWithURL:[NSURL URLWithString:picture.profile_image]];
       CGRect nameRect = _nameLabel.frame;
       nameRect.size.height = [[self class]heightWithString:picture.text];
       self.nameLabel.frame = nameRect;
        // 内容
        _pictureTextLabel.text = picture.text;
        _pictureTextLabel.numberOfLines = 0;
        CGRect textRect = _pictureTextLabel.frame;
        textRect.size.height = [[self class]heightWithString:picture.text];
        self.pictureTextLabel.frame = textRect;
        
    }

}

+(CGFloat)heightWithString:(NSString *)string{
    CGSize size = CGSizeMake(kWidth - 20 , 0);
    NSDictionary *dict = @{kCIAttributeName:[UIFont systemFontOfSize:14]};
    CGRect rect = [string boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil];
    return rect.size.height;
}
// 类方法计算cell的高度
+(CGFloat)heightFor:(Picture *)picture{
    // 计算label的高度
    if (picture.type == 29) {// 段子的类型
        CGFloat titleLabelHeight = [self heightWithString:picture.text];
       // NSLog(@"cell的高度%f",titleLabelHeight + 70 + 10);
        return titleLabelHeight + 70 + 10 + 40;
    }
    // 根据picture的属性给定cell的高度
    // 图片视图的frame
    else{
        
    CGFloat ImgWidth = kWidth - 20;
    CGFloat ImgHeight = ImgWidth * picture.height / picture.width;
    if (ImgHeight >= kMaxHeight) {
        ImgHeight = kBreakHeight;
    }
   // CGFloat titleLabelHeight = [self heightWithString:picture.text];
        
    return  70 + 10 + 40 + ImgHeight ;
    }

}
-(void)setFrame:(CGRect)frame{
   frame.origin.x = 5;
  // frame.origin.y = 5;
  // frame.size.width -= 10;
   frame.size.height -= 5;
    //  NSLog(@"%f",frame.size.height);
  [super setFrame:frame];

}
- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
