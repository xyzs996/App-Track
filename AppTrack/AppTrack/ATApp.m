//
//  ATApp.m
//  AppTrack
//
//  Created by Ethan Diamond on 8/7/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import "ATApp.h"
#import "ATComment.h"

#import "AFNetworking/AFNetworking.h"

@implementation ATApp

@dynamic name;
@dynamic iconURL;
@dynamic belongsToUser;
@dynamic category;
@dynamic paid;
@dynamic competingApps;
@dynamic comments;
@dynamic cost;
@dynamic halfStars;

@synthesize icon = _icon;

+ (NSOperation *)appsMatchingSearchString:(NSString *)searchString handler:(void (^)(NSArray *apps, NSError *error))handler
{
    NSString *filepath = [NSString stringWithFormat:@"http://itunes.apple.com/search?entity=software&term=%@", searchString];
    NSURL *url = [NSURL URLWithString:filepath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
                                        {
                                            NSMutableArray *apps = [@[] mutableCopy];
                                            NSArray *results = [JSON objectForKey:@"results"];
                                            for (NSDictionary *result in results)
                                            {
                                                NSEntityDescription *description = [NSEntityDescription entityForName:@"App" inManagedObjectContext:[ATDataManager mainContext]];
                                                ATApp *app = [[ATApp alloc] initWithEntity:description insertIntoManagedObjectContext:nil];
                                                
                                                app.name = [result objectForKey:@"trackCensoredName"];
                                                app.iconURL = [result objectForKey:@"artworkUrl60"];
                                                app.category = [[result objectForKey:@"genreIds"] objectAtIndex:0];
                                                app.paid = ![[result objectForKey:@"formattedPrice"] isEqualToString:@"Free"];
                                                [apps addObject:app];
                                            }
                                                                                    
                                            handler(apps, nil);
                                        }
                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                                        {
                                            handler(nil, error);
                                        }];
    
    [[NSOperationQueue mainQueue] addOperation:operation];
    
    return operation;
}

@end
