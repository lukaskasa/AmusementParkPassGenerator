//
//  SoundPlayer.swift
//  Pass Generator
//
//  Created by Lukas Kasakaitis on 27.05.19.
//  Copyright © 2019 Lukas Kasakaitis. All rights reserved.
//

import Foundation
import AVFoundation

class SoundPlayer {
    
    static func playSound(for error: AccessError) {
        var sound: SystemSoundID = 0
        let path = Bundle.main.path(forResource: error.rawValue, ofType: "wav")!
        let soundURL = URL(fileURLWithPath: path) as CFURL
        AudioServicesCreateSystemSoundID(soundURL, &sound)
        AudioServicesPlaySystemSound(sound)
    }
    
}
