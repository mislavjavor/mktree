//
//  main.swift
//  treemake
//
//  Created by Mislav Javor on 04/04/2017.
//  Copyright © 2017 Mislav Javor. All rights reserved.
//

import Foundation

enum CreationOption {
    case file(name: String, content: String)
    case directory(name: String, files: [String])
    case goUp
    case invalid
    case end

    init(token: String) {
        let input = token.components(separatedBy: " ")
        guard input.count > 0 else { self = .invalid; return }

        let command = input[0]

        switch command {
        case "\\file":
            guard input.count >= 2 else { self = .invalid; return }
            let name = input[1]
            let content: String

            if input.count == 3 {
                content = input[3]
            } else {
                content = ""
            }

            self = .file(name: name, content: content)
        case "\\dir":
            guard input.count >= 2 else { self = .invalid; return }
            let name = input[1]

            let files = input.enumerated().filter { $0.offset > 1 }.map { $0.element }

            self = .directory(name: name, files: files)
        case "\\up":
            self = .goUp
        case "\\end":
            self = .end
        default: self = .invalid
        }
    }

}

func generatePath(from components: [String]) -> String {
    return components.joined(separator: "/")
}

print("Start creating directory structure")

var inputToken: String? = ""



var path = [String]()

if CommandLine.arguments.count == 2 {
    path.append(CommandLine.arguments[1])
} else {
    path.append(CommandLine.arguments[0])
}

print("Root directory name: ", terminator: "")
path.append(NSString(string: readLine()!).expandingTildeInPath)

do {
    try FileManager.default.createDirectory(atPath: generatePath(from: path), withIntermediateDirectories: false, attributes: nil)
} catch let error {
    print(error.localizedDescription)
}

print("{\(generatePath(from: path))} ~command >>", terminator: " ")

inputToken = readLine()

while let token = inputToken {

    let token = CreationOption(token: token)

    switch token {
    case .file(name: let name, content: let content):
        let withFile = path + [name]
        FileManager.default.createFile(atPath: generatePath(from: withFile),
                                       contents: content.data(using: .utf8),
                                       attributes: nil)
    case .directory(name: let name, let files):
        do {
            print("name: \(name) files: \(files)")
            let withDir = path + [name]
            try FileManager.default.createDirectory(atPath: generatePath(from: withDir),
                                                    withIntermediateDirectories: false,
                                                    attributes: nil)
            path.append(name)
            for file in files {
                let withFile = path + [file]
                FileManager.default.createFile(atPath: generatePath(from: withFile),
                                               contents: "".data(using: .utf8),
                                               attributes: nil)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    case .goUp:
        if path.isEmpty {
            print("Can't go up. You're in the initial directory")
        } else {
            path.removeLast()
        }
    case .invalid:
        print("Invalid command. Please try again")
    case .end:
        exit(0)
    }

    print("{\(generatePath(from: path))} ~command >>", terminator: " ")
    inputToken = readLine()
}
