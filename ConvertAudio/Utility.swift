//
//  Utility.swift
//  SongProcessor
//
//  Created by Degree on 12/6/16.
//  Copyright © 2016 AudioKit. All rights reserved.
//

import Foundation
import UIKit


class Utility: NSObject {
    
    //MARK: - File manager

    class func createDir(dirName: String) {
        
        print("creat folder:",dirName)
        
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dataPath = documentsDirectory.appendingPathComponent(dirName)
        
        let fileManager = FileManager.default
        var isDir : ObjCBool = false
        if fileManager.fileExists(atPath: dataPath.path, isDirectory:&isDir) {
            if isDir.boolValue {
                // file exists and is a directory
                print("file exist")
            } else {
                // file exists and is not a directory
                print("folder exist")
            }
        } else {
            // folder does not exist
            do {
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print("Error creating directory: \(error.localizedDescription)")
            }
        }
        
        
        
    }
    
    class func deleteFile(fileName:String){
        
        let filePath = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        print("delete", filePath)
        
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: filePath.path)
        } catch {
            print("Failed to delete file.", error.localizedDescription)
        }
        
    }
    
    
    class func checkFileExist(fileName:String)->(Bool){
        
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.appendingPathComponent(fileName)?.path
        
//        print(filePath!);
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath!) {
//            print("File availble <--", fileName)
            return true;
        } else {
//            print("File not availble <--", fileName)
            return false;
        }
        
    }

    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func getFileExtension(file:String)->String{
        
        if let fileExtension = NSURL(fileURLWithPath: file).pathExtension {
            print("fileExtension: ",fileExtension)
            return fileExtension
        }
        
        return ""
        
    }
    
    //MARK: - Other
    
    class var currentTimestamp: String {
        return "\(Int(Date().timeIntervalSince1970))"
    }
    
    
    class func generateImageWithColor(_ color: UIColor, width:CGFloat, height:CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        //        context?.fill(rect)
        context?.fillEllipse(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
}

//MARK: Quick register nib

extension UITableView{
    
    func registerNib(_ nibClass:AnyClass, _ identifier:String){
        
        let nib = UINib(nibName: String(describing: nibClass.self), bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
        
    }
    
}

extension UICollectionView{
    
    func registerNib(_ nibClass:AnyClass, _ identifier:String){
        
        let nib = UINib(nibName: String(describing: nibClass.self), bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
        
    }
    
}

//MARK: Image from color

extension UIColor {
    
    convenience init(_  red: Int,_  green: Int,_ blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
    
    convenience init(_ red: Int,_ green: Int,_ blue: Int,_ alpha: CGFloat) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
    }
    
}

extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

extension UIView{
    
    func addGradient(){
        // add gradient transparent to top and bot of view
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.frame.size
        gradientLayer.colors = [UIColor(white: 0, alpha: 0).cgColor,
                                UIColor(white: 1, alpha: 1).cgColor,
                                UIColor(white: 1, alpha: 1).cgColor,
                                UIColor(white: 0, alpha: 0).cgColor];
        gradientLayer.locations = [0, 0.2, 0.8, 1];
        self.layer.mask = gradientLayer;
        
    }
    
    func addGradient(from:UIColor, to:UIColor){
        // add gradient transparent to top and bot of view
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.frame.size
        gradientLayer.colors = [from.cgColor,
                                to.cgColor];
        gradientLayer.locations = [0, 1];
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}

