//
//  PhotoGridCell.m
//  Instagram
//
//  Created by Jasdeep Gill on 7/8/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import "PhotoGridCell.h"

@implementation PhotoGridCell

- (void)setPostImage {
    
    //self.profileView.defaultPictureViewBg.layer.cornerRadius = self.profileView.defaultPictureViewBg.frame.size.height / 2;

    self.postImageView.file = self.postIg[@"image"];
    //self.imagePostView.layer.cornerRadius = self.imagePostView.frame.size.height / 2;
    [self.postImageView loadInBackground];
    
}

@end
