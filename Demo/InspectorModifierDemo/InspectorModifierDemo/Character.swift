//
//  Data.swift
//  InspectorModifierDemo
//
//  Created by Daniel Fortes on 05/09/23.
//

import Foundation

struct Character: Identifiable {
    var id = UUID()
    var name: String
    var description: String
}

extension Character {
    static let allCharacters: [Character] = Self.detectiveCharacters + Self.fantasyCharacters + Self.sciFiCharacters
    static let detectiveCharacters: [Character] = fictionalDetectivesData.map{ Character(name: $0, description: $1)}
    static let fantasyCharacters: [Character] = fantasyCharactersData.map{ Character(name: $0, description: $1)}
    static let sciFiCharacters: [Character] = sciFiCharactersData.map{ Character(name: $0, description: $1)}
}

let fictionalDetectivesData: [(String, String)] = [
    ("Sherlock Holmes", "Sherlock Holmes is a brilliant detective known for his deductive reasoning and solving complex mysteries."),
    ("Hercule Poirot", "Hercule Poirot is a Belgian detective with a keen sense of observation and a penchant for solving murder cases."),
    ("Miss Marple", "Miss Marple is an elderly amateur detective who lives in the village of St. Mary Mead and solves crimes with her sharp intuition."),
    ("Nancy Drew", "Nancy Drew is a teenage sleuth known for her intelligence and fearlessness in solving mysteries."),
    ("Philip Marlowe", "Philip Marlowe is a private investigator in hard-boiled detective novels known for his tough demeanor and moral code."),
    ("Sam Spade", "Sam Spade is a private detective famous for his role in 'The Maltese Falcon' and his no-nonsense approach to solving cases."),
    ("Humphrey Bogart", "Humphrey Bogart is a fictional detective character known for his roles in classic film noir movies."),
    ("Columbo", "Columbo is a television detective known for his disheveled appearance and brilliant investigative techniques."),
    ("Jessica Fletcher", "Jessica Fletcher is a mystery novelist and amateur detective who solves crimes in the fictional town of Cabot Cove."),
    ("Dirk Gently", "Dirk Gently is a holistic detective who believes in the interconnectedness of all things and uses unusual methods to solve cases."),
    ("Adrian Monk", "Adrian Monk is a brilliant but obsessive-compulsive detective known for his attention to detail and solving complex crimes."),
    ("Thomas Magnum", "Thomas Magnum is a private investigator in Hawaii known for his laid-back attitude and solving cases with a sense of humor."),
    ("Harry Bosch", "Harry Bosch is a detective in Michael Connelly's novels known for his determination in solving cold cases."),
    ("Ellery Queen", "Ellery Queen is a fictional detective and mystery writer known for his intellect and solving crimes alongside his father."),
    ("Nick Charles", "Nick Charles is a retired detective who, with his wife Nora, solves mysteries in 'The Thin Man' series."),
    ("Auguste Dupin", "Auguste Dupin is a detective created by Edgar Allan Poe and known for his analytical mind in solving crimes."),
    ("Peter Wimsey", "Lord Peter Wimsey is an aristocratic detective created by Dorothy L. Sayers, known for his wit and sophistication."),
    ("Kinsey Millhone", "Kinsey Millhone is a private investigator in Sue Grafton's alphabet mystery series, known for her perseverance."),
    ("Perry Mason", "Perry Mason is a defense attorney and detective known for his courtroom skills and solving cases to prove his clients' innocence."),
    ("Dick Tracy", "Dick Tracy is a detective known for his sharp features, yellow trench coat, and solving complex criminal cases.")
]


let fantasyCharactersData: [(String, String)] = [
    ("Gandalf the Grey", "Gandalf is a wise and powerful wizard in J.R.R. Tolkien's Middle-earth, known for his role in the fight against Sauron."),
    ("Aragorn", "Aragorn is the rightful heir to the throne of Gondor and a key figure in the Lord of the Rings trilogy."),
    ("Bilbo Baggins", "Bilbo Baggins is a hobbit who embarks on an unexpected adventure in 'The Hobbit' by J.R.R. Tolkien."),
    ("Frodo Baggins", "Frodo Baggins is a hobbit who undertakes the perilous journey to destroy the One Ring in 'The Lord of the Rings'."),
    ("Daenerys Targaryen", "Daenerys Targaryen is a key character in 'Game of Thrones' known for her dragons and ambition to reclaim the Iron Throne."),
    ("Gandalf the Grey", "Gandalf is a wise and powerful wizard in J.R.R. Tolkien's Middle-earth, known for his role in the fight against Sauron."),
    ("Arya Stark", "Arya Stark is a skilled assassin and member of the Stark family in 'Game of Thrones'."),
    ("Harry Potter", "Harry Potter is a young wizard known for defeating the dark wizard Voldemort."),
    ("Hermione Granger", "Hermione Granger is a talented witch and one of Harry Potter's closest friends, known for her intelligence and magical prowess."),
    ("Bilbo Baggins", "Bilbo Baggins is a hobbit who embarks on an unexpected adventure in 'The Hobbit' by J.R.R. Tolkien."),
    ("Frodo Baggins", "Frodo Baggins is a hobbit who undertakes the perilous journey to destroy the One Ring in 'The Lord of the Rings'."),
    ("Gandalf the Grey", "Gandalf is a wise and powerful wizard in J.R.R. Tolkien's Middle-earth, known for his role in the fight against Sauron.")
]

let sciFiCharactersData: [(String, String)] = [
    ("Luke Skywalker", "Luke Skywalker is a Jedi Knight in the Star Wars universe, known for his role in the Rebel Alliance's fight against the Empire."),
    ("Princess Leia", "Princess Leia is a leader in the Rebel Alliance and a key figure in the Star Wars saga."),
    ("Han Solo", "Han Solo is a charming smuggler and hero in the Star Wars universe."),
    ("Spock", "Spock is a Vulcan science officer and first officer of the USS Enterprise in 'Star Trek'."),
    ("Captain Kirk", "Captain James T. Kirk is the charismatic captain of the USS Enterprise in 'Star Trek'."),
    ("Ellen Ripley", "Ellen Ripley is the courageous protagonist of the 'Alien' film series."),
    ("The Doctor", "The Doctor is a time-traveling alien with many regenerations in the long-running series 'Doctor Who'."),
    ("Neo", "Neo is the central character in 'The Matrix' film trilogy, known for his role in the battle against the machines."),
    ("Princess Leia", "Princess Leia is a leader in the Rebel Alliance and a key figure in the Star Wars saga."),
    ("Han Solo", "Han Solo is a charming smuggler and hero in the Star Wars universe."),
    ("Spock", "Spock is a Vulcan science officer and first officer of the USS Enterprise in 'Star Trek'."),
    ("Captain Kirk", "Captain James T. Kirk is the charismatic captain of the USS Enterprise in 'Star Trek'.")
]

