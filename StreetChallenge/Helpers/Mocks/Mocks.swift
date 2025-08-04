//
//  Mocks.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 19/12/2023.
//

import Foundation
import MapKit

let mockQuestion = Question(
    id: "1",
    globalId: "111",
    questionText: "These people can’t imagine their pancakes without IT.\nThere are some of ITS “producers” in this park. What is IT?",
    answerText: "maple syrup",
    answerImageUrl: URL(string: "https://fastly.picsum.photos/id/994/200/300.jpg?hmac=qE64z1oNNOrx-yilgjIyDxWRQ7WIawmgrfrHGY-0aGs"),
    commentText: "On the photos you see famous canadians. On the photos you see famous canadians",
    areaId: "1",
    areaName: "Hampstead",
    cityId: "1",
    cityName: "London",
    imageName: "image001",
    userAnswer: nil,
    answerCoordinate: .init(latitude: 51.0, longitude: -0.1),
    answered: false
    
)

let mockQuestion2 = Question(
    id: "2",
    globalId: "112",
    questionText: """
”I am a French Painter... As a pupil of Whistler, I derive from the French School”.\n
    Find the place where the author of this quote lived (look for a green plaque) and write the years when he had a studio there.
""",
    answerText: "maple syrup",
    answerImageUrl: URL(string: "https://fastly.picsum.photos/id/488/536/354.jpg?hmac=uuSutAju0Oek5hOxphawYaWInYqjC8wM8VpXJqJj3IA"),
    commentText: "On the photos you see famous canadians",
    areaId: "1",
    areaName: "Hampstead",
    cityId: "1",
    cityName: "London",
    imageName: "",
    userAnswer: nil,
    answerCoordinate: .init(latitude: 51.0, longitude: -0.1),
    answered: false
)

let mockQuestion3 = Question(
    id: "3",
    globalId: "113",
    questionText: "These people can’t imagine their pancakes without IT.\nThere are some of ITS “producers” in this park. What is IT?",
    answerText: "maple syrup",
    answerImageUrl: URL(string: "https://fastly.picsum.photos/id/994/200/300.jpg?hmac=qE64z1oNNOrx-yilgjIyDxWRQ7WIawmgrfrHGY-0aGs"),
    commentText: "On the photos you see famous canadians. On the photos you see famous canadians",
    areaId: "1",
    areaName: "Hampstead",
    cityId: "1",
    cityName: "London",
    imageName: "image001",
    userAnswer: nil,
    answerCoordinate: .init(latitude: 51.0, longitude: -0.1),
    answered: false

)

let mockQuestion4 = Question(
    id: "4",
    globalId: "114",
    questionText: """
”I am a French Painter... As a pupil of Whistler, I derive from the French School”.\n
    Find the place where the author of this quote lived (look for a green plaque) and write the years when he had a studio there.
""",
    answerText: "maple syrup",
    answerImageUrl: URL(string: "https://fastly.picsum.photos/id/488/536/354.jpg?hmac=uuSutAju0Oek5hOxphawYaWInYqjC8wM8VpXJqJj3IA"),
    commentText: "On the photos you see famous canadians",
    areaId: "1",
    areaName: "Hampstead",
    cityId: "1",
    cityName: "London",
    imageName: "",
    userAnswer: nil,
    answerCoordinate: .init(latitude: 51.0, longitude: -0.1),
    answered: false
)

let mockQuestion5 = Question(
    id: "4",
    globalId: "114",
    questionText: """
”I am a French Painter... As a pupil of Whistler, I derive from the French School”.\n
    Find the place where the author of this quote lived (look for a green plaque) and write the years when he had a studio there.
""",
    answerText: "maple syrup",
    answerImageUrl: nil,
    commentText: "On the photos you see famous canadians",
    areaId: "1",
    areaName: "Hampstead",
    cityId: "1",
    cityName: "London",
    imageName: "",
    userAnswer: nil,
    answerCoordinate: .init(latitude: 51.0, longitude: -0.1),
    answered: false
)


let emptyQuestion = Question(
    id: "",
    globalId: "",
    questionText: "",
    answerText: "",
    answerImageUrl: nil,
    commentText: "",
    areaId: "",
    areaName: "",
    cityId: "",
    cityName: "",
    imageName: nil,
    userAnswer: nil,
    answerCoordinate: .init(latitude: 51.0, longitude: -0.1),
    answered: false
)

let mockLatitude: CLLocationDegrees = 51.5787402
let mockLongitude: CLLocationDegrees = -0.1235992

let mockAreaCenter: CLLocationCoordinate2D = .init(
    latitude: mockLatitude,
    longitude: mockLongitude
)

