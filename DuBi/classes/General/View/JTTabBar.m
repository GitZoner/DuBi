//
//  JTTabBar.m
//  Bester
//
//  Created by lanou3g on 16/5/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "JTTabBar.h"
#import "ZDPublishView.h"
#import <POP.h>
#import "UIView+XYWidthHeight.h"
#import <DCPathButton.h>
#import "ZDPublishController.h"
#import "ZDPublishHaflView.h"

#define kWindow [UIApplication sharedApplication].keyWindow
#define kpingMuBounds [UIScreen mainScreen].bounds

@interface JTTabBar ()

// 发布按钮
@property (strong,nonatomic)UIButton *publishButton;
@property (strong,nonatomic)UIView * publishView;
@property (strong ,nonatomic) DCPathButton *dcPathButton;
@end

@implementation JTTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *publishButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [publishButton setBackgroundImage:[UIImage  imageNamed:@"tabbar_+"] forState:(UIControlStateNormal)];
        // [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:(UIControlStateHighlighted)];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
    }
    return self;
}

/*
-(void)addCenterButton
{
    
    self.dcPathButton = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]
                                                         highlightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    
     _dcPathButton.delegate = self;
    
    // Configure item buttons
    //
    
    DCPathItemButton *itemButton_1  = nil;
    
    itemButton_1 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-music"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-music-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
//    itemButton_1.delegate = self;
    DCPathItemButton *itemButton_2 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-place"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-place-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_3 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-camera"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-camera-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_4 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-thought"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-thought-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    DCPathItemButton *itemButton_5 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-sleep"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-sleep-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    // Add the item button into the center button
    //
    [_dcPathButton addPathItems:@[itemButton_1,
                                 itemButton_2,
                                 itemButton_3,
                                 itemButton_4,
                                 itemButton_5
                                 ]];
    
    // Change the bloom radius, default is 105.0f
    //
    _dcPathButton.bloomRadius = 100.0f;
    
    // Change the DCButton's center
    //
    _dcPathButton.dcButtonCenter = CGPointMake(self.bounds.size.width + 210, self.bounds.size.height + 20);
    
    // Setting the DCButton appearance
    //
    _dcPathButton.allowSounds = YES;
    _dcPathButton.allowCenterButtonRotation = YES;
    
    _dcPathButton.bottomViewColor = [UIColor redColor];
    
    _dcPathButton.bloomDirection =  kDCPathButtonBloomDirectionTop;
    
    [self addSubview:_dcPathButton];
    
}
*/
/*
#pragma mark --- 子button的事件。
// 子button的点击事件
-(void)itemButton_1Action:(DCPathItemButton * )button
{
    NSLog(@"左数第1个button");
}

-(void)itemButton_2Action:(DCPathItemButton * )button
{
    NSLog(@"左数第2个button");
}

-(void)itemButton_3Action:(DCPathItemButton * )button
{
    NSLog(@"左数第3个button");
}

-(void)itemButton_4Action:(DCPathItemButton * )button
{
    NSLog(@"左数第4个button");
}

-(void)itemButton_5Action:(DCPathItemButton * )button
{
    NSLog(@"左数第5个button");
}





#pragma mark - DCPathButton Delegate

- (void)willPresentDCPathButtonItems:(DCPathButton *)dcPathButton {
    
    NSLog(@"ItemButton will present");
}

- (void)pathButton:(DCPathButton *)dcPathButton clickItemButtonAtIndex:(NSUInteger)itemButtonIndex {
    NSLog(@"You tap %@ at index : %lu", dcPathButton, (unsigned long)itemButtonIndex);
}

- (void)didPresentDCPathButtonItems:(DCPathButton *)dcPathButton {
    
    NSLog(@"ItemButton did present");
}
*/

// BUTTON按钮的点击事件

UIWindow const * window;
-(void)publishClick
{

   // [UIView animateWithDuration:1 animations:^{
       
        window = [[UIWindow alloc]init];
        window.frame = [UIScreen mainScreen].bounds;
        window.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
        window.hidden = NO;
        ZDPublishHaflView  * publishView = [[ZDPublishHaflView alloc]initWithFrame:CGRectMake(0, self.window.height / 3 * 2, self.window.width, self.window.height / 3)];
        // publishView.backgroundColor = [UIColor blueColor];
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(publishView.width /2 - 15, publishView.height - 30, 30, 30)];
        [button setTitle:@"x" forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize:30];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
        [window addSubview:publishView];
        // self.block(window);
        [publishView addSubview:button];

   // }];
    
//    if(_wodeDelegate && [_wodeDelegate respondsToSelector:@selector(presentView)]) {
//        [_wodeDelegate presentView];
//    }


    /*
    ZDPublishView * publishView = [ZDPublishView publishView];

//    [UIView animateWithDuration:0.5 animations:^{
//        publishView.transform = CGAffineTransformRotate(publishView.transform, 0.2);
//    }];
    // [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];


    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    window.backgroundColor = [UIColor redColor];
    publishView.frame = window.frame;
    
    self.publishView = publishView;
    
    POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.fromValue = [NSValue valueWithCGRect:CGRectMake(- kpingMuBounds.size.width, self.height * 2, publishView.width / 2, publishView.height / 2)];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, publishView.width, publishView.height)];
     
//    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(- kpingMuBounds.size.width, self.height)];
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(kpingMuBounds.size.width / 2   , kpingMuBounds.size.height / 2)];
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    // anim.beginTime = CACurrentMediaTime() + 0.5; // 在某些动画执行完毕多久才执行
    [publishView pop_addAnimation:anim forKey:nil];

    [window addSubview:publishView];
     */
}

-(void)buttonAction
{
    window.hidden = YES;
}


-(void)timeAction
{
    [UIView animateWithDuration:0.5 animations:^{
        self.publishView.transform = CGAffineTransformRotate(self.publishView.transform, M_2_PI);
    }];

}

-(void)layoutSubviews {
    [super layoutSubviews];
    // 设置发布按钮的 frame
    
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    // 设置其他 UITabBarButton 的 frame
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttomW = self.frame.size.width / 5;
    CGFloat buttomH = self.frame.size.height;
    
    // 添加一个索引，用于跳过中间的按钮
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        // 如果不是UITabBarButton 这个类就跳过
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 计算按钮的 X 值
        buttonX = buttomW * ((index > 1)? (index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttomW, buttomH);
        // 增加索引
        index ++;
    }
    
}

@end
