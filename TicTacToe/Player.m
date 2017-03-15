//
//  Player.m
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/7/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)initWithName:(NSString *)name andTag:(NSUInteger)tag andImage:(UIImage *)image andColor:(UIColor *)color andType:(PlayerType)type {
    _name = name;
    _tag = tag;
    _image = image;
    _color = color;
    _type = type;
    return self;
}

@end
