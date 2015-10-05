import Foundation
import SpriteKit

typealias EnemyHitHandler = ((SKNode,SKNode) -> Void)

class CollisionDetector : NSObject, SKPhysicsContactDelegate {
    
    var enemyHitHandler : EnemyHitHandler?
    
    init(g:EnemyHitHandler) {
        enemyHitHandler = g
    }
    
    func didBeginContact(contact:SKPhysicsContact){
        if (contact.bodyA.node != nil && contact.bodyB.node != nil)  {
            let node2:SKNode = contact.bodyB.node!
            let node1:SKNode = contact.bodyA.node!
            let name1 = node1.name;
            let name2 = node2.name;
            if ( name1 == "hero" && name2 == "balloon")
            {
                enemyHitHandler?(node2,node1)
            }
            else if ( name2 == "balloon" && name1 == "hero")
            {
                enemyHitHandler?(node2,node1)
            }            
        }
    }
    
}