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
#define kWindow [UIApplication sharedApplication].keyWindow
#define kpingMuBounds [UIScreen mainScreen].bounds

@interface JTTabBar ()<DCPathButtonDelegate>

// 发布按钮
@property (strong,nonatomic)UIButton *publishButton;
@property (strong,nonatomic)UIView * publishView;
@end
@implementation JTTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /*
        UIButton *publishButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [publishButton setBackgroundImage:[UIImage  imageNamed:@"tabBar_publish_icon"] forState:(UIControlStateNormal)];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:(UIControlStateHighlighted)];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        */
        // 添加中间的button
        // [self addCenterButton];
        
        [self addCenterButton];
        
        
    }
    return self;
}

-(void)addCenterButton
{
    
    DCPathButton *dcPathButton = [[DCPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]
                                                         highlightedImage:[UIImage imageNamed:@"chooser-button-tab-highlighted"]];
    dcPathButton.delegate = self;
    
    // Configure item buttons
    //
    DCPathItemButton *itemButton_1 = [[DCPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-music"]
                                                           highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-music-highlighted"]
                                                            backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                                 backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    [itemButton_1 addTarget:self action:@selector(itemButton_1Action:) forControlEvents:(UIControlEventTouchUpInside)];
    
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
    [dcPathButton addPathItems:@[itemButton_1,
                                 itemButton_2,
                                 itemButton_3,
                                 itemButton_4,
                                 itemButton_5
                                 ]];
    
    // Change the bloom radius, default is 105.0f
    //
    dcPathButton.bloomRadius = 120.0f;
    
    // Change the DCButton's center
    //
    dcPathButton.dcButtonCenter = CGPointMake(self.bounds.size.width + 210, self.bounds.size.height + 20);
    
    // Setting the DCButton appearance
    //
    dcPathButton.allowSounds = YES;
    dcPathButton.allowCenterButtonRotation = YES;
    
    dcPathButton.bottomViewColor = [UIColor redColor];
    
    dcPathButton.bloomDirection =  kDCPathButtonBloomDirectionTop;
    
    [self addSubview:dcPathButton];
    

}



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





UIWindow * window;

-(void)publishClick
{
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
