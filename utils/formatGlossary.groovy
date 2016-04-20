#!/usr/bin/env groovy

import org.commonmark.ext.gfm.strikethrough.StrikethroughExtension
import org.commonmark.ext.gfm.tables.TablesExtension
import org.commonmark.node.AbstractVisitor
import org.commonmark.node.Header
import org.commonmark.node.Node
import org.commonmark.node.Text
import org.commonmark.parser.Parser

import java.util.stream.Collectors

/* Instructions:
  brew install groovy
*/

@Grapes([
        @Grab(group = 'com.atlassian.commonmark', module = 'commonmark', version = '0.3.2'),
        @Grab(group = 'com.atlassian.commonmark', module = 'commonmark-ext-gfm-tables', version = '0.3.2'),
        @Grab(group = 'com.atlassian.commonmark', module = 'commonmark-ext-gfm-strikethrough', version = '0.3.2')
        //@Grab(group = 'org.pegdown', module = 'pegdown', version = '1.6.0')
])
public class Glossary {
    final Parser parser = Parser.builder().extensions(Arrays.asList(TablesExtension.create(), StrikethroughExtension.create())).build();
    final Node document;

    public Glossary(File file) {
        document = parser.parseReader(new FileReader(file));


    }

    void format() {
        generateIndex()
    }

    void generateIndex() {
        new ToIndexTable(document).render()
    }
}

class ToIndexTable extends AbstractVisitor {
    def table = new TreeMap<Character, Map<String, SortedSet<String>>>()
    def cellsize = ["Acronyms": "Acronyms".size(), "Business Terms": "Business Terms".size(), "Technical Terms": "Technical Terms".size()]
    def current;

    public ToIndexTable(Node document) {
        document.accept(this)
    }

    @Override
    void visit(Header header) {
        def title = ((Text) header.firstChild).literal

        if (header.level == 1) {
            current = title

        } else if (header.level == 3) {
            def index = title.charAt(0)
            def terms = table.getOrDefault(index, new TreeMap<String, SortedSet<String>>() {
                {
                    put("Acronyms", new TreeSet<String>())
                    put("Business Terms", new TreeSet<String>())
                    put("Technical Terms", new TreeSet<String>())
                }
            })

            terms.get(current).add(title)
            table.put(index, terms)
        }

        super.visit(header)
    }

    def render() {
        def data = []
        table.entrySet().forEach({ e ->
            data.add([e.key, getColData(e.key, "Acronyms"), getColData(e.key, "Business Terms"), getColData(e.key, "Technical Terms")])
        })

        println("|   |" + getHeader("Acronyms") + "|" + getHeader("Business Terms") + "|" + getHeader("Technical Terms") + "|")
        println("|:-:|" + getHyphen("Acronyms") + "|" + getHyphen("Business Terms") + "|" + getHyphen("Technical Terms") + "|")
        data.forEach({ a ->
            println("| " + a[0] + " |" + a[1].padRight(cellsize.get("Acronyms")) + "|" + a[2].padRight(cellsize.get("Business Terms")) + "|" + a[3].padRight(cellsize.get("Technical Terms")) + "|")
        })

    }

    private String getHyphen(String type) {
        "".padRight(cellsize.get(type), "-")
    }

    private String getHeader(String type) {
        " " + type.padRight(cellsize.get(type) - 1)
    }

    private String getColData(Character key, String type) {
        def data = " " + String.join(",", table.get(key).get(type).stream().map({ v -> "[`" + v + "`](#" + v.toLowerCase() + ")" }).collect(Collectors.toList())) + " "
        cellsize.put(type, Math.max(cellsize.get(type), data.size()))
        data
    }
}

new Glossary(new File(args[0])).format()
