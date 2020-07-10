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
    
    int totalwidth = self.contentView.bounds.size.width;
    int numberOfCellsPerRow = 3;
    int dimensions = (CGFloat)(totalwidth / numberOfCellsPerRow);
    //[self.postImageView.layer setBounds:CGRectMake(dimensions, dimensions)];
    //self.postImageView.layer.frame.size.height = dimensions;
    //self.postImageView.layer.frame.size.width = dimensions;
    [self.postImageView loadInBackground];
    
}

@end
