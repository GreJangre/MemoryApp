//
//  MemoFormVC.swift
//  MemoryApp
//
//  Created by 임성주 on 20/02/2019.
//  Copyright © 2019 jangre. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var subject: String?
    
    // MARK: IBOutlet
    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    
    // MARK: IBAction
    @IBAction func save(_ sender: Any) {
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해 주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            return
        }
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker, animated: false)
    }
    
    // MARK: Function
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        picker.dismiss(animated: false)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        self.navigationItem.title = subject
    }
    
    // MARK: Override
    override func viewDidLoad() {
        self.contents.delegate = self
        
        let bgImage = UIImage(named: "memo-background.png")!
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        
        self.contents.layer.borderWidth = 0
        self.contents.layer.borderColor = UIColor.clear.cgColor
        self.contents.backgroundColor = UIColor.clear
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        self.contents.attributedText = NSAttributedString(string: " ",
                                                          attributes: [NSAttributedString.Key.paragraphStyle: style])
        self.contents.text = ""
    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let bar = self.navigationController?.navigationBar
//        
//        let ts = TimeInterval(0.3)
//        UIView.animate(withDuration: ts) {
//            bar?.alpha = (bar?.alpha == 0 ? 1 : 0)
//        }
//    }
}
