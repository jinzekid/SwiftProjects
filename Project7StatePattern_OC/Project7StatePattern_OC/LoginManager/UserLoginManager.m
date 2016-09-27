//
//  UserLoginManager.m
//  Project7StatePattern_OC
//
//  Created by apple on 6/13/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

#import "UserLoginManager.h"

static UserLoginManager* _instance = nil;

@implementation UserLoginManager

@synthesize userState;

+ (UserLoginManager*)shareInstance {
    
    //Create a token that facilitates only creating this item once.
    static dispatch_once_t onceToken;
    
    //Use Grand Central Dispatch to create a single instance and do any initial setup only once.
    dispatch_once(&onceToken, ^{
        //These are only invoked the onceToken has never been used before.
        _instance = [[UserLoginManager alloc] init];
    });
    
    //Returns the shared instance variable.
    return _instance;
}

- (void)userToScan {
    [userState userToScan];
}

@end
