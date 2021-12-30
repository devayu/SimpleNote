//
//  FilesTabViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 29/12/21.
//

import UIKit
import PDFKit
class FilesTabViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pdfThumbnailImage: UIImageView!
    var note: SingleNote!
    var pdfViewer: PDFView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
        setPdf()
        setImage()
    }
    private func initVC() {
        if note.noteImgUrl == nil {
            imageView.isHidden = true
        }
        if note.noteFileUrl == nil {
            pdfThumbnailImage.isHidden = true
        }
    }
    private func setPdf() {
        guard let fileUrl = note.noteFileUrl else { return }
        let spinner = UIActivityIndicatorView()
        spinner.center = self.pdfThumbnailImage.center
        pdfThumbnailImage.addSubview(spinner)
        pdfThumbnailImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewPdfInFullScreen)))
        FirebaseCRUD.shared.downloadFiles(for: note.noteId, fileName: fileUrl) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                DispatchQueue.main.async {
                    let pdfDocument = PDFDocument(data: data)
                    self.pdfViewer = PDFView(frame: self.pdfThumbnailImage.bounds)
                    self.pdfViewer.document = pdfDocument
                    let pdfThumbnail = self.generatePdfThumbnail(data: data, width: 200)
                    self.pdfThumbnailImage.image = pdfThumbnail
                    self.pdfThumbnailImage.contentMode = .scaleAspectFill
                    self.pdfThumbnailImage.isUserInteractionEnabled = true
                    spinner.stopAnimating()
                }
            }
        }
    }
    private func setImage() {
        guard let imgUrl = note.noteImgUrl else { return }
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        spinner.center = self.imageView.center
        imageView.addSubview(spinner)
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewImgInFullScreen)))
        FirebaseCRUD.shared.downloadFiles(for: note.noteId, fileName: imgUrl) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let imgData):
                let image = UIImage(data: imgData)
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.imageView.clipsToBounds = true
                    self.imageView.contentMode = .scaleAspectFill
                    self.imageView.isUserInteractionEnabled = true
                    spinner.stopAnimating()
                }
            }
        }
    }
    private func generatePdfThumbnail(data: Data, width: CGFloat) -> UIImage? {
        guard let page = PDFDocument(data: data)?.page(at: 0) else {
            return nil
        }
        let pageSize = page.bounds(for: .mediaBox)
        let pdfScale = width / pageSize.width
        let scale = UIScreen.main.scale * pdfScale
        let screenSize = CGSize(width: pageSize.width * scale,
                                height: pageSize.height * scale)
        return page.thumbnail(of: screenSize, for: .mediaBox)
    }
    @objc private func viewPdfInFullScreen() {
            let pdfVC = UIViewController()
            self.pdfViewer.frame = pdfVC.view.bounds
            self.pdfViewer.autoScales = true
            pdfVC.view.addSubview(self.pdfViewer)
            self.navigationController?.pushViewController(pdfVC, animated: true)
    }
    @objc private func viewImgInFullScreen() {
        let imgVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageVC") as? ImageViewController
        guard let imageVC = imgVC else { return }
        imageVC.image = self.imageView.image
    self.navigationController?.pushViewController(imageVC, animated: true)
    }
}
