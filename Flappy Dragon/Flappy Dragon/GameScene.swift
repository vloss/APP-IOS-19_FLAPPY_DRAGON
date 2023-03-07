//
//  GameScene.swift
//  Flappy Dragon
//
//  Created by Vinicius Loss on 04/03/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var floor: SKSpriteNode!
    var intro: SKSpriteNode!
    var player: SKSpriteNode!
    var gameArea:  CGFloat = 410.0
    var velocity: Double = 100.0
    var gameFinished = false
    var gameStarted = false
    var restart = false
    var scoreLabel: SKLabelNode!
    var score: Int = 0
    var flyForce: CGFloat = 30.0
    
    // Quando a scene foi movida para a View - EM exibição na tela
    override func didMove(to view: SKView) {
        addBackground()
        addFloor()
        addIntro()
        addPlayer()
        moveFloor()
    }
    
    func addBackground(){
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height/2)
        background.zPosition = 0
        addChild(background)
    }
    
    func addFloor(){
        floor = SKSpriteNode(imageNamed: "floor")
        floor.zPosition = 2
        floor.position = CGPoint(x: floor.size.width / 2, y: size.height - gameArea - floor.size.height/2)
        addChild(floor)
        
        let invisibleFloor = SKNode()
        invisibleFloor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: 1))
        invisibleFloor.physicsBody?.isDynamic = false
        invisibleFloor.position = CGPoint(x: size.width / 2, y: size.height - gameArea)
        invisibleFloor.zPosition = 2
        addChild(invisibleFloor)
        
        let invisibleRoof = SKNode()
        invisibleRoof.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: 1))
        invisibleRoof.physicsBody?.isDynamic = false
        invisibleRoof.position = CGPoint(x: size.width / 2, y: size.height)
        invisibleRoof.zPosition = 2
        addChild(invisibleRoof)
    }
    
    func addIntro(){

        intro = SKSpriteNode(imageNamed: "intro")
        intro.zPosition = 3
        intro.position = CGPoint(x: size.width / 2, y: size.height - 210)
        addChild(intro)
    }
    
    func addPlayer(){

        player = SKSpriteNode(imageNamed: "player1")
        player.zPosition = 4
        player.position = CGPoint(x: 80, y: size.height - gameArea / 2)

        var playerTextures = [SKTexture]()
        for i in 1...4 {
            playerTextures.append(SKTexture(imageNamed: "player\(i)"))
        }

        let animationAction = SKAction.animate(with: playerTextures, timePerFrame: 0.09)
        let repeatAction = SKAction.repeatForever(animationAction)

        player.run(repeatAction)

        addChild(player)
    }
    
    func moveFloor(){
        let duration = Double(floor.size.width/2)/velocity
        let moveFloorAction = SKAction.moveBy(x: -floor.size.width/2, y: 0, duration: duration)
        let resetXAction = SKAction.moveBy(x: floor.size.width/2, y: 0, duration: 0)
        let sequenceAction = SKAction.sequence([moveFloorAction, resetXAction])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        floor.run(repeatAction)
    }
    
    func spawnEnemies(){
        let initialPosition = CFloat(arc4random_uniform(132) + 74)
        let enemyNumber     = Int(arc4random_uniform(4) + 1)
        let enemysDistance  = self.player.size.height * 2.5

        let enemyTop = SKSpriteNode(imageNamed: "enemytop\(enemyNumber)")
        let enemyWidth = enemyTop.size.width
        let enemyHeight = enemyTop.size.height
        
        enemyTop.position = CGPoint(x: size.width + enemyWidth / 2, y: size.height - CGFloat(initialPosition) + enemyHeight/2)
        enemyTop.zPosition = 1
        enemyTop.physicsBody = SKPhysicsBody(rectangleOf: enemyTop.size)
        enemyTop.physicsBody?.isDynamic = false
        
        let enemyBottom = SKSpriteNode(imageNamed: "enemybottom\(enemyNumber)")
        enemyBottom.position = CGPoint(x: size.width + enemyWidth / 2, y: enemyTop.position.y - enemyTop.size.height - enemysDistance)
        enemyBottom.zPosition = 1
        enemyBottom.physicsBody = SKPhysicsBody(rectangleOf: enemyTop.size)
        enemyBottom.physicsBody?.isDynamic = false
        
        let distance = size.width + enemyWidth
        let duration = Double(distance)/velocity
        
        let moveAction = SKAction.moveBy(x: -distance, y: 0, duration: duration)
        let removeAction = SKAction.removeFromParent()
        let sequenceAction = SKAction.sequence([moveAction, removeAction])
        
        enemyTop.run(sequenceAction)
        enemyBottom.run(sequenceAction)
        
        addChild(enemyTop)
        addChild(enemyBottom)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameFinished {
            if !gameStarted{
                intro.removeFromParent() // remove o nó
                addScore()
                
                player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2 - 10)
                player.physicsBody?.isDynamic = true
                player.physicsBody?.allowsRotation = true
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: flyForce))
                
                gameStarted = true
                
                Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { (timer) in
                    self.spawnEnemies()
                }
                
            } else {
                player.physicsBody?.velocity =  CGVector.zero
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: flyForce))
            }
        }
    }

    func addScore(){
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.fontSize = 94
        scoreLabel.text = "\(score)"
        scoreLabel.zPosition = 5
        scoreLabel.alpha = 0.8
        scoreLabel.position = CGPoint(x: size.width/2, y: size.height - 100)
        addChild(scoreLabel)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameStarted {
            let yVelocity    = player.physicsBody!.velocity.dy * 0.001 as CGFloat
            player.zRotation = yVelocity
        }
    }
}
