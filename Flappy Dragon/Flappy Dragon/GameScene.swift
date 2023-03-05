//
//  GameScene.swift
//  Flappy Dragon
//
//  Created by Vinicius Loss on 04/03/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    // Quando a scene foi movida para a View - EM exibição na tela
    override func didMove(to view: SKView) {
        addBackground()
    }
    
    func addBackground(){
        guard let background = SKSpriteNode(fileNamed: "background") else { return }
        addChild(background)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
