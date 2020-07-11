//
//  SceneDelegate.h
//  Instagram
//
//  Created by Jasdeep Gill on 7/6/20.
//  Copyright © 2020 jazgill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

// MARK: Properties
@property (strong, nonatomic) UIWindow * window;

// MARK: Methods
- (void)changeRootViewController:(UIViewController*)vc :(BOOL)animated;

@end

