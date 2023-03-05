//
//  GameViewController.swift
//  Flappy Dragon
//
//  Created by Vinicius Loss on 04/03/23.
//

import UIKit
import SpriteKit
import GameplayKit

var stage: SKView!

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stage = view as! SKView
        stage.ignoresSiblingOrder = true // Para fazer manualmente o posicionamento de elementos no eixo Z
        
        presentScene()
    }

    func presentScene(){
        let scene = GameScene(size: CGSize(width: 320, height: 568))
        scene.scaleMode = .aspectFill
        stage.presentScene(scene)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
