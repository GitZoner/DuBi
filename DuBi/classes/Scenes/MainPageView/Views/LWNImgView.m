//
//  LWNImgView.m
//  DuBi
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "LWNImgView.h"
#import <UIImageView+WebCache.h>
#define kMaxHeight 1000
#import "PictureDetailController.h"
@interface LWNImgView ()
// 图片
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
// 点击的button
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
@implementation LWNImgView
+(instancetype)imgView{

return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
-(void)setPicture:(Picture *)picture{
    _picture = picture;
  // 设置图片
    [_imgView sd_setImageWithURL:[NSURL URLWithString:picture.cdn_img]];
    // 判断是否显示查看全图
   if (picture.height > kMaxHeight){ // 大图
       _imgView.contentMode = UIViewContentModeScaleAspectFill;
   }else{
     
   }
    

}
- (IBAction)buttonAction:(UIButton *)sender {
    // 点击图片会模态出具体的大图内容
    PictureDetailController *picDetail = [PictureDetailController new];
    picDetail.picture = self.picture;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picDetail animated:YES completion:nil];
    
}
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/*
- (instancetype)initWithFrame:(CGRect)frame With:(Picture *)picture
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = self.bounds;
        CGFloat pro = picture.width / self.frame.size.width;
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.bounds.size.width, picture.height / pro)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:picture.cdn_img]];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [button setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        button.center = self.center;
        button.titleLabel.text = @"查看全图";
        imgView.contentMode = UIViewContentModeScaleAspectFill;
       // _scrollView.contentOffset = CGPointMake(0, 0);
        [self addSubview:button];
       [_scrollView addSubview:imgView];
        [self addSubview:_scrollView];

    }
    return self;
}
// 图片的内容
*/


@end
