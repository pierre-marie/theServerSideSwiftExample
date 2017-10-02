public protocol CreatureAdapter {
    func findAll(onCompletion: @escaping ([Creature], Error?) -> Void)
    func create(_ model: Creature, onCompletion: @escaping (Creature?, Error?) -> Void)
    func deleteAll(onCompletion: @escaping (Error?) -> Void)

    func findOne(_ maybeID: String?, onCompletion: @escaping (Creature?, Error?) -> Void)
    func update(_ maybeID: String?, with model: Creature, onCompletion: @escaping (Creature?, Error?) -> Void)
    func delete(_ maybeID: String?, onCompletion: @escaping (Creature?, Error?) -> Void)
}
