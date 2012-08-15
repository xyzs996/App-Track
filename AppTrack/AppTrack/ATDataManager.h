//
//  DLDataManager.h
//  FlyDelta
//
//  Created by Tyler Stromberg on 3/1/12.
//  Copyright (c) 2012 Delta Air Lines. All rights reserved.
//
//  Manager for all of the Core Data interaction (instead of having all of this in the app delegate)

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface ATDataManager : NSObject

// The main managed object context. This should only ever be used from the main thread.
@property (nonatomic, strong, readonly) NSManagedObjectContext *mainContext;

+ (ATDataManager *)sharedManager;
+ (NSManagedObjectContext *)mainContext;

- (BOOL)saveMainContext;

@end
