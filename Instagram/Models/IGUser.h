//
//  IGUser.h
//  Instagram
//
//  Created by Jasdeep Gill on 7/9/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface IGUser : PFUser

@property (nonatomic, strong) NSString *name;

+ (IGUser *)user;
+ (BOOL)isLoggedIn;

@end

NS_ASSUME_NONNULL_END
