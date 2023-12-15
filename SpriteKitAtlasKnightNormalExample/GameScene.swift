//
//  GameScene.swift
//  SpriteKitAtlasKnightNormalExample
//
//  Created by Jihun Kang on 2023/12/15.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var knight: SKSpriteNode!
    var textures : [SKTexture] = [SKTexture]()
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx:0, dy:-2)
        let imageAtlas = SKTextureAtlas(named: "knight")
        for i in 1...imageAtlas.textureNames.count {
            let knightImage = "knight\(i)"
            textures.append(SKTexture(imageNamed: knightImage))
        }
        if textures.count>0 {
            knight = SKSpriteNode(texture:textures.first)
            knight.zPosition = 2
            addChild(knight)
            knight.position = CGPoint(x:self.frame.midX,y:self.frame.midY)
        }
        self.setPhysics()
        let animation = SKAction.animate(with: textures, timePerFrame: 0.15, resize: true, restore: false)
        let loop = SKAction.repeatForever(animation)
        knight.run(loop, withKey:"knight")
        
    }
    
    func setPhysics() {
        knight.physicsBody = SKPhysicsBody.init(rectangleOf: knight.size)
        knight.physicsBody?.isDynamic = false
    }
}
