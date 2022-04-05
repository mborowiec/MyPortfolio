import SwiftUI

struct DoughnutSlice: Shape {
    let startAngle: Double
    let endAngle: Double
    let thickness: Double
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) * 0.5
            let startPoint = CGPoint(x: center.x + (radius - thickness) * cos(startAngle), y: center.y + (radius - thickness) * sin(startAngle))
            path.move(to: startPoint)
            let point = CGPoint(x: center.x + radius * cos(startAngle), y: center.y + radius * sin(startAngle))
            path.addLine(to: point)
            path.addArc(center: center,
                        radius: radius,
                        startAngle: Angle(radians: startAngle),
                        endAngle: Angle(radians: endAngle),
                        clockwise: false)
            let endPoint = CGPoint(x: center.x + (radius - thickness) * cos(endAngle), y: center.y + (radius - thickness) * sin(endAngle))
            path.addLine(to: endPoint)
            path.addArc(center: center,
                        radius: radius - thickness,
                        startAngle: Angle(radians: endAngle),
                        endAngle: Angle(radians: startAngle),
                        clockwise: true)
            path.closeSubpath()
        }
    }
}

public struct DoughnutChart: View {
    private var data: [SliceData]
    private let thickness = 40.0
    private var seriesColors: [Color] {
        [Color(red: 255.0/255, green: 166.0/255, blue: 0.0),
         Color(red: 255.0/255, green: 124.0/255, blue: 67.0/255),
         Color(red: 249.0/255, green: 93.0/255, blue: 106.0/255),
         Color(red: 212.0/255, green: 80.0/255, blue: 135.0/255),
         Color(red: 160.0/255, green: 81.0/255, blue: 149.0/255),
         Color(red: 102.0/255, green: 81.0/255, blue: 145.0/255),
         Color(red: 47.0/255, green: 75.0/255, blue: 124.0/255),
         Color(red: 0.0/255, green: 63.0/255, blue: 92.0/255)]
    }
    
    public init(data: [SliceData]) {
        self.data = data
    }
    
    public var body: some View {
        ZStack {
            ForEach(self.data, id: \.self) { sliceData in
                let sliceColor = sliceColor(for: sliceData)
                DoughnutSlice(startAngle: sliceData.startAngle,
                              endAngle: sliceData.endAngle,
                              thickness: thickness)
                    .fill(sliceColor)
            }
        }
    }
    
    func sliceColor(for sliceData: SliceData) -> Color {
        guard let index = data.firstIndex(of: sliceData) else {
            return .blue
        }
        
        return seriesColors[index]
    }
    
    func filling<T: View>(@ViewBuilder doughnutFilling: () -> T) -> some View {
        return ZStack {
            self
            doughnutFilling()
                .padding(60)
        }
    }
}

