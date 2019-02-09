//
//  QRCodeScannerViewController.swift
//  CoffeeIOS
//
//  Created by Vladyslav Horbenko on 1/20/19.
//  Copyright © 2019 Vladyslav Horbenko. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeScannerViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var video = AVCaptureVideoPreviewLayer()
    private var scannedCoffeeMachine: String?
    @IBOutlet weak var myQRCodeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = AVCaptureSession()
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        } catch {
            print("Failed scan")
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr]
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        self.view.bringSubviewToFront(myQRCodeImageView)
        session.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        if metadataObjects.count > 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                print(object.stringValue ?? "dgfdg")
                let userDefault = UserDefaults.standard
                userDefault.set(object.stringValue, forKey: "qrCoffeMachine")
                print(userDefault.string(forKey: "qrCoffeMachine") ?? "")
                dismiss(animated: true, completion: nil)
            } else {
                ErrorAlert.printMessage(message: "Проблеми із скануванням", viewController: self)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receive = segue.destination as! CurrenUserViewController
        if let currentCoffemachine = self.scannedCoffeeMachine {
            receive.coffeeMachine = currentCoffemachine
        } else {
            print ("cant send user to CurrenUserViewController")
        }
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
}
