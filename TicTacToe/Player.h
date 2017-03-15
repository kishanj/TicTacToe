//
//  Player.h
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/7/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PlayerType) {
    PlayerTypeUnknown,
    PlayerTypeUser,
    PlayerTypeComputer
};

@interface Player : NSObject

@property (nonatomic, strong) NSString *name;
@property NSUInteger tag;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIColor *color;
@property PlayerType type;

- (id)initWithName:(NSString *)name andTag:(NSUInteger)tag andImage:(UIImage *)image andColor:(UIColor *)color andType:(PlayerType)type;

@end
