//
//  ATFindAppCell.m
//  AppTrack
//
//  Created by Ethan Diamond on 8/7/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import "ATFindAppCell.h"

#import "AFNetworking.h"

@interface ATFindAppCell ()

@property (nonatomic, weak) IBOutlet UIImageView *iconView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@end

@implementation ATFindAppCell

- (void)setApp:(ATApp *)app
{
    _app = app;
    
    _nameLabel.text = _app.name;
    [_iconView setImageWithURL:[NSURL URLWithString:_app.iconURL]];
}

@end
