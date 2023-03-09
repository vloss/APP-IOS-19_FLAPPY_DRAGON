//
//  GameViewController.swift
//  Flappy Dragon
//
//  Created by Vinicius Loss on 04/03/23.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation


class GameViewController: UIViewController {
    
    var stage: SKView!
    var muscicPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stage = view as! SKView
        stage.ignoresSiblingOrder = true // Para fazer manualmente o posicionamento de elementos no eixo Z
        
        presentScene()
        playMusic()
    }
    
    func playMusic (){
        if let musicURL = Bundle.main.url(forResource: "music", withExtension: "m4a"){
            muscicPlayer = try! AVAudioPlayer(contentsOf: musicURL)
            muscicPlayer.numberOfLoops = -1
            muscicPlayer.volume = 0.4
            muscicPlayer.play()
        }
    }

    func presentScene(){
        let scene = GameScene(size: CGSize(width: 320, height: 568))
        scene.gameViewController = self
        scene.scaleMode = .aspectFill
        //stage.presentScene(scene)
        stage.presentScene(scene, transition: .doorsOpenVertical(withDuration: 0.5))
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
