//
//  MusicPlayManager.swift
//  backgroundTimerPractice
//
//  Created by 송기원 on 2023/05/08.
//

import Foundation
import AVKit

class MusicPlayManager {
    static let shared = MusicPlayManager()
    var player: AVAudioPlayer?

    private init() {}
    
    func playSound(name: String) {

        guard let url = Bundle.main.url(forResource: name, withExtension: ".mp3") else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("재생하는데 오류가 발생했습니다. \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        player?.stop()
    }
}
