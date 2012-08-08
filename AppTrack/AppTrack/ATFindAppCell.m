//
//  ATFindAppCell.m
//  AppTrack
//
//  Created by Ethan Diamond on 8/7/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import "ATFindAppCell.h"

@interface ATFindAppCell ()

@property (nonatomic, weak) IBOutlet UIImageView *iconView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *costCategoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *starsLabel;

@end

@implementation ATFindAppCell

- (void)setApp:(ATApp *)app
{
    _app = app;
    
    _nameLabel.text = _app.name;
    _costCategoryLabel.text = _app.cost;
    _starsLabel.text = @"***";
}

@end
