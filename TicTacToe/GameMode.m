//
//  GameMode.m
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/8/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import "GameMode.h"

@interface GameMode()

@property (nonatomic, strong, nonnull) Player *player1;
@property (nonatomic, strong, nonnull) Player *player2;

@end

@implementation GameMode

- (nonnull id)initWithPlayer1:(nonnull Player *)player1 andPlayer2:(nonnull Player *)player2 {
    if (self = [super init]) {
        _player1 = player1;
        _player2 = player2;
    }
    
    return self;
}

- (nullable Player *)turn {
    NSUInteger tag = [self generateRandomNumberWithlowerBound:[_player1 tag] upperBound:[_player2 tag]];
    if (tag == [_player1 tag]) {
        return _player1;
    }
    else if (tag == [_player2 tag]) {
        return _player2;
    }
    else {
        return nil;
    }
}

- (NSUInteger)generateRandomNumberWithlowerBound:(NSUInteger)lowerBound
                               upperBound:(NSUInteger)upperBound
{
    NSUInteger rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    return rndValue;
}

- (NSUInteger)bestMoveForPlayer:(nonnull Player *)player onGameBoard:(nonnull GameBoard *)board {
    return NSUIntegerMax;
}

@end
