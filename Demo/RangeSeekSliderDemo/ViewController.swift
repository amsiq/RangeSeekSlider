//
//  ViewController.swift
//  RangeSeekSliderDemo
//
//  Created by Keisuke Shoji on 2017/03/08.
//
//

import UIKit
import RangeSeekSlider

final class ViewController: UIViewController {

    @IBOutlet fileprivate weak var rangeSlider: RangeSeekSlider!
    @IBOutlet fileprivate weak var rangeSliderCurrency: RangeSeekSlider!
    @IBOutlet fileprivate weak var rangeSliderCustom: RangeSeekSlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        // standard range slider
        rangeSlider.delegate = self

        // currency range slider
        rangeSliderCurrency.delegate = self
        rangeSliderCurrency.minValue = 50.0
        rangeSliderCurrency.maxValue = 150.0
        rangeSliderCurrency.selectedMinValue = 60.0
        rangeSliderCurrency.selectedMaxValue = 140.0
        rangeSliderCurrency.minDistance = 20.0
        rangeSliderCurrency.maxDistance = 80.0
        rangeSliderCurrency.handleColor = .green
        rangeSliderCurrency.handleDiameter = 30.0
        rangeSliderCurrency.selectedHandleDiameterMultiplier = 1.3
        rangeSliderCurrency.numberFormatter.numberStyle = .currency
        rangeSliderCurrency.numberFormatter.locale = Locale(identifier: "en_US")
        rangeSliderCurrency.numberFormatter.maximumFractionDigits = 2
        rangeSliderCurrency.minLabelFont = UIFont(name: "ChalkboardSE-Regular", size: 15.0)!
        rangeSliderCurrency.maxLabelFont = UIFont(name: "ChalkboardSE-Regular", size: 15.0)!

        // custom number formatter range slider
        rangeSliderCustom.delegate = self
        rangeSliderCustom.minValue = 0.0
        rangeSliderCustom.maxValue = 100.0
        rangeSliderCustom.selectedMinValue = 40.0
        rangeSliderCustom.selectedMaxValue = 60.0
        rangeSliderCustom.handleImage = #imageLiteral(resourceName: "custom-handle")
        rangeSliderCustom.selectedHandleDiameterMultiplier = 1.0
        rangeSliderCustom.colorBetweenHandles = .red
        rangeSliderCustom.lineHeight = 10.0
        rangeSliderCustom.numberFormatter.positivePrefix = "$"
        rangeSliderCustom.numberFormatter.positiveSuffix = "M"
        
        let gradient = generate(colors: [UIColor(red: 0.99, green: 0.61, blue: 0.25, alpha: 1), UIColor(red: 1, green: 0.3, blue: 0.63, alpha: 1)])
        rangeSliderCustom.setSliderLineBetweenHandlesGradient(gradient: gradient)
        
    }
    
    private func generate(colors: [UIColor], orientation: GradientOrientation = .topLeftBottomRight, locations: [NSNumber]? = nil) -> CAGradientLayer {
           let layer = CAGradientLayer()

           layer.colors = colors.map { $0.cgColor }
           layer.startPoint = orientation.startPoint
           layer.endPoint = orientation.endPoint
           layer.locations = locations // the locations array should contain the same number of items as the colors array.

           return layer
       }
}
enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case bottomRightTopLeft
    case bottomLeftTopRight
    case horizontal
    case verticalUp
    case verticalDown

    var startPoint: CGPoint {
        get { return self.points.startPoint }
    }

    var endPoint: CGPoint {
        get { return self.points.endPoint }
    }

    var points: (startPoint: CGPoint, endPoint: CGPoint) {
        get {
            switch self {
            case .topRightBottomLeft:
                return (CGPoint(x: 1.0, y: 0.0), CGPoint(x: 0.0, y: 1.0))
            case .topLeftBottomRight:
                return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 1.0, y: 1.0))
            case .bottomRightTopLeft:
                return (CGPoint(x: 1.0, y: 1.0), CGPoint(x: 0.0, y: 0.0))
            case .bottomLeftTopRight:
                return (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0))
            case .horizontal:
                return (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
            case .verticalUp:
                return (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 0.0, y: 0.0))
            case .verticalDown:
                return (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 0.0, y: 1.0))
            }
        }
    }
}


// MARK: - RangeSeekSliderDelegate

extension ViewController: RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === rangeSlider {
            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        } else if slider === rangeSliderCurrency {
            print("Currency slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        } else if slider === rangeSliderCustom {
            print("Custom slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        }
    }

    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }

    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}
