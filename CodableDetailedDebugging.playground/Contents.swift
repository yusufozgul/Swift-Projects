import UIKit

var jsonString: String = """
{
  "link": "https://yusufozgul.com",
  "data": [
    { "type": "comments", "content": "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir." },
    { "type": "comments", "content": "Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500'lerden beri endüstri standardı sahte metinler olarak kullanılmıştır." }
  ]
}
"""

struct CommentResponse: Codable {
    let link: String
    let data: [CommentResponseData]

    enum CodingKeys: String, CodingKey {
        case link
        case data
    }
}

struct CommentResponseData: Codable {
    let type: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case type
        case content
    }
}

let jsonData = jsonString.data(using: .utf8)

if let data = jsonData {
   
    do {
        
        /// json decode etmek için sınıfımızı oluşturuyoruz.
        let decoder = JSONDecoder()
        let response = try decoder.decode(CommentResponse.self, from: data) /// try ile deneyecek eğer başarısız olursa catch'e düşecek.
        print(response.link)
    } catch DecodingError.dataCorrupted(let context) {
        /// Eğer gelen data geçerli bir json değilse veya data ile ilgili başka bir sorun oluşmuşsa buradan hatayı yakalayabiliriz.
        
        print(context.debugDescription)
    } catch DecodingError.keyNotFound(let key, let context) {
        
        /// Struct'ta bir field var ancak bu optional değil. Gelen json'da bu field bulunamazsa hatamızı buradan yakalayabiliriz ve hangi field olduğunu anlayabiliriz.
        print("\(key.stringValue) was not found, \(context.debugDescription)")
    } catch DecodingError.typeMismatch(let type, let context) {
        
        /// Type safty önemli Struct'ı tanımlarken her field için tipini belirtiyoruz. Gelen json'daki field'ın tipi ile Struct'taki tip uyuşmadığı zaman hatayı buradan yakayabiliriz.
        print("\(type) was expected, \(context.debugDescription)")
    } catch DecodingError.valueNotFound(let type, let context) {
        
        /// Bir field ya optional'dır ya da değildir. Eğer Struct'ta optional tanımlamadınız ve json'da nil gelecek olursa hatayı buradan ele alabilirsiniz.
        print("no value was found for \(type), \(context.debugDescription)")
    } catch {
        
        /// En sonunda hata hala ele alınamamışsa burdan alıyoruz.
        print("Other Error")
    }
}


