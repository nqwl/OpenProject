//
//  AVCaptrueManager.swift
//  03-视频采集
//
//  Created by 亲点 on 2018/4/13.
//  Copyright © 2018年 xmg. All rights reserved.
//

import UIKit
import AVFoundation

class AVCaptrueManager: NSObject {
    fileprivate lazy var session : AVCaptureSession = AVCaptureSession()
    fileprivate var videoOutput : AVCaptureVideoDataOutput?
    fileprivate var previewLayer : AVCaptureVideoPreviewLayer?
    fileprivate var videoInput : AVCaptureDeviceInput?
    fileprivate var movieOutput : AVCaptureMovieFileOutput?
    fileprivate var preview : UIView?

    
}
extension AVCaptrueManager {

    func setupVideoInputOutput() {
        // 1.添加视频的输入
        guard let devices = AVCaptureDevice.devices() as? [AVCaptureDevice] else { return }
        guard let device = devices.filter({ $0.position == .front }).first else { return }
        guard let input = try? AVCaptureDeviceInput(device: device) else { return }
        self.videoInput = input

        // 2.添加视频的输出
        let output = AVCaptureVideoDataOutput()
        let queue = DispatchQueue.global()
        output.setSampleBufferDelegate(self, queue: queue)
        self.videoOutput = output

        // 3.添加输入&输出
        addInputOutputToSesssion(input, output)
    }

    func setupAudioInputOutput() {
        // 1.创建输入
        guard let device = AVCaptureDevice.default(for: .audio) else {
            return
        }

//        guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio) else { return }
        guard let input = try? AVCaptureDeviceInput(device: device) else { return }

        // 2.创建输出
        let output = AVCaptureAudioDataOutput()
        let queue = DispatchQueue.global()
        output.setSampleBufferDelegate(self, queue: queue)

        // 3.添加输入&输出
        addInputOutputToSesssion(input, output)
    }


    func rotateCamera() {
        // 1.取出之前镜头的方向
        DispatchQueue.global().async {
            guard let videoInput = self.videoInput else {
                return
            }
            let postion : AVCaptureDevice.Position = videoInput.device.position == .front ? .back : .front
            let devices = AVCaptureDevice.devices() as? [AVCaptureDevice]
            guard let device = devices?.filter({ $0.position == postion }).first else { return }
            guard let newInput = try? AVCaptureDeviceInput(device: device) else { return }


            // 2.移除之前的input, 添加新的input
            self.session.beginConfiguration()
            self.session.removeInput(videoInput)
            if self.session.canAddInput(newInput) {
                self.session.addInput(newInput)
            }
            self.session.commitConfiguration()

            // 3.保存最新的input
            self.videoInput = newInput
        }
    }
    func startCapturing(preview:UIView) {
        DispatchQueue.global().async {
        self.preview = preview
            self.session.startRunning()
            DispatchQueue.main.async {
                self.setupPreviewLayer()
            }
        // 录制视频, 并且写入文件
            self.setupMovieFileOutput()
        }
    }
    func stopCapturing() {
        DispatchQueue.global().async {
            self.movieOutput?.stopRecording()
            self.session.stopRunning()
            DispatchQueue.main.async {
                self.previewLayer?.removeFromSuperlayer()
            }
        }
    }


    

    private func addInputOutputToSesssion(_ input : AVCaptureInput, _ output : AVCaptureOutput) {
        session.beginConfiguration()
        if session.canAddInput(input) {
            session.addInput(input)
        }
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        session.commitConfiguration()
    }

    fileprivate func setupPreviewLayer() {
        // 1.创建预览图层
//        guard let previewLayer = AVCaptureVideoPreviewLayer(session: session) else { return }
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        // 2.设置previewLayer属性

        previewLayer.frame = self.preview!.bounds

        // 3.将图层添加到控制器的View的layer中
        self.preview!.layer.insertSublayer(previewLayer, at: 0)
        self.previewLayer = previewLayer
    }

    fileprivate func setupMovieFileOutput() {

        if self.movieOutput != nil {
            session.removeOutput(self.movieOutput!)
        }
        // 1.创建写入文件的输出
        let fileOutput = AVCaptureMovieFileOutput()
        self.movieOutput = fileOutput

        let connection = fileOutput.connection(with: .video)
//        let connection = fileOutput.connection(withMediaType: AVMediaTypeVideo)

        connection?.automaticallyAdjustsVideoMirroring = true

        if session.canAddOutput(fileOutput) {
            session.addOutput(fileOutput)
        }

        // 2.直接开始写入文件
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/abc.mp4"
        let fileURL = URL(fileURLWithPath: filePath)
//        fileOutput.startRecording(toOutputFileURL: fileURL, recordingDelegate: self)
        fileOutput.startRecording(to: fileURL, recordingDelegate: self)

    }
}
extension AVCaptrueManager : AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
//        if videoOutput?.connection(withMediaType: AVMediaTypeVideo) == connection {
        if videoOutput?.connection(with: .video) == connection {
            print("采集视频数据")
        } else {
            print("采集音频数据")
        }
    }
}


// MARK:- 通过代理监听开始写入文件, 以及结束写入文件
extension AVCaptrueManager : AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {

    }

    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        print("开始写入文件")
    }

    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        print("完成写入文件")
    }
}
