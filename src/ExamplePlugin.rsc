module ExamplePlugin 

extend lang::std::Layout;

import util::LanguageServer;
import util::IDEServices;
import util::Reflective;

import ParseTree;
import IO;

start syntax Example = choice: AOrB;

lexical AOrB = "A" | "B";

set[LanguageService] exampleContribution() = {
    parser(Tree (str input, loc src) {
        println("Parsing <src>");
        return parse(#start[Example], input, src);
    })
};

void main() {
    println("registering example language");
    registerLanguage(
        language(
            getProjectPathConfig(|project://vscode-test|),
            "example",
            "example",
            "ExamplePlugin",
            "exampleContribution"
        )
    );
}
