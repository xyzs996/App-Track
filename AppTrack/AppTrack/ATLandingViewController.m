//
//  ATLandingViewController.m
//  AppTrack
//
//  Created by Ethan Diamond on 8/7/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import "ATLandingViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "ATApp.h"
#import "ATFindAppViewController.h"
#import "ATLandingViewAppScrollView.h"

@interface ATLandingViewController () <ATLandingViewAppScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *apps;
@property (nonatomic, strong) NSOperation *fetchOperation;

@property (nonatomic, weak) IBOutlet ATLandingViewAppScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *rankView;
@property (nonatomic, weak) IBOutlet UILabel *rankLabel;
@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) int appIndex;

@end

#pragma mark -

@implementation ATLandingViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    self.rankView.layer.borderColor = [UIColor blackColor].CGColor;
    self.rankView.layer.borderWidth = 1.0f;
    self.rankView.layer.cornerRadius = 15.0f;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadApps];
    
    if (self.apps.count)
    {
        self.scrollView.apps = self.apps;
        [self appScrollViewFinishedScrollingOnApp:[self.apps objectAtIndex:0]];
    }
}

#pragma mark - Scroll View

- (void)appScrollViewBeganScrolling
{
    if (_activityIndicator.hidden)
    {
         [self showApp:nil];
    }
   
    [_fetchOperation cancel];
}

- (void)appScrollViewFinishedScrollingOnApp:(ATApp *)app
{
    NSLog(@"Finding app: %@", app.name);
    
    _fetchOperation = [ATApp detailedAppWithApp:app handler:^(ATApp *app, NSError *error)
    {
        NSLog(@"DONE");
        
        if (error)
        {
            NSLog(@"%@", error);
        }
        
        [self showApp:app];
    }];
}

#pragma mark - Convenience

- (void)loadApps
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"App"];
    self.apps = [[[ATDataManager sharedManager].mainContext executeFetchRequest:request error:nil] mutableCopy];
    
    //To have two wrap around...
    if (self.apps.count == 2)
    {
        [self.apps addObject:[self.apps objectAtIndex:0]];
        [self.apps addObject:[self.apps objectAtIndex:1]];
    }
}

- (void)showApp:(ATApp *)app
{
    if (!app)
    {
        _activityIndicator.hidden = NO;
        _rankLabel.hidden = YES;
        _categoryLabel.hidden = YES;
        _nameLabel.hidden = YES;
        return;
    }
    
    _activityIndicator.hidden = YES;
    _rankLabel.hidden = NO;
    _rankLabel.text = app.rank;
    _categoryLabel.hidden = NO;
    _categoryLabel.text = app.category;
    _nameLabel.hidden = NO;
    _nameLabel.text = app.name;
}

@end
