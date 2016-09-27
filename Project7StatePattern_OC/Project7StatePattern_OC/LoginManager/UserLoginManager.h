//
//  UserLoginManager.h
//  Project7StatePattern_OC
//
//  Created by apple on 6/13/16.
//  Copyright © 2016 YangLu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserState.h"

@interface UserLoginManager : NSObject

+ (UserLoginManager*)shareInstance;

@property (nonatomic, strong) id<UserState> userState;

- (void)userToScan;

@end
