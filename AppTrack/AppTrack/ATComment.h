//
//  ATComment.h
//  AppTrack
//
//  Created by Ethan Diamond on 8/7/12.
//  Copyright (c) 2012 Ethan Diamond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ATApp;

@interface ATComment : NSManagedObject

@property (nonatomic, retain) ATApp *app;

@end
