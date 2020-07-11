//
//  ProfileViewController.h
//  Instagram
//
//  Created by Jasdeep Gill on 7/6/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

// MARK: Properties
@property (strong, nonatomic) IGUser *theUser;

@end

NS_ASSUME_NONNULL_END
