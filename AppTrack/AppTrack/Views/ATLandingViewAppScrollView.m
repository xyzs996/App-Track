//
//  ATLandingViewAppScrollView.m
//  AppTrack
//
//  Created by Ethan Diamond on 10/10/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import "ATLandingViewAppScrollView.h"

#import "AFNetworking.h"

static NSInteger kIconWidth = 100.0f;
static NSInteger kIconSpacing = 10.0f;

@interface ATLandingViewAppScrollView () <UIScrollViewDelegate>

@property (nonatomic) int currentIndex;
@property (nonatomic, weak) IBOutlet id exposedDelegate;

@end

#pragma mark -

@implementation ATLandingViewAppScrollView 

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.delegate = self;
    }
    return self;
}

- (void)setApps:(NSMutableArray *)apps
{
    _apps = apps;
    
    //Remove old subviews
    for (UIView *subview in self.subviews)
    {
        [subview removeFromSuperview];
    }
    
    //Add new ones
    int index = 0;
    for (ATApp *app in _apps)
    {
        CGFloat originX = index * (kIconWidth + (2 * kIconSpacing));
        CGRect frame = CGRectMake(originX, kIconSpacing, kIconWidth, kIconWidth);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView setImageWithURL:[NSURL URLWithString:app.iconURL]];
        [self addSubview:imageView];
        
        index++;
    }
    
    //Content size
    self.contentSize = CGSizeMake(index * (kIconWidth + (2 * kIconSpacing)), self.frame.size.height);
}

#pragma mark - Scroll View Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.exposedDelegate appScrollViewBeganScrolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self pageToNearestApp];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self pageToNearestApp];
}

- (void)pageToNearestApp
{
    //Zoom to nearest app
    _currentIndex = self.contentOffset.x / (kIconWidth + (2 * kIconSpacing));
    CGRect scrollToVisibleRect = CGRectMake(_currentIndex * (kIconWidth + (2 * kIconSpacing)), 0, 1.0f, 1.0f);
    [self scrollRectToVisible:scrollToVisibleRect animated:YES];
    
    //Fire delegate
    ATApp *app = [_apps objectAtIndex:_currentIndex];
    [self.exposedDelegate appScrollViewFinishedScrollingOnApp:app];
}

- (void)setDelegate:(id<UIScrollViewDelegate>)delegate
{
    if (delegate == self)
    {
        [super setDelegate:delegate];
    }
    else
    {
        _exposedDelegate = delegate;
    }
}

@end
