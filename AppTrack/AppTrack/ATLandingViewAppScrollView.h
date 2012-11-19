//
//  ATLandingViewAppScrollView.h
//  AppTrack
//
//  Created by Ethan Diamond on 10/10/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ATApp.h"

@interface ATLandingViewAppScrollView : UIScrollView

@property (nonatomic, strong) NSMutableArray *apps;

@end

#pragma mark -

@protocol ATLandingViewAppScrollViewDelegate <NSObject>

- (void)appScrollViewBeganScrolling;
- (void)appScrollViewFinishedScrollingOnApp:(ATApp *)app;

@end