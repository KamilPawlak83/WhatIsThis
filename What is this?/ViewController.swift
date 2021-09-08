//
//  ViewController.swift
//  What is this?
//
//  Created by Kamil Pawlak on 07/09/2021.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var answerNameLabel: UILabel!
    var answerPercentLabel: UILabel!
    
    var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    let imagePicker2 = UIImagePickerController()
    
    override func loadView() {
        view = UIView()
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        
        answerNameLabel = UILabel()
        answerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        answerNameLabel.font = UIFont.systemFont(ofSize: 24)
        answerNameLabel.textAlignment = .center
        answerNameLabel.text = "Name"
        answerNameLabel.backgroundColor = UIColor.systemPurple
        answerNameLabel.layer.masksToBounds = true
        answerNameLabel.layer.cornerRadius = 8
        answerNameLabel.layer.borderWidth = 1
        answerNameLabel.layer.borderColor = UIColor.black.cgColor
        
        answerNameLabel.isHidden = true
        view.addSubview(answerNameLabel)
        
        
        answerPercentLabel = UILabel()
        answerPercentLabel.translatesAutoresizingMaskIntoConstraints = false
        answerPercentLabel.font = UIFont.systemFont(ofSize: 24)
        answerPercentLabel.textAlignment = .center
        answerPercentLabel.text = "Percent"
        answerPercentLabel.backgroundColor = UIColor.systemPurple
        answerPercentLabel.layer.masksToBounds = true
        answerPercentLabel.layer.cornerRadius = 8
        answerPercentLabel.layer.borderWidth = 1
        answerPercentLabel.layer.borderColor = UIColor.black.cgColor
        
        answerPercentLabel.isHidden = true
        view.addSubview(answerPercentLabel)
        
       
        NSLayoutConstraint.activate([
            
            answerNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            answerNameLabel.bottomAnchor.constraint(equalTo: answerPercentLabel.topAnchor, constant: -20),
            answerNameLabel.heightAnchor.constraint(equalToConstant: 30),
           
            answerPercentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerPercentLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            answerPercentLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            answerPercentLabel.heightAnchor.constraint(equalToConstant: 30),
            
            imageView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        
        imagePicker.sourceType = .camera // we can use photo library: .photoLibrary or camera: .camera
        imagePicker.allowsEditing = false // do sprawdzenia pozniej
        
//        WynikSlowny.isHidden = true
//        Procenty.isHidden = true
        
        present(imagePicker, animated: true, completion: updateBar)
        
        imagePicker2.delegate = self
        imagePicker2.sourceType = .photoLibrary
        imagePicker2.allowsEditing = false
        
      
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = userPickedImage
     
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("CIImage error")
            }
        
            detect(image: ciimage)
        
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        imagePicker2.dismiss(animated: true, completion: nil)
        
        updateBar()
        
    }
    
    
    func detect(image: CIImage) {
        
        let config = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: Resnet50(configuration: config).model) else {
            fatalError("Couldn't create Resnet50 Model")
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Image request error")
        }
            
        print(results)
        
            if let firstResult = results.first {
                self.navigationItem.title = firstResult.identifier
            
            print(firstResult.identifier)
            print(firstResult.confidence)
//                self.firstResultKP = firstResult.identifier
                self.answerNameLabel.text = firstResult.identifier
                
                let firstAnswerInPercentMyltiplyBy100 = 100 * firstResult.confidence
                let firstAnswerInPercentMultiplyBy100String = String(format: "%.2f", firstAnswerInPercentMyltiplyBy100)
                self.answerPercentLabel.text = "Wynik: \(firstAnswerInPercentMultiplyBy100String)%"
               
                self.answerNameLabel.isHidden = false
                self.answerPercentLabel.isHidden = false
           
            }
        }
        
    let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    

   
    @objc func cameraPressed() {
        navigationController?.isToolbarHidden = true
        present(imagePicker, animated: true, completion: updateBar)
    }
    
   
    @objc func addFromPhotoLibrary() {
        navigationController?.isToolbarHidden = true
        present(imagePicker2, animated: true, completion: updateBar)
        
    }
    
    @objc func shareTapped() {
    
        let image = screenShot()
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(vc, animated: true)
        
    }
    
    func screenShot() -> UIImage
        {
            let layer = self.view.layer
            let scale = UIScreen.main.scale
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);

            layer.render(in: UIGraphicsGetCurrentContext()!)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return screenshot!
        }

    
    
    func updateBar() {
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraPressed))
        
        let photoLibraryButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFromPhotoLibrary))
      
        toolbarItems = [photoLibraryButton, spacer, cameraButton, spacer,shareButton]
        navigationController?.isToolbarHidden = false
//        text1.isEnabled = false
        
    }
    
    
    

}





