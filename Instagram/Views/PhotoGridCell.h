//
//  PhotoGridCell.h
//  Instagram
//
//  Created by Jasdeep Gill on 7/8/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "HomeFeedViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "PostDetailViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "PhotoCell.h"
#import "Post.h"
#import "IGUser.h"

@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoGridCell : UICollectionViewCell
@property (strong, nonatomic) Post *postIg;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
- (void)setPostImage;

@end

NS_ASSUME_NONNULL_END
