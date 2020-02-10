//
//  Plane.swift
//  ARKit Game
//
//  Created by Nikhil Menon on 2/10/20.
//  Copyright © 2020 Nikhil Menon. All rights reserved.
//

import ARKit

class Plane: SCNNode {
    func loadModel() {
        guard let virtualObjectScene = SCNScene(named: "toy_biplane.usdz") else { return }
        
        let wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }
        self.addChildNode(wrapperNode)
    }
    
}
