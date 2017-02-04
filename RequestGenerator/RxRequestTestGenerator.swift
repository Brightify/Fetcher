// ../Tests/RxFetcher/RxFetcher+RequestTest.swift
//
//  RxRequestTestGenerator.swift
//  Fetcher
//
//  Created by Filip Dolnik on 08.12.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

print("// This file is generated by RequestGenerator script.")
print("")
print("import Quick")
print("import Nimble")
print("import Fetcher")
print("import DataMapper")
print("import RxSwift")
print("")
print("class RxFetcher_RequestTest: QuickSpec {")
print("")
print("    override func spec() {")
print("        describe(\"RxFetcher\") {")
print("            var called = false")
print("            var disposeBag = DisposeBag()")
print("            beforeEach {")
print("                called = false")
print("                disposeBag = DisposeBag()")
print("            }")
print("")
for (oIndex, output) in outputTypes.enumerated() {
    for (iIndex, input) in inputTypes.enumerated() {
        print("            describe(\"request<\(input), \(output)>\") {")
        print("                it(\"works\") {")
        
        let genericSigniture = "<\(input.replacingOccurrences(of: "IN", with: "Int")), \(output.replacingOccurrences(of: "OUT", with: "Int"))>"
        
        let inputDataParameter: String
        if input.isVoid {
            inputDataParameter = ""
        } else if input.isData {
            inputDataParameter = ", input: \(data[iIndex]).data(using: .utf8)!"
        } else {
            inputDataParameter = ", input: \(data[iIndex])"
        }
        
        print("                    self.fetcher(response: \(jsonData[oIndex])).rx.request(POST\(genericSigniture)(\"xyz\")\(inputDataParameter)).subscribe(onNext: { response in")
        print("                        self.assertInput(request: response.request, expected: \(jsonData[iIndex]))")
        if output.isVoid {
            print("                        expect(response.result.value).toNot(beNil())")
        } else if output.isData {
            print("                        expect(response.result.value).toNot(beNil())")
            print("                        if let value = response.result.value {")
            print("                            expect(String(data: value, encoding: .utf8)) == \(data[oIndex])")
            print("                        }")
        } else if data[oIndex].contains("nil") {
            let value = data[oIndex].replacingOccurrences(of: "\"", with: "\\\"")
            print("                        expect(\"\\(response.result.value)\") == \"Optional(\(value))\"")
        } else {
            print("                        expect(response.result.value) == \(data[oIndex])")
        }
        print("                        called = true")
        print("                    }).addDisposableTo(disposeBag)")
        print("                    expect(called).toEventually(beTrue())")
        print("                }")
        print("            }")
    }
}
print("        }")
print("    }")
print("")
print("    private func assertInput(request: Request, expected: String, file: String = #file, line: UInt = #line) {")
print("        expect(request.httpBody, file: file, line: line).toNot(beNil())")
print("        if let input = request.httpBody, let json = String(data: input, encoding: .utf8) {")
print("            expect(json, file: file, line: line) == expected")
print("        }")
print("    }")
print("")
print("    private func fetcher(response: String) -> Fetcher {")
print("        let data = response.data(using: .utf8)!")
print("        let result = FetcherResult.success(data)")
print("        let requestPerformer = TestData.RequestPerformerStub(result: result, data: data)")
print("        return Fetcher(requestPerformer: requestPerformer)")
print("    }")
print("}")
