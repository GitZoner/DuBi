//
//  JTSearchBar.m
//  DuBi
//
//  Created by Jason on 16/6/3.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTSearchBar.h"
#import "UIView+XYWidthHeight.h"
#import "Color_marco.h"
@implementation JTSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.width - 70, self.height)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle_search"]];
        imageView.frame = CGRectMake(3, 3, 23, 23);
        _searchTextField.leftView =imageView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.placeholder = @"搜索";
        _searchTextField.borderStyle = UITextBorderStyleRoundedRect;
        _searchTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self addSubview:_searchTextField];
        
        _cancleButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _cancleButton.frame = CGRectMake(CGRectGetMaxX(_searchTextField.frame) + 5, 0, 50, 30);
        [_cancleButton setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancleButton setTitleColor:tGreenColor forState:(UIControlStateNormal)];
        _cancleButton.layer.borderColor = tGreenColor.CGColor;
        _cancleButton.layer.borderWidth = 1;
        _cancleButton.layer.cornerRadius = 5;
        _cancleButton.layer.masksToBounds = YES;
        
        [self addSubview:_cancleButton];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
