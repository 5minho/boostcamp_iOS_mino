//
//  ViewController.swift
//  RestoreViewController
//
//  Created by 오민호 on 2017. 7. 28..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    lazy var imageURLForKey = {
        (key: String) -> URL? in
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDiretory = documentDirectories.first else {return nil}
        return documentDiretory.appendingPathComponent(key)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func encodeRestorableState(with coder: NSCoder) {
        coder.encode(titleField.text, forKey : "titleField")
        coder.encode(imageView.image, forKey: "image")
        coder.encode(textView.text, forKey : "textView")
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        if let title = coder.decodeObject(forKey: "titleField"),
            let text = coder.decodeObject(forKey: "textView")
            /*let image = coder.decodeObject(forKey: "image")*/ {
            titleField.text = title as? String
           // imageView.image = image as? UIImage
            textView.text = text as? String
        }
        super.decodeRestorableState(with: coder)
    }
}


