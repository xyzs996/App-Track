//
//  ATFindAppViewController.m
//  AppTrack
//
//  Created by Ethan Diamond on 8/7/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import "ATFindAppViewController.h"

#import "ATFindAppCell.h"

@interface ATFindAppViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) ATApp *chosenApp;
@property (nonatomic, strong) NSArray *apps;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSOperation *searchOperation;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;

- (IBAction)cancelButtonTouched:(id)sender;

@end

@implementation ATFindAppViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_searchBar becomeFirstResponder];
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FindAppCell";
    ATFindAppCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.app = _apps[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _chosenApp = _apps[indexPath.row];;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save app?" message:@"" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alertView show];
}

#pragma mark - Alert Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [[ATDataManager mainContext] insertObject:_chosenApp];
        [[ATDataManager mainContext] save:nil];
        [self dismissModalViewControllerAnimated:YES];
    }
}

#pragma mark - Search Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searching");
    
    _searchOperation = [ATApp appsMatchingSearchString:searchBar.text handler:^(NSArray *apps, NSError *error)
    {
        _apps = apps;
        [self.tableView reloadData];
    }];
}

#pragma mark - IBAction

- (IBAction)cancelButtonTouched:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
