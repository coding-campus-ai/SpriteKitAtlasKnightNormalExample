//
//  GameScene.swift
//  SpriteKitAtlasKnightNormalExample
//
//  Created by Jihun Kang on 2023/12/15.
//

import SpriteKit
import GameplayKit

class GameScene2: SKScene {
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
        let animation = SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.15, resize: true, restore: false))
       knight.run(animation,withKey:"knight")

    }
    
    func setPhysics() {
        knight.physicsBody = SKPhysicsBody.init(rectangleOf: knight.size)
        knight.physicsBody?.isDynamic = false
    }
}

extension SKAction
{
    static func animate(withPhysicsTextures textures:[(texture:SKTexture,body:SKPhysicsBody)], timePerFrame:TimeInterval ,resize:Bool, restore:Bool) ->SKAction {

        var originalTexture : SKTexture!;
        let duration = timePerFrame * Double(textures.count);

        return SKAction.customAction(withDuration: duration)
        {
            node,elapsedTime in
            guard let sprNode = node as? SKSpriteNode
            else
            {
                    assert(false,"animatePhysicsWithTextures only works on members of SKSpriteNode");
                    return;
            }
            let index = Int((elapsedTime / CGFloat(duration)) * CGFloat(textures.count))
            //If we havent assigned this yet, lets assign it now
            if originalTexture == nil
            {
                originalTexture = sprNode.texture;
            }


            if(index < textures.count)
            {
                sprNode.texture = textures[index].texture
                sprNode.physicsBody = textures[index].body
            }
            else if(restore)
            {
                sprNode.texture = originalTexture;
            }

            if(resize)
            {
                sprNode.size = sprNode.texture!.size();
            }

        }
    }
}