let mockArea = Area(
    id: "002",
    name: "Crouch End",
    faq: """
    **Crouch End** is a vibrant and trendy area in North London, known for its distinct community vibe, artistic culture, and a variety of shops, cafes, and entertainment options.
    Here are some key points about Crouch End:
    
    **Artistic Hub:** Crouch End has a rich artistic heritage, attracting musicians, artists, and writers. It's home to various art galleries, theaters, and music venues.
    **Community Spirit:** The area has a strong sense of community, with events like the Crouch End Festival, bringing locals together through art, music, and cultural activities.
    
    **Local Shops and Boutiques:** The streets are lined with independent shops, boutiques, and vintage stores offering unique and eclectic items.
    **Cafes and Restaurants:** It boasts a diverse culinary scene, with a range of cafes, restaurants, and bars catering to various tastes.
    **Green Spaces:** Nearby green areas like Alexandra Park and Priory Park offer opportunities for outdoor activities and relaxation.
    
    **Residential Area:** Crouch End is mainly residential, attracting families and professionals seeking a quieter but vibrant neighborhood.
    **Transport Links:** It has good transport connections, making it accessible to central London via buses and the nearby Hornsey railway station.
    
    **Housing:** Properties in Crouch End vary from Victorian and Edwardian houses to modern apartments. The area is known for its attractive architecture.
    **Property Prices:** The property prices in Crouch End tend to be relatively high due to its popularity and desirability.
    
    Crouch End's mix of culture, community spirit, and a range of amenities make it an appealing place to live and visit, especially for those seeking a lively yet laid-back atmosphere within London.
    """,
    center: mockAreaCenter,
    image: "highbury",
    imageUrl: URL(string: "https://fastly.picsum.photos/id/994/200/300.jpg?hmac=qE64z1oNNOrx-yilgjIyDxWRQ7WIawmgrfrHGY-0aGs"),
    premium: true,
    available: true,
    hasGuides: true,
    directions: """
    Buses:\n
    41, 91, W3, W5, W7
    \n\n
    Train Stations:\n
    Hornsey, Harringay, Finsbury Park
    \n\n
    London Overground Station:\n
    Crouch Hill
    \n\n
    Tube:\n
    Turnpike Lane (Piccadilly Line), Finsbury Park (Victoria and Piccadilly Lines), Highgate (Northern Line), Archway (Northern Line)
    \n\n
    Walking or Cycling:\n
    The Parkland Walk is a shared-use path that follows the course of a former railway line between Finsbury Park and Alexandra Palace, passing through Crouch End.
    """,
    isTest: false
)

let mockArea2 = Area(
    id: "2",
    name: "Highbury",
    faq: """
    **Crouch End** is a vibrant and trendy area in North London, known for its distinct community vibe, artistic culture, and a variety of shops, cafes, and entertainment options.
    Here are some key points about Crouch End:
    
    **Artistic Hub:** Crouch End has a rich artistic heritage, attracting musicians, artists, and writers. It's home to various art galleries, theaters, and music venues.
    **Community Spirit:** The area has a strong sense of community, with events like the Crouch End Festival, bringing locals together through art, music, and cultural activities.
    
    **Local Shops and Boutiques:** The streets are lined with independent shops, boutiques, and vintage stores offering unique and eclectic items.
    **Cafes and Restaurants:** It boasts a diverse culinary scene, with a range of cafes, restaurants, and bars catering to various tastes.
    **Green Spaces:** Nearby green areas like Alexandra Park and Priory Park offer opportunities for outdoor activities and relaxation.
    
    **Residential Area:** Crouch End is mainly residential, attracting families and professionals seeking a quieter but vibrant neighborhood.
    **Transport Links:** It has good transport connections, making it accessible to central London via buses and the nearby Hornsey railway station.
    
    **Housing:** Properties in Crouch End vary from Victorian and Edwardian houses to modern apartments. The area is known for its attractive architecture.
    **Property Prices:** The property prices in Crouch End tend to be relatively high due to its popularity and desirability.
    
    Crouch End's mix of culture, community spirit, and a range of amenities make it an appealing place to live and visit, especially for those seeking a lively yet laid-back atmosphere within London.
    """,
    center: mockAreaCenter,
    image: "highbury",
    imageUrl: URL(string: "https://fastly.picsum.photos/id/994/200/300.jpg?hmac=qE64z1oNNOrx-yilgjIyDxWRQ7WIawmgrfrHGY-0aGs"),
    premium: false,
    available: false,
    hasGuides: false,
    directions: "",
    isTest: false
)

