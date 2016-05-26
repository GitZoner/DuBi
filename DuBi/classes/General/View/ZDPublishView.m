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
#import <POP.h>

#define kpingMuBounds [UIScreen mainScreen].bounds
@interface ZDPublishView ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
//@property (weak, nonatomic) IBOutlet UIImageView *bgImg;

@end

@implementation ZDPublishView
+(instancetype)publishView
{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

-(void)awakeFromNib
{
    /*
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = CGRectMake(0, -50, self.bounds.size.width, 50);
    [self.layer addSublayer:emitter];
    
    emitter.emitterShape = kCAEmitterLayerRectangle;
    //configure emitter
    //    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
    emitter.emitterSize = emitter.frame.size;
    
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"snow"].CGImage;
    cell.contentsScale = 7;
    
    cell.birthRate = 100;
    cell.lifetime = 5.0;
    cell.lifetimeRange = 5;
    
    cell.redRange = 0.1;
    cell.greenRange = 0.1;
    cell.blueRange = 0.1;
    
    cell.alphaRange = 0.8;
    cell.alphaSpeed = -0.10;
    
    cell.yAcceleration = 30;
    cell.xAcceleration = 20;
    cell.velocity = 20;
    cell.velocityRange = 200;
    cell.emissionRange = M_PI_2;
    cell.emissionLongitude = - M_PI;
    
    //add particle template to emitter
    emitter.emitterCells = @[cell];
    */

    

    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shareBottomBackground"]];
    imageView.frame = [UIScreen mainScreen].bounds;
    imageView.userInteractionEnabled = YES;
    [self insertSubview:imageView atIndex:0];
//    [self addSubview:imageView];
    
    NSArray * images = @[@"publish-text",@"publish-picture"];
    NSArray * texts = @[@"发段子",@"发图片"];
    CGFloat buttonW = 72;
    CGFloat buttonH = 72 + 30;
    CGFloat buttonY = ([UIScreen mainScreen].bounds.size.height - buttonH) / 5 * 3;
    CGFloat buttonX =( [UIScreen mainScreen].bounds.size.width - buttonW * 2) / 3;
    // button之间的距离
    // CGFloat xMargin = self.width - buttonW * 2  - 2 * buttonX;
    for (int i = 0 ; i < texts.count; i++) {
        ZDCustomButton * button = [[ZDCustomButton alloc]init];
        [imageView addSubview:button];
        [button setTitle:texts[i] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.titleLabel.textColor = [UIColor blackColor];
        [button setTintColor:[UIColor colorWithRed:0.496 green:0.496 blue:0.496 alpha:1.0]];
        button.imageView.image =[UIImage imageNamed:images[i]];
        button.frame = CGRectMake(buttonX + (i * buttonW) + i * buttonX,buttonY,buttonW, buttonH);
    }
}
- (IBAction)backB:(id)sender {
    
    POPSpringAnimation * anim = [POPSpringAnimation  animationWithPropertyNamed:kPOPViewFrame];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(kpingMuBounds.size.width, kpingMuBounds.origin.y, self.width, self.height)];
    anim.beginTime = CACurrentMediaTime() + 0.15;
    [anim setCompletionBlock:^(POPAnimation * anim, BOOL finsh) {
        [self removeFromSuperview];
    }];
    [self pop_addAnimation:anim forKey:nil];
}





@end
