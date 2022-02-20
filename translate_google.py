import json
from glob import glob
from google.cloud import translate_v2 as translate

FILEPATH_GLOB = "lessons/pydata-en/*/homework_solution.ipynb"

files = [f for f in glob(FILEPATH_GLOB)]
for ff in files:
    print("Working on file:", ff)
    translate_client = translate.Client()
    with open(ff) as read:
        data = json.load(read)
        for i in range(len(data["cells"])):
            source = data["cells"][i]["source"] # list of strings to translate
            if len(source) > 0:
                result = translate_client.translate(source, target_language="en")
                data["cells"][i]["source"] = []
                for j in range(len(result)):
                    data["cells"][i]["source"].append(result[j]["translatedText"])
        
        with open(ff.replace(".ipynb", "_en.ipynb"), "w") as write:
            json_object = json.dumps(data, indent = 1)
            write.write(json_object)
