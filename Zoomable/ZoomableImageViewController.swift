//
//  ZoomableImageViewController.swift
//  Zoomable
//
//  Created by lilit on 20.06.25.


import UIKit

class ZoomableImageViewController: UIViewController, UIScrollViewDelegate {

    let scrollView = UIScrollView()
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupScrollView()
        setupImageView()
    }

    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.bounces = true
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupImageView() {
        guard let image = UIImage(named: "bird") ?? UIImage(systemName: "photo") else { return }
        imageView.image = image
        imageView.contentMode = .scaleAspectFit

        let maxSize = CGSize(
            width: scrollView.bounds.width - 100,
            height: scrollView.bounds.height - 50
        )

        let aspectRatio = image.size.width / image.size.height

        var scaledSize = CGSize(width: maxSize.width, height: maxSize.width / aspectRatio)

        if scaledSize.height > maxSize.height {
            scaledSize = CGSize(width: maxSize.height * aspectRatio, height: maxSize.height)
        }

        imageView.frame = CGRect(origin: .zero, size: scaledSize)
        scrollView.addSubview(imageView)

        scrollView.contentSize = scaledSize
        scrollView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        centerImage()
    }



    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        centerImage()
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }

    private func centerImage() {
        let scrollViewSize = scrollView.bounds.size
        let imageViewSize = imageView.frame.size

        let horizontalInset = max((scrollViewSize.width - imageViewSize.width) / 2, 0)
        let verticalInset = max((scrollViewSize.height - imageViewSize.height) / 2, 0)

        scrollView.contentInset = UIEdgeInsets(
            top: verticalInset + 20,
            left: horizontalInset + 20,
            bottom: verticalInset + 20,
            right: horizontalInset + 20
        )
    }
}
