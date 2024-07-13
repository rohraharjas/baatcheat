from flask import Flask, jsonify, request
from langs import langs
from transformers import AutoModelForSeq2SeqLM, AutoTokenizer, pipeline
from langs import langs
from datetime import datetime

app = Flask(__name__)

@app.route("/get-languages",methods=['GET'])
def getLangs():
    return langs

@app.route("/translate", methods=['GET'])
def translate():
    try:
        srcLang = request.args.get('srcLang')
        destLang = request.args.get('destLang')
        text = request.args.get('text')

        if not srcLang or not destLang or not text:
            raise ValueError("Missing query parameters: srcLang, destLang, or text")

        st_time = datetime.now()
        model = AutoModelForSeq2SeqLM.from_pretrained('facebook/nllb-200-distilled-600M')
        tokenizer = AutoTokenizer.from_pretrained('facebook/nllb-200-distilled-600M')
        translate_pipeline = pipeline('translation', model=model, tokenizer=tokenizer, src_lang=srcLang, tgt_lang=destLang)
        translated_text = translate_pipeline(text)[0]['translation_text']
        end_time = datetime.now()

        output = {
            'output': translated_text,
            'time': (end_time - st_time).total_seconds()
        }
    except Exception as e:
        output = {
            'error': str(e)
        }

    return jsonify(output)

if __name__ == "__main__":
    app.run(debug=True)