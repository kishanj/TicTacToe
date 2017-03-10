//
//  AppDelegate.h
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/3/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (Game *)game;

@end

