//
//  ATLandingViewController.m
//  AppTrack
//
//  Created by Ethan Diamond on 8/7/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import "ATLandingViewController.h"

#import "ATLandingAppCell.h"
#import "ATDetailViewController.h"

@interface ATLandingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *apps;

- (void)loadApps;

@end

@implementation ATLandingViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadApps];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _apps.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != _apps.count)
    {
        ATLandingAppCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AppCell"];
        cell.app = [_apps objectAtIndex:indexPath.row];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"NewCell"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != _apps.count)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ATDetailViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Details"];
        controller.app = [_apps objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)loadApps
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"App"];
    _apps = [[ATDataManager sharedManager].mainContext executeFetchRequest:request error:nil];
}

@end
