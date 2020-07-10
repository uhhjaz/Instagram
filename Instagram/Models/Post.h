//
//  Post.h
//  Instagram
//
//  Created by Jasdeep Gill on 7/7/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import <Parse/Parse.h>

// MARK: Models
#import "IGUser.h"


NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) IGUser *author;
@property (nonatomic, strong) NSString *postedDate;

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end



NS_ASSUME_NONNULL_END
