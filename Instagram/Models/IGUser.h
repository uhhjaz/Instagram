//
//  IGUser.h
//  Instagram
//
//  Created by Jasdeep Gill on 7/9/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN
@import Parse;

@interface IGUser : PFUser

// MARK: Properties
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) PFFileObject *profileImageView;

// MARK: Methods
+ (IGUser *)user;
+ (BOOL)isLoggedIn;
+ (void) updateUserProfileImage: ( UIImage * _Nullable )image withCompletion: (PFBooleanResultBlock  _Nullable)completion;
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;

@end

NS_ASSUME_NONNULL_END
