//
//  BallonSpawner.swift
//  GravityBall
//
//  Created by Lars Bergqvist on 2015-10-02.
//  Copyright © 2015 Lars Bergqvist. All rights reserved.
//

import Foundation
import SpriteKit

class BalloonSpawner {

    var parentNode:SKNode?
    
    init(parent:SKNode) {
        parentNode = parent
    }
    
    let images = ["balloon2"]

    func spawn() {
        
        let imgIdx = Int(arc4random_uniform(UInt32(images.count)))
        let imageName = images[imgIdx]
        
        let spTexture = SKTexture(imageNamed:imageName)
        let sp = SKSpriteNode(texture: spTexture)
        
        
        sp.xScale = 0.5
        sp.yScale = 0.5
        sp.name = "balloon"
        
        
        sp.physicsBody = SKPhysicsBody( texture: spTexture, size: sp.size)
        sp.physicsBody!.friction = 0.5//objectPhysics!.friction
        sp.physicsBody!.restitution = 0.8
        sp.physicsBody!.mass = 5
        sp.physicsBody!.allowsRotation = true
        sp.physicsBody!.dynamic = true
        sp.physicsBody?.categoryBitMask = 2
        sp.physicsBody?.collisionBitMask = 1
        sp.physicsBody?.contactTestBitMask = 1
        sp.physicsBody?.fieldBitMask = 128


        parentNode?.addChild(sp)
        
        let w = sp.size.width
        let diceX = arc4random_uniform(UInt32(sp.parent!.frame.size.width-2*w))+UInt32(w)
        let yPos = 100
        
        let startPos = CGPointMake(CGFloat(diceX),CGFloat(yPos))
        sp.position = startPos
        
        sp.physicsBody?.applyImpulse(CGVectorMake(0, 100))


    }
}