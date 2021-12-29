//
//  AddNoteVCExtension.swift
//  SimpleNote
//
//  Created by Mphrx on 30/11/21.
//

import Foundation
import UIKit
extension AddNoteViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate, UIDocumentPickerDelegate, UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let imgUrl = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerImageURL")] as? URL {
            self.selectedImgTxt.text = imgUrl.lastPathComponent
            self.selectedImgTxt.isHidden = false
            self.addNoteVM.imgUrl = imgUrl
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func initSwipeRightGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    @objc private func handleSwipeRight() {
        checkForUnsavedChanges()
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let selectedFile = urls.first {
            self.selectedFileTxt.text = selectedFile.lastPathComponent
            self.selectedFileTxt.isHidden = false
            self.addNoteVM.fileUrl = selectedFile
        }
        controller.dismiss(animated: true, completion: nil)
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
