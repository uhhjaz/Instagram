//
//  PhotosViewController.h
//  Instagram
//
//  Created by Jasdeep Gill on 7/7/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN


@protocol PhotosViewControllerDelegate

- (void)didPost:(Post *)post;

@end

@interface PhotosViewController : UIViewController

@property (nonatomic, weak) id<PhotosViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
