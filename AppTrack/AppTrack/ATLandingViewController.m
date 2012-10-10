//
//  ATLandingViewController.m
//  AppTrack
//
//  Created by Ethan Diamond on 8/7/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import "ATLandingViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "ATFindAppViewController.h"
#import "ATLandingViewAppCell.h"

@interface ATLandingViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *apps;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UIView *rankView;

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
    [self.collectionView reloadData];
}

#pragma mark - Collection View

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _apps.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ATLandingViewAppCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AppCell" forIndexPath:indexPath];
    cell.app = [_apps objectAtIndex:indexPath.row];
    return cell;
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

@end
