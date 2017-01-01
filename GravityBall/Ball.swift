//
//  Ball.swift
//  GravityBall
//
//  Created by Lars Bergqvist on 2015-10-05.
//  Copyright © 2015 Lars Bergqvist. All rights reserved.
//

import Foundation
import SpriteKit

class Ball {
    class func createBall() -> SKSpriteNode {
        let texture = SKTexture(imageNamed: "kball")
        let sprite = SKSpriteNode(texture: texture)
        
        sprite.name = "hero"
        
        sprite.xScale = 1
        sprite.yScale = 1
        sprite.physicsBody = SKPhysicsBody( texture: texture, size: sprite.size)
        sprite.physicsBody!.friction = 2
        sprite.physicsBody!.restitution = 0.4
        sprite.physicsBody!.mass = 3
        sprite.physicsBody!.allowsRotation = true
        sprite.physicsBody!.isDynamic = true
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.collisionBitMask = 2
        sprite.physicsBody?.contactTestBitMask = 2
        sprite.physicsBody?.fieldBitMask = 1
        
        return sprite
    }
}
