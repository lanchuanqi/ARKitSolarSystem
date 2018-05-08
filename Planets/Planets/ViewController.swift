//
//  ViewController.swift
//  Planets
//
//  Created by logan on 2018/5/5.
//  Copyright © 2018 Chuanqi. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        //self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.showsStatistics = true
        self.sceneView.session.run(configuration)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "SunDiffuse")
        sun.position = SCNVector3(0, 0, -2)
        self.sceneView.scene.rootNode.addChildNode(sun)
        
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth"), specular: #imageLiteral(resourceName: "EarthSpecular"), emission: #imageLiteral(resourceName: "EarthClouds"), normal: #imageLiteral(resourceName: "EarthNormal"), position: SCNVector3(1.2, 0, 0))
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "VenusSurface"), specular: nil, emission: #imageLiteral(resourceName: "VenusAtmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
        let earthMoon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
        

        sun.runAction(rotation(time: 8))
        
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let moonParent = SCNNode()
        earthParent.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        moonParent.position = SCNVector3(1.2,0,0)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        earthParent.addChildNode(earth)
        venusParent.addChildNode(venus)
        earthParent.addChildNode(moonParent)
        moonParent.addChildNode(earthMoon)
        
        earthParent.runAction(rotation(time: 14))
        venusParent.runAction(rotation(time: 10))
        moonParent.runAction(rotation(time: 5))
        earth.runAction(rotation(time: 8))
        venus.runAction(rotation(time: 8))
        
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode{
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
    
    func rotation(time: TimeInterval) -> SCNAction{
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreeToRadians), z: 0, duration: time)
        let foreverRotion = SCNAction.repeatForever(rotation)
        return foreverRotion
    }

}
extension Int{
    var degreeToRadians: Double {return Double(self) * .pi / 180}
}

