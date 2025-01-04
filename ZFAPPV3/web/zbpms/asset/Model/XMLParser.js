export default class XMLParser{
    xmlElements(xml_content , tag_name){
        let parser = new DOMParser();
        let element_parsed = parser.parseFromString(xml_content.xml,"text/xml");
        let xml_element = element_parsed.getElementsByTagName(tag_name);
        return xml_element;
    }
}