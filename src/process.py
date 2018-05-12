import json
import glob
import textfsm


class TemplateParser(object):
    def __init__(self):
        self.TEMPLATE_FILE = 'nirf.template'
        
        self.nested_fields = ['ProgramLevel',
                         'SourceOfPublicationData', 'FinancialYear']
        self.list_fields = ["GraduatedFullTimePhDStudents", "GraduatedPartTimePhDStudents"]
    
    def load_template(self):
        with open(self.TEMPLATE_FILE) as f:
            self.fsm = textfsm.TextFSM(f)

    def parse_file(self, file_path):
        print(f"Processing file {file_path}")
        
        self.load_template()
        details = {}

        fsm_results = self.fsm.ParseText(open(file_path).read())

        for row in fsm_results:
            nested_identifier = None
            
            for key, value in zip(self.fsm.header, row):

                if key in self.nested_fields and value != '':
                    nested_identifier = value
                    continue
                
                if key in self.list_fields and len(value) == 3:
                    details[key] = {}
                    details[key]["2016-17"], details[key]["2015-16"],\
                        details[key]["2014-15"] = value
                    continue

                if value != '' and value != []:
                    if nested_identifier:
                        try:
                            details[key][nested_identifier] = value
                        except:
                            details[key] = {}
                            details[key][nested_identifier] = value
                    else:
                        details[key] = value

        json_file_path = "{}.json".format(".".join(file_path.split(".")[:-1]))
        
        with open(json_file_path, 'w') as f:
            json.dump(details, f)

def main():
    template_parser = TemplateParser()
    pathlist = glob.iglob('./rankings/*/*.txt')
    list(map(template_parser.parse_file, map(str, pathlist)))

main()
