import SwiftUI
import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    @Published var isBluetoothAvailable = false
    @Published var isReceivingData = false
    @Published var receivedValue: Float = 0.0
    
    @Published var selectedPeripheral: CBPeripheral?
    @Published var isConnecting = false
    @Published var peripherals: [CBPeripheral] = []
    @Published var isDeviceListVisible = false
    
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    private var characteristic: CBCharacteristic!
    
    @Published var graphData: [Float] = []
    @Published var shouldClearGraph = false
    @Published var maxDataPoints = 100
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startReceivingData() {
        isReceivingData.toggle()
        //isReceivingData = true
    }
    
    func disconnectFromPeripheral() {
        if let peripheral = selectedPeripheral {
            centralManager.cancelPeripheralConnection(peripheral)
        }
        selectedPeripheral = nil
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        isConnecting = true
        peripheral.delegate = self
        
        print("Connecting to: \(peripheral.name ?? "Unknown device")")
        
        peripheral.discoverServices(nil)
        
        //emgData.startCapture()
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        isBluetoothAvailable = central.state == .poweredOn
        if isBluetoothAvailable {
            central.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            peripherals.append(peripheral)
            //central.connect(peripheral, options: nil)
        }
    }
    
    func connectToPeripheral(_ peripheral: CBPeripheral) {
        centralManager.connect(peripheral, options: nil)
        selectedPeripheral = peripheral
    }
    
    func startScanning(){
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func stopScanning() {
        centralManager.stopScan()
    }    
}

extension BluetoothManager {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == CBUUID(string: "6d630984-6efc-11ee-b962-0242ac120002") {
                    self.characteristic = characteristic
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let value = characteristic.value {
            //print("rawdata \(value)")
            let floatValue = Float(value[0]) / 255.0 // Conversión de valor recibido a flotante
            receivedValue = floatValue
            if isReceivingData {
                // Actualizar la interfaz de usuario o realizar otras acciones necesarias
                print("Valor recibido: \(floatValue)")
                
                
                graphData.append(floatValue)
                
                if graphData.count % 100 == 0 {
                    graphData.removeFirst(100)
                }
                
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from: \(peripheral.name ?? "Unknown device")")
    }
    
    
    func clearGraph() {
        graphData.removeAll()
        shouldClearGraph = false
    }
    
}



struct DisplayCont: View {
    @ObservedObject var bluetoothManager = BluetoothManager()
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 150)
                    .padding(.top)
                
                Text(bluetoothManager.isBluetoothAvailable ? "Bluetooth is available" : "Bluetooth is not connected")
                    .padding()
                    .fontWeight(.semibold)
                
                
                Button(action: {
                    bluetoothManager.isConnecting.toggle()
                    if bluetoothManager.isConnecting {
                        bluetoothManager.startScanning()
                        bluetoothManager.isDeviceListVisible = true
                    } else {
                        bluetoothManager.stopScanning()
                        bluetoothManager.isDeviceListVisible = false
                    }
                }) {
                    Text(bluetoothManager.isConnecting ? "Back" : "Connect")
                        .fontWeight(.semibold)
                        .foregroundColor(.white )
                }
                .padding()
                .background(Color(.systemBlue))
                .cornerRadius(10)
                
                if bluetoothManager.isDeviceListVisible {
                    List(bluetoothManager.peripherals, id: \.self) { peripheral in
                        Button(action: {
                            bluetoothManager.connectToPeripheral(peripheral)
                        }) {
                            Text(peripheral.name ?? "Unknown device")
                        }
                    }
                }
                
                Button("Disconnect") {
                    bluetoothManager.disconnectFromPeripheral()
                }
                .padding()
                .background(Color.red)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                
                Button( action: {
                    bluetoothManager.startReceivingData()
                }) {
                    Text(bluetoothManager.isReceivingData ? "Stop" : "Start")
                    
                        .padding()
                        .background(bluetoothManager.isReceivingData ? Color.red : Color.green)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                
                
            }
            
            VStack {
                Button("Graph") {
                    bluetoothManager.clearGraph()
                }
                .padding()
                .background(Color.yellow)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .cornerRadius(10)
                
            GraphLine(dataPoints: bluetoothManager.graphData, maxDataPoints: bluetoothManager.maxDataPoints)
                
            }
            
        }
        .navigationBarHidden(true)
    }
}


struct GraphLine: View {
    var dataPoints: [Float]
    var maxDataPoints: Int
    var graphHeight: CGFloat = 450
    
    @State private var linePosition: CGFloat = 0
    @State private var currentXValue: Int = 0
    
    var body: some View {
        GeometryReader { geometry in 
            VStack {
                ZStack {
                    // Línea de cuadrícula horizontal
                    ForEach(1..<20) { index in
                        let y = CGFloat(index) / 20 * geometry.size.height
                        Path { path in 
                            path.move(to: CGPoint(x:0, y: y))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                        }
                        .stroke(Color.gray.opacity(0.5),lineWidth: 0.5)
                    }
                    
                    // Línea de cuadrícula vertical
                    ForEach(1..<20) { index in
                        let x = CGFloat(index) / 20 * geometry.size.width
                        Path { path in
                            path.move(to: CGPoint(x: x, y: 0))
                            path.addLine(to: CGPoint(x: x, y: geometry.size.height))
                        }
                        .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    }
                    
                    // Línea que se grafica 
                    Path { path in
                        let step = geometry.size.width / CGFloat(min(dataPoints.count, maxDataPoints) - 1)
                        path.move(to: CGPoint(x: 0, y: geometry.size.height))
                        for (index, dataPoint) in dataPoints.enumerated() {
                            let x = (geometry.size.width / CGFloat(dataPoints.count - 1)) * CGFloat(index)
                            let y = geometry.size.height - CGFloat(dataPoint) * geometry.size.height
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                    .stroke(Color.red, lineWidth: 2)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    // Eje en y
                    Path { path in
                        path.move(to: CGPoint(x:0, y: 0))
                        path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    }
                    .stroke(Color.black, lineWidth: 5)
                    
                    // Eje en x
                    Path { path in 
                        path.move(to: CGPoint(x: 0, y: geometry.size.height ))
                        path.addLine(to: CGPoint(x: geometry.size.width , y: geometry.size.height))
                    }
                    .stroke(Color.black, lineWidth: 5)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    HStack {
                        Spacer()
                        
                        Text("Time(s)")
                            .font(.headline)
                            .padding(.bottom, 0)
                            .offset(y: 450)
                        
                        VStack {
                            Text("Voltage (V)")
                                .font(.headline)
                                .rotationEffect(.degrees(-90))
                                .padding(.leading, -800)
                        }
                    }
                    
                    ForEach(0..<20) { index in 
                        let invertdval = 1 - Double(index) * 0.05 
                        let invrtdroundval = String(format: "%.2f", invertdval)
                        Text("\(invrtdroundval)V")
                            .font(.caption)
                            .offset(x: -375, y: CGFloat(index) / 20 * geometry.size.height - 20)
                    }
                }
            }
            .frame(width: geometry.size.width, height: 50)
        }
        .frame(width: 700, height: graphHeight)
    }
}

struct RolBLE_Previews: PreviewProvider {
    static var previews: some View {
        DisplayCont()
    }
}

