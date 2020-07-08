//
//  PostDetailViewController.h
//  Instagram
//
//  Created by Jasdeep Gill on 7/8/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@import Parse;

@interface PostDetailViewController : UIViewController

@property (strong, nonatomic) Post *postIg;

@end

NS_ASSUME_NONNULL_END
