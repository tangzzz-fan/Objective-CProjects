//
//  XXPerson.m
//  TestObjcBase
//
//  Created by MacPro on 02/07/2018.
//  Copyright © 2018 Centaline. All rights reserved.
//

#import "XXPerson.h"
#define TallMask (1<<2) // 4
#define RichMask (1<<1) // 2
#define HandsomeMask (1<<0) // 1

@implementation XXPerson


- (BOOL)isTall
{
    return _tallRichHandsome.tall;
}
- (BOOL)isRich
{
    return _tallRichHandsome.rich;
}
- (BOOL)isHandsome
{
    return _tallRichHandsome.handsome;
}

- (void)setTall:(BOOL)tall
{
    _tallRichHandsome.tall = tall;
}
- (void)setRich:(BOOL)rich
{
    _tallRichHandsome.rich = rich;
}
- (void)setHandsome:(BOOL)handsome
{
    _tallRichHandsome.handsome = handsome;
}

@end
