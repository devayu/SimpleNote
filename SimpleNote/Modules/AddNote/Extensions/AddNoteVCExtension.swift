//
//  AddNoteVCExtension.swift
//  SimpleNote
//
//  Created by Mphrx on 30/11/21.
//

import Foundation
import UIKit
extension AddNoteViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate, UIDocumentPickerDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imgUrl = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerImageURL")] as? URL {
            self.selectedImgTxt.text = imgUrl.lastPathComponent
            self.selectedImgTxt.isHidden = false
            self.imgUrl = imgUrl
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let selectedFile = urls.first {
            self.selectedFileTxt.text = selectedFile.lastPathComponent
            self.selectedFileTxt.isHidden = false
            self.fileUrl = selectedFile
        }
        controller.dismiss(animated: true, completion: nil)
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
