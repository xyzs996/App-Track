//
//  ATDetailViewController.m
//  AppTrack
//
//  Created by Ethan Diamond on 8/14/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import "ATDetailViewController.h"

#import "AFNetworking/AFNetworking.h"

@interface ATDetailViewController ()

@property (nonatomic, strong) ATApp *detailedApp;
@property (nonatomic, weak) IBOutlet UIImageView *iconView;
@property (nonatomic, weak) IBOutlet UILabel *appName;
@property (nonatomic, weak) IBOutlet UILabel *rank;

@end

@implementation ATDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ATApp detailedAppWithApp:_app handler:^(ATApp *app, NSError *error)
    {
        self.detailedApp = app;
    }];
}

- (void)setDetailedApp:(ATApp *)detailedApp
{
    _detailedApp = detailedApp;
    
    _rank.text = detailedApp.rank;
    _appName.text = detailedApp.name;
    [_iconView setImageWithURL:[NSURL URLWithString:detailedApp.iconURL]];
}

@end
