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
    // MARK: - Properties
    var counter: Int = 0 {
        didSet {
            scoreLabel.text = "\(counter)"
        }
    }
    
    // MARK: - Subviews
    let sceneView = ARSCNView()
    
    let scoreLabel:UILabel = {
       let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.text = "0"
        return label
    }()
    
    
    // MARK: Subview Constraints
    /// Sets the constraints for subviews
    public func setSubviewConstraints() {
        view.addSubview(sceneView)
        view.addSubview(scoreLabel)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // scoreLabel Constraints
            scoreLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scoreLabel.heightAnchor.constraint(equalToConstant: 70),
            
            // sceneView Constraints
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneView.bottomAnchor.constraint(equalTo: scoreLabel.topAnchor)
        ])
    }
    
    // MARK: - Methods
    func addObject() {
        let myPlane = Plane()
        myPlane.loadModel()
        
        let xPos = randomPosition(lowerBound: -100, upperBound: 100)
        let yPos = randomPosition(lowerBound: -100, upperBound: 100)
        
        myPlane.position = SCNVector3(xPos, yPos, -1)
        
        sceneView.scene.rootNode.addChildNode(myPlane)
        print("Added \(myPlane) to the scene")
    }
    
    func randomPosition(lowerBound lower: Float, upperBound upper: Float) -> Float{
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
    }
    
    // MARK: - Configure Scene
    /// Configures the SceneView
    private func configureScene() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    /// Sets the scene for viewDidLoad
    private func setScene() {
        let scene = SCNScene()
        sceneView.scene = scene
    }
    /// https://stackoverflow.com/questions/46171799/how-to-detect-which-one-object-i-touched-in-sceneview-at-arkitexample
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if(touch.view == self.sceneView) {
            
            let touchLocation: CGPoint = touch.location(in: sceneView)
            
            let result = sceneView.hitTest(touchLocation, options: nil)
            guard let touchedNode = result.first?.node else { return }
            
            // TouchedNode involves the parts of the plane. First parent is biplane_assembled. Second parent is biplane.
            
            if(touchedNode.parent?.parent?.name == "biplane") {
                sceneView.scene.rootNode.childNodes.first?.removeFromParentNode()
                counter += 1
                addObject()
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Call constaint methods
        setSubviewConstraints()
        
        // Configure the Scene View
        setScene()
        
        // Add the plane
        addObject()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureScene()
    }


}

