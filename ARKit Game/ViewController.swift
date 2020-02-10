//
//  ViewController.swift
//  ARKit Game
//
//  Created by Nikhil Menon on 2/10/20.
//  Copyright © 2020 Nikhil Menon. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    // MARK: - Subviews
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        sceneView.scene = scene
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        
        sceneView.session.run(configuration)
        
        
        
        
    }


}

