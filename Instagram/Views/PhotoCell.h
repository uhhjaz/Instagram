//
//  PhotoCell.h
//  Instagram
//
//  Created by Jasdeep Gill on 7/7/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import <UIKit/UIKit.h>

// MARK: Models
#import "Post.h"
#import "IGUser.h"


NS_ASSUME_NONNULL_BEGIN

@import Parse;

@protocol PhotoCellDelegate;

@interface PhotoCell : UITableViewCell
@property (nonatomic, weak) id<PhotoCellDelegate> delegate;
@property (strong, nonatomic) Post *postIg;
@property (weak, nonatomic) IBOutlet PFImageView *imagePostView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profilePictureView;


- (void)setPostValues;

@end

@protocol PhotoCellDelegate

- (void)photoCell:(PhotoCell *) photoCell didTap: (IGUser *)user;

@end

NS_ASSUME_NONNULL_END
