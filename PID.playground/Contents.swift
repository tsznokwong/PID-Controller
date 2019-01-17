
class PIDController {
    
    private let Cp: Double = 0.3
    private let Ci: Double = 0.25
    private let Cd: Double = 0.1
    
    var target: Double = 80
    var current: Double = 10
    var flow: Double = 0.2
    
    private let cycleTime: Double = 0.1
    var currentTime: Double = 0
    
    var error: Double { return target - current }

    var integral: Double = 0
    private var previousCycleError: Double = 0
    var differential: Double { return (error - previousCycleError) / cycleTime }
    
    private let epsilon = 0.01
    
    func setFlow(_ x: Double) {
        flow = x
        self.adjust()
    }
    
    func setCurrent(_ x: Double) {
        current = x
        self.adjust()
    }
    
    func setTarget(_ x: Double) {
        target = x
        self.adjust()
    }
    
    func adjust() {
        currentTime += cycleTime
        previousCycleError = error
        integral += error * cycleTime
        current += flow
        flow += Cp * error + Ci * integral + Cd * differential
        current
        flow
        if abs(error) > epsilon {
            self.adjust()
        }
    }
    
    init() {
        self.adjust()
    }
}
let pid = PIDController()
pid.setFlow(100)
pid.setTarget(200)
pid.setCurrent(100)
pid.currentTime

