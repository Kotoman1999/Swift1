
import UIKit

// получить папку Документы для текущего приложения и пользователя
let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let url = directory.appendingPathComponent("notes").appendingPathExtension("plist")

// Cmd+Alt+[ или Cmd+Alt+] — двигать строку вверх/вниз
/// Заметка
struct Note: Codable {
    
    /// Заголовок заметки
    let title: String
    
    /// Текст заметки
    let text: String
    
    /// Время создания заметки
    let timestamp: Date
}

let note = Note(title: "Список покупок", text: "Яблоки, груши, сливы", timestamp: Date())

let notes = [
    Note(title: "Список покупок", text: "Яблоки, груши, сливы", timestamp: Date()),
    Note(title: "Интесные идеи", text: "Яблоки, груши, сливы", timestamp: Date()),
    Note(title: "Не забыть", text: "Яблоки, груши, сливы", timestamp: Date()),
    Note(title: "Траты", text: "Яблоки, груши, сливы", timestamp: Date()),
    Note(title: "Доходы", text: "Яблоки, груши, сливы", timestamp: Date()),
    Note(title: "Почитать", text: "Яблоки, груши, сливы", timestamp: Date()),
]

// создаём кодировщик
let encoder = PropertyListEncoder()
// кодируем заметку
if let encodedNode = try? encoder.encode(notes) {
    print(encodedNode)
    
    // запись в файл
    try? encodedNode.write(to: url, options: .noFileProtection)
    
    // чтение из файла
    if let data = try? Data(contentsOf: url) {
        
        // создаём декодировщик
        let decoder = PropertyListDecoder()
        
        // декодируем заметку
        if let decodedNote = try? decoder.decode([Note].self, from: data) {
            print(decodedNote)
        }
    }
}
