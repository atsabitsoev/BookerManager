//
//  ScannerViewController.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 16.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import AVFoundation
import UIKit

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    private let discountsBackendService = DiscountsBackendService()
    private let discountsQrService = DiscountsQRService()
    private lazy var alertManager = AlertManager(vc: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сканер"
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }

        //dismiss(animated: true)
    }

    func found(code: String) {
        guard let discount = discountsQrService.getDiscount(from: code) else {
            self.alertManager.showAlert(title: "Ошибка", message: "Что-то пошло не так...", action: {
                self.navigationController?.popViewController(animated: true)
            })
            return
        }
        discountsBackendService.checkDiscountExists(discountId: discount.id, userId: discount.userId) { [weak self] (exists, errorString) in
            if exists {
                self?.showDiscountAlert(discount: discount)
            } else {
                self?.alertManager.showAlert(title: "Ошибка", message: errorString ?? "Неизвестная ошибка", action: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    
    private func showDiscountAlert(discount: Discount) {
        let alert = UIAlertController(title: discount.description, message: "Примените акцию сейчас, либо дайте посетителю возможность использовать ее еще раз нажав \"Отмена\"", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Применить", style: .default) { (_) in
            self.deleteDiscount(id: discount.id, userId: discount.userId)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (_) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func deleteDiscount(id: String, userId: String) {
        discountsBackendService.deleteDiscount(withId: id, userId: userId) { [weak self] (succeed, errorString) in
            if succeed {
                self?.alertManager.showAlert(title: "Ура!", message: "Скидка применена успешно") {
                    self?.navigationController?.popViewController(animated: true)
                }
            } else {
                self?.alertManager.showAlert(title: "Ошибка", message: errorString ?? "Что-то пошло не так...", action: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
