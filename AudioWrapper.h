//
//  AudioWrapper.h
//  ConvertAudio
//
//  Created by DoLH on 12/18/17.
//  Copyright © 2017 DoLH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioWrapper : NSObject

+ (void)convertFromWavToMp3:(NSString *)filePath;

@end
