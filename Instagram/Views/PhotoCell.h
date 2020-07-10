//
//  PhotoCell.h
//  Instagram
//
//  Created by Jasdeep Gill on 7/7/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Parse;
#import "Post.h"
#import "IGUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCell : UITableViewCell
@property (strong, nonatomic) Post *postIg;
@property (weak, nonatomic) IBOutlet PFImageView *imagePostView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profilePictureView;


- (void)setPostValues;

@end

NS_ASSUME_NONNULL_END
