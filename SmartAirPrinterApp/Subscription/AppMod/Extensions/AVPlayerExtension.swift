//
//  AVPlayerExtension.swift
//  ModsApp
//
//  Created by David on 15.04.2023.
//

import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        let isPlayMyVideo = (rate != 0 && error == nil)
        return isPlayMyVideo
    }
}
