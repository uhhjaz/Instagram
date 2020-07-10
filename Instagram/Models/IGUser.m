//
//  IGUser.m
//  Instagram
//
//  Created by Jasdeep Gill on 7/9/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import "IGUser.h"

@implementation IGUser

@dynamic name;

+ (IGUser *)user {
    return (IGUser *)[PFUser user];
}

+ (BOOL)isLoggedIn
{
    return [IGUser currentUser] ? YES: NO;
}


@end
