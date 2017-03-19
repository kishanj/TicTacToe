//
//  GameModeBeginner.m
//  TicTacToe
//
//  Created by Kishan Jayaraman on 3/16/17.
//  Copyright © 2017 Kishan Jayaraman. All rights reserved.
//

#import "GameModeBeginner.h"

@interface GameModeBeginner()

@end

@implementation GameModeBeginner

- (NSUInteger)bestMoveForPlayer:(nonnull Player *)player onGameBoard:(nonnull GameBoard *)board {
    // Random move for a beginner
    NSArray *vacantTiles = [board vacantTiles];
    if ([vacantTiles count]) {
        uint32_t rnd = arc4random_uniform((uint32_t)[vacantTiles count]);
        NSNumber *pos = [vacantTiles objectAtIndex:rnd];
        return [pos unsignedIntegerValue];
    }
    else {
        return NSUIntegerMax;
    }
}

@end

