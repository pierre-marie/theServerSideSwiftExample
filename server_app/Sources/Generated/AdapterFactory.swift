import Foundation
import Configuration
import CloudEnvironment

public class AdapterFactory {
    let cloudEnv: CloudEnv

    init(cloudEnv: CloudEnv) {
        self.cloudEnv = cloudEnv
    }

    public func getCreatureAdapter() throws -> CreatureAdapter {
      return CreatureMemoryAdapter()
    }
}
