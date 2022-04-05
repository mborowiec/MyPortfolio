import Foundation

public protocol ChartData {
    var labels: [String] { get }
    var series: [Double] { get }
}

public struct SampleChartData: ChartData {
    public init() {}
    
    public var labels: [String] {
        ["Label 1", "Label 2", "Label 3", "Label 4", "Label 5", "Label 6", "Label 7"]
    }
    
    public var series: [Double] {
        [10, 40, 120, 35, 5, 60, 8]
    }
}

extension Collection where Element == Double {
    var sum: Double {
        reduce(0, +)
    }
}

extension ChartData {
    public func mapToSliceData() -> [SliceData] {
        let sum = series.sum
        var sliceData = [SliceData]()
        var previousEndAngle: Double = 0.0
        for (i, value) in series.enumerated() {
            let endAngle = (Double(value) / Double(sum)) * (Double.pi*2) + previousEndAngle
            let clappedEndAngle = (endAngle > Double.pi*2) ? Double.pi*2 : endAngle
            sliceData.append(SliceData(value: value, label: labels[i], startAngle: previousEndAngle, endAngle: clappedEndAngle))
            previousEndAngle = clappedEndAngle
        }
        
        return sliceData
    }
}

