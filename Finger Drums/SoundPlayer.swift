//
//  SoundPlayer.swift
//  Finger Drums
//
//  Created by Luis Cossío on 14/11/23.
//

import AVFoundation

class SoundPlayer: NSObject, AVAudioPlayerDelegate {
    // An array to hold the AVAudioPlayer instances
    private var audioPlayers: [AVAudioPlayer] = []
    
    //Function to play a sound given a filename
    
    func playSound(file: String) {
        //Use locateSoundFile fun to get the URL of the sound file
        guard let soundURL = locateSoundFile(file) else {
            print("Sound file not found")
            return
        }
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            audioPlayers.append(audioPlayer)
        } catch {
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }
    
    private func locateSoundFile(_ fileName: String) -> URL? {
        return Bundle.main.url(forResource: fileName, withExtension: nil)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let index = audioPlayers.firstIndex(of: player) {
            audioPlayers.remove(at: index)
        }
    }
}
