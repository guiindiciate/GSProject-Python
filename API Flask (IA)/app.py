from flask import Flask, request, jsonify, render_template
import cv2
import numpy as np
from tensorflow.keras.models import load_model
import tensorflow as tf

app = Flask(__name__)

# Carregando o modelo Keras
modelo_keras = load_model('modelo_treinado.h5')
classes = ["Candidiase Cutânea", "Carcinoma de células escamosas", "Ceratose actinica", "Dermatite atópica", "Dermatofibroma", "Lesão vascular", "Melanoma", "Nevo melanocitico", "Verruga seborreica"]

@app.route('/')
def home():
    
    return render_template('index.html')

@app.route('/classificar', methods=['GET', 'POST'])
def classificar():
    if request.method == 'GET':
        return render_template('classificar.html')

    elif request.method == 'POST':
        imagem = request.files['imagem']
        nome = request.form['nome']

        # Corrigir o modo de leitura para evitar o aviso de depreciação
        imagem_array = cv2.imdecode(np.frombuffer(imagem.read(), np.uint8), cv2.IMREAD_COLOR)
        imagem_array = cv2.resize(imagem_array, (224, 224))
        imagem_array = np.expand_dims(imagem_array, axis=0) 

        # Fazer previsões com o modelo Keras carregado
        previsao_probabilidades = modelo_keras.predict(imagem_array)
        previsao_classe = np.argmax(previsao_probabilidades)
        classe_predita = classes[previsao_classe]

        # Retornar um JSON com as informações do usuário e a classe predita
        return jsonify({
            'nome': nome,
            'classe_predita': classe_predita
        })

if __name__ == '__main__':
    app.run(debug=True)