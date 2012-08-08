//
//  ATFindAppViewController.m
//  AppTrack
//
//  Created by Ethan Diamond on 8/7/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import "ATFindAppViewController.h"

#import "ATFindAppCell.h"

@interface ATFindAppViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *apps;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSOperation *searchOperation;

@end

@implementation ATFindAppViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"Loaded");
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FindAppCell";
    ATFindAppCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.app = _apps[indexPath.row];
    
    return cell;
}

#pragma mark - Search Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length > 1)
    {
        if (_searchOperation)
        {
            [_searchOperation cancel];
        }
        
        _searchOperation = [ATApp appsMatchingSearchString:searchText handler:^(NSArray *apps, NSError *error)
        {
            NSLog(@"DONE");
        }];
    }
}

@end
