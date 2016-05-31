//
//  JTSegmentControl.m
//  DuBi
//
//  Created by Jason on 16/5/30.
//  Copyright © 2016年 JasonTian. All rights reserved.
//



#import "JTSegmentControl.h"
#import "UIView+XYWidthHeight.h"
@interface JTSegmentControl ()
@property (strong,nonatomic)NSArray *titleArray; // 存放标题的容器
@property (strong,nonatomic)UIColor *normalColor; // 正常情况时的标题颜色
@property (strong,nonatomic)UIColor *selectColor; // 选中时的标题颜色
@property (strong,nonatomic)UIFont *titleFont; // 标题的字体
@property (assign,nonatomic)NSUInteger defaultIndex; // 默认选中的标题下标
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIButton *selectedButton;
@property (assign,nonatomic)CGSize segmentSize;
@property (assign,nonatomic)CGSize itemSize;
@property (strong,nonatomic)UIView *indicatorLine;

@end
@implementation JTSegmentControl

-(instancetype)initWithFrame:(CGRect)frame normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor titles:(NSArray *)titleArray SegmentSize:(CGSize)segmentSize ItemSize:(CGSize)itemSize  titleFont:(UIFont *)font {
    self = [super init];
    self.frame = frame;
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.scrollView =[[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.contentSize = CGSizeMake(itemSize.width * titleArray.count, segmentSize.height);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        self.normalColor = normalColor;
        self.selectColor = selectColor;
        self.titleArray = titleArray;
        self.segmentSize = segmentSize;
        self.itemSize = itemSize;
        self.titleFont  =font;
        
        [self setUpSubViews];
    }
    return self;
}

-(void)setUpSubViews {
    
    [self addSegmentItem];
}


-(void)addSegmentItem {
    self.indicatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.segmentSize.height - 2, self.itemSize.width, 2)];
    self.indicatorLine.backgroundColor = self.selectColor;
    [self.scrollView addSubview:self.indicatorLine];
    
    for (int i = 0 ; i < self.titleArray.count; i++) {

        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(self.itemSize.width * i, 0, self.itemSize.width, self.segmentSize.height - 2);
        [button setTitle:self.titleArray[i] forState:(UIControlStateNormal)];
        [button setTitleColor:self.normalColor forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:(UIControlEventTouchDown)];
        button.titleLabel.font = self.titleFont;
        button.tag = i;
        if (i == 0) {
            self.defaultIndex = 0;
            self.selectedButton = button;
            self.selectedButton.enabled = NO;
            button.enabled = YES;
            [UIView animateWithDuration:0.25 animations:^{
                CGPoint centerPoint = self.indicatorLine.center;
                centerPoint.x = self.selectedButton.center.x;
                self.indicatorLine.center = centerPoint;
            }];
            
        }
        [self.scrollView addSubview:button];
    }
}


-(void)setSelectedButton:(UIButton *)selectedButton {
    if (_selectedButton != selectedButton) {
        [_selectedButton setTitleColor:self.normalColor forState:(UIControlStateNormal)];
        _selectedButton = nil;
        _selectedButton = selectedButton;
        [UIView animateWithDuration:0.25 animations:^{
            [_selectedButton setTitleColor:self.selectColor forState:(UIControlStateNormal)];
            
        }];
        _selectedButton.enabled = YES;
        selectedButton.enabled = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.contentOffset =CGPointMake(self.itemSize.width *selectedButton.tag - self.segmentSize.width / 2  , 0);
            if (self.scrollView.contentOffset.x < 0) {
                self.scrollView.contentOffset = CGPointZero;
            }else if(self.scrollView.contentOffset.x > (self.scrollView.contentSize.width - self.segmentSize.width) ) {
                self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - self.segmentSize.width ,0);
            }
            CGPoint centerPoint = self.indicatorLine.center;
            centerPoint.x = _selectedButton.center.x;
            self.indicatorLine.center = centerPoint;
            [_selectedButton.titleLabel sizeToFit];
            self.indicatorLine.width = _selectedButton.titleLabel.width;
        }];
        
        if (_delegate &&[_delegate respondsToSelector:@selector(segment:didSelectColumnIndex:)]) {
            [_delegate segment:self didSelectColumnIndex:_selectedButton.tag];
        }
    }
}




-(void)clickButtonAction:(UIButton *)button {
    self.selectedButton = button;
}

@end
