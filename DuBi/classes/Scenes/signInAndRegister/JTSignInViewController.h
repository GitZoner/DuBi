//
//  JTSignInViewController.h
//  DuBi
//
//  Created by Jason on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JTAliasViewControllerDelegate <NSObject>

-(void)reloadView;

@end

@interface JTSignInViewController : UIViewController
@property(weak,nonatomic)id<JTAliasViewControllerDelegate>delegate;
@end
