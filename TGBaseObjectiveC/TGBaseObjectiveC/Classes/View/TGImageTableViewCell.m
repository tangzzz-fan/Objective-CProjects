//
//  TGImageTableViewCell.m
//  TGBaseObjectiveC
//
//  Created by MacPro on 2017/12/11.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "TGImageTableViewCell.h"
#import "TGImageModel.h"
@implementation TGImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setImageModel:(TGImageModel *)imageModel {
    _imageModel = imageModel;
    [self initWithImageViewModel];
}

- (void)initWithImageViewModel {
//    self.imageView1.image = [UIImage imageNamed:self.imageModel.imageName];
//    self.imageView2.image = [UIImage imageNamed:self.imageModel.imageName];
//    self.imageView3.image = [UIImage imageNamed:self.imageModel.imageName];
//    self.desLabel.text = self.imageModel.name;
    UIImage *image = [UIImage imageNamed:self.imageModel.imageName];
    [self.imageView1 performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
    [self.imageView2 performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
    [self.imageView3 performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];

}

@end
