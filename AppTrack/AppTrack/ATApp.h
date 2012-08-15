//
//  ATApp.h
//  AppTrack
//
//  Created by Ethan Diamond on 8/7/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ATApp, ATComment;

@interface ATApp : NSManagedObject

//Persisted
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * iconURL;
@property (nonatomic, retain) NSString * cost;
@property (nonatomic) BOOL belongsToUser;
@property (nonatomic) NSString *category;
@property (nonatomic) int16_t halfStars;
@property (nonatomic) BOOL paid;
@property (nonatomic, retain) NSSet *competingApps;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, strong) NSString *appId;

//Unpersisted
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *rank;

+ (NSOperation *)appsMatchingSearchString:(NSString *)searchString handler:(void (^)(NSArray *apps, NSError *error))handler;
+ (NSOperation *)detailedAppWithApp:(ATApp *)app handler:(void (^)(ATApp *app, NSError *error))handler;

@end

@interface ATApp (CoreDataGeneratedAccessors)

- (void)addCompetingAppsObject:(ATApp *)value;
- (void)removeCompetingAppsObject:(ATApp *)value;
- (void)addCompetingApps:(NSSet *)values;
- (void)removeCompetingApps:(NSSet *)values;

- (void)addCommentsObject:(ATComment *)value;
- (void)removeCommentsObject:(ATComment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
