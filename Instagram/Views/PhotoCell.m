//
//  PhotoCell.m
//  Instagram
//
//  Created by Jasdeep Gill on 7/7/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import "PhotoCell.h"
#import <Parse/Parse.h>

@implementation PhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPostValues {
    
    //self.profileView.defaultPictureViewBg.layer.cornerRadius = self.profileView.defaultPictureViewBg.frame.size.height / 2;
    self.captionLabel.text = self.postIg[@"caption"];
    self.imagePostView.file = self.postIg[@"image"];
    //self.imagePostView.layer.cornerRadius = self.imagePostView.frame.size.height / 2;
    IGUser *user = self.postIg[@"author"];
    self.usernameLabel.text = user.username;
    [self.imagePostView loadInBackground];
    
}

@end
