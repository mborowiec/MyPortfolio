import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    var body: some View {
        DoughnutChart(data: SampleChartData().mapToSliceData())
            .frame(width: 400, height: 400)
    }
}

PlaygroundPage.current.setLiveView(ContentView())
