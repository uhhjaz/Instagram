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
@dynamic profileImageView;

+ (IGUser *)user {
    return (IGUser *)[PFUser user];
}

+ (BOOL)isLoggedIn
{
    return [IGUser currentUser] ? YES: NO;
}

+ (void) updateUserProfileImage: ( UIImage * _Nullable )image withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    IGUser *theUser = [IGUser currentUser];
    theUser.profileImageView = [self getPFFileFromImage:image];
    [theUser saveInBackgroundWithBlock: completion];
    
}


+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
