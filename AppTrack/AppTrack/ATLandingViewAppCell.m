//
//  ATLandingViewAppCell.m
//  AppTrack
//
//  Created by Ethan Diamond on 10/9/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import "ATLandingViewAppCell.h"

#import <QuartzCore/QuartzCore.h>

#import "AFNetworking.h"

@interface ATLandingViewAppCell()

@property (nonatomic, weak) IBOutlet UIImageView *icon;

@end

#pragma mark -

@implementation ATLandingViewAppCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.icon.layer.cornerRadius = 15.0f;
}

- (void)setApp:(ATApp *)app
{
    _app = app;
    
    [self.icon setImageWithURL:[NSURL URLWithString:app.iconURL]];
}

@end
