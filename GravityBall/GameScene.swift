//
//  GameScene.swift
//  GravityBall
//
//  Created by Lars Bergqvist on 2015-10-02.
//  Copyright (c) 2015 Lars Bergqvist. All rights reserved.
//

import SpriteKit
import CoreMotion



class GameScene: SKScene {
    var balloonSpawner:BalloonSpawner?
    var collisionDetector:CollisionDetector?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.physicsWorld.gravity = gravVector
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame)
        self.physicsBody = physicsBody
        self.name = "edge"
        collisionDetector = CollisionDetector(g:enemyHit)
        self.physicsWorld.contactDelegate = collisionDetector

        let ballSprite = Ball.createBall()
        ballSprite.position = CGPoint(x: 200, y: 200)
        self.addChild(ballSprite)
        
        balloonSpawner = BalloonSpawner(parent: self)
        balloonSpawner?.spawn()

        motionManager.startAccelerometerUpdates()
    }
    
    let explosion = ExplosionAtlas()
    
    func enemyHit(enemyNode:SKNode,heroNode:SKNode) {
        enemyNode.physicsBody?.dynamic = false
        enemyNode.physicsBody?.categoryBitMask = 0
        enemyNode.name = ""
        enemyNode.physicsBody?.fieldBitMask = 0
        
        let expl = SKAction.animateWithTextures(explosion.expl_01_(), timePerFrame: 0.05)
        let enemySprite = enemyNode as! SKSpriteNode
        enemySprite.runAction(expl, completion: { () -> Void in
            enemyNode.removeFromParent()
            
        })

    }
    
    func addBall() {
    }
    

    var gravVector:CGVector = CGVectorMake(0,-9.8)
    let motionManager: CMMotionManager = CMMotionManager()

    let gravFactor:CGFloat = 30.0
    func processUserMotionForUpdate(currentTime: CFTimeInterval) {
        if let data = motionManager.accelerometerData {
            
            let x = CGFloat(data.acceleration.x)*gravFactor
            let y = CGFloat(data.acceleration.y)*gravFactor
            
            gravVector = CGVectorMake(x,y)
        }
    }
    
    func spawnNewIfEmpty() {
        var balloonExists = false
        self.enumerateChildNodesWithName("*") {
            node,stop in
            if let name = node.name {
                if (name == "balloon") {
                    balloonExists = true
                }
            }
        }
        
        if (!balloonExists) {
            balloonSpawner?.spawn()
        }

    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        processUserMotionForUpdate(currentTime)
        
        self.physicsWorld.gravity = gravVector
        
        spawnNewIfEmpty()
    }
}
