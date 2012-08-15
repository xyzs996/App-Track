//
//  ATLandingAppCell.m
//  AppTrack
//
//  Created by Ethan Diamond on 8/14/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import "ATLandingAppCell.h"

#import "AFNetworking/AFNetworking.h"

@interface ATLandingAppCell()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *appIcon;

@end

@implementation ATLandingAppCell

- (void)setApp:(ATApp *)app
{
    _app = app;
    
    _titleLabel.text = app.name;
    [_appIcon setImageWithURL:[NSURL URLWithString:app.iconURL]];
}

@end