let mockArea3 = Area(
    id: "3",
    name: "Hampstead",
    faq: """
    **Hampstead** is a vibrant and trendy area in North London, known for its distinct community vibe, artistic culture, and a variety of shops, cafes, and entertainment options.
    Here are some key points about Crouch End:
    
    **Artistic Hub:** Crouch End has a rich artistic heritage, attracting musicians, artists, and writers. It's home to various art galleries, theaters, and music venues.
    **Community Spirit:** The area has a strong sense of community, with events like the Crouch End Festival, bringing locals together through art, music, and cultural activities.
    
    **Local Shops and Boutiques:** The streets are lined with independent shops, boutiques, and vintage stores offering unique and eclectic items.
    **Cafes and Restaurants:** It boasts a diverse culinary scene, with a range of cafes, restaurants, and bars catering to various tastes.
    **Green Spaces:** Nearby green areas like Alexandra Park and Priory Park offer opportunities for outdoor activities and relaxation.
    
    **Residential Area:** Crouch End is mainly residential, attracting families and professionals seeking a quieter but vibrant neighborhood.
    **Transport Links:** It has good transport connections, making it accessible to central London via buses and the nearby Hornsey railway station.
    
    **Housing:** Properties in Crouch End vary from Victorian and Edwardian houses to modern apartments. The area is known for its attractive architecture.
    **Property Prices:** The property prices in Crouch End tend to be relatively high due to its popularity and desirability.
    
    Crouch End's mix of culture, community spirit, and a range of amenities make it an appealing place to live and visit, especially for those seeking a lively yet laid-back atmosphere within London.
    """,
    center: mockAreaCenter,
    image: "highbury",
    imageUrl: URL(string: "https://fastly.picsum.photos/id/994/200/300.jpg?hmac=qE64z1oNNOrx-yilgjIyDxWRQ7WIawmgrfrHGY-0aGs"),
    premium: false,
    available: true,
    hasGuides: true,
    directions: "",
    isTest: false
)

let mockPoi1 = PointOfInterest(
    id: "1",
    areaId: "002",
    title: "Clock Tower Clock Tower Clock Tower Clock Tower Clock Tower",
    description: "The red-brick Clock Tower has become a much-loved icon of Crouch End",
    shortDescription: "The red-brick Clock Tower has become a much-loved icon of Crouch End. The red-brick Clock Tower has become a much-loved icon of Crouch End. The red-brick Clock Tower has become a much-loved icon of Crouch End. ",
    coordinate: .init(
        latitude: 51.5798194,
        longitude: -0.1236746
    )
)

let mockPoi2 = PointOfInterest(
    id: "2",
    areaId: "002",
    title: "Dunns",
    description: "Handcrafted in Crouch End, Dunns is a true Artisan Bakery, specalising in handmade breads, sourdough, cakes.",
    shortDescription: "The red-brick Clock Tower has become a much-loved icon of Crouch End",
    coordinate: .init(
        latitude: 51.5784909,
        longitude: -0.1235603
    )
)

let mockPoi3 = PointOfInterest(
    id: "3",
    areaId: "002",
    title: "Hornsey Library",
    description: "Hornsey Library is a Grade II listed building and offers a variety of services and facilities in the heart of Crouch End.",
    shortDescription: "The red-brick Clock Tower has become a much-loved icon of Crouch End",
    coordinate: .init(
        latitude: 51.5782048,
        longitude: -0.1223817
    )
)

let mockPoi4 = PointOfInterest(
    id: "4",
    areaId: "002",
    title: "Christ Church",
    description: """
    The Church has always been an integral part of the Crouch End neighbourhood. Having outgrown its original site, a chapel on the Broadway, the current Christ Church building was constructed in 1862. The Church expanded in 1867 by adding a South aisle and various other developments were made over the next 120 years, including the organ which is still in place today and a further chapel in the 1980s.

    In 2004 a new Parish hall was built which still serves as a focal point for a number of Crouch End neighbourhood activities.

    In recent years, Christ Church launched an additional service for young professionals and young families that are a large part of our vibrant community. We decided to combine the services so we could meet as one congregation on a Sunday morning celebrating our diversity and unity as God’s people together.
""",
    shortDescription: "The red-brick Clock Tower has become a much-loved icon of Crouch End",
    furtherReadingUrl: URL(string: "https://google.com"),
    imageUrl: URL(string: "https://firebasestorage.googleapis.com/v0/b/streetchallenge-laechoppe.appspot.com/o/PointsOfInterest%2FHampstead%2Fhampstead_stjohnchurch.jpg?alt=media&token=e351489d-9b7c-42b7-975a-b392401e477c"),
    coordinate: .init(
        latitude: 51.5759443,
        longitude: -0.1266157
    )
)

