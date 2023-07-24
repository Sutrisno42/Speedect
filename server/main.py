from flask import Flask, jsonify, request
from flask_restx import Api, Resource, reqparse
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import timedelta, datetime
import jwt
import base64
import pandas as pd
import numpy as np
from tensorflow import keras
from flask import Flask, render_template, request, redirect, url_for, jsonify
import librosa
import librosa.display
import pyaudio
import wave
import streamlit as st 
import mysql.connector
from werkzeug.utils import secure_filename
from werkzeug.datastructures import FileStorage
import os
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
# from wrap

# Initializing Flask
app = Flask(__name__, template_folder='templates', static_folder='staticFiles')
api = Api(app)

# app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "mysql://root:@127.0.0.1:3306/webservice"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db = SQLAlchemy(app)
ma = Marshmallow(app)

# def require_api_key(f):
#     @wraps(f)
#     def decorated_function(*args, **kwargs):
#         api_key = request.headers.get('API-Key')

#         if not api_key or api_key != app.config['SECRET_KEY']:
#             return jsonify({'error': 'Invalid API key'}), 401

#         return f(*args, **kwargs)

#     return decorated_function

### ----------- Database (Tabel Users) ----------- ###
class User(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    email = db.Column(db.String(100), unique=True, nullable=False)
    name = db.Column(db.String(100), nullable=False)
    password = db.Column(db.String(256), nullable=False)

@app.route("/api/create_user", methods=["GET"])
def user_db():
    with app.app_context():
        db.create_all()
        return "Database User Telah dibuat" + ' <a href="/"> Kembali</a>'


################################ Register #####################################

parser4Register = reqparse.RequestParser()
parser4Register.add_argument(
    'email', type=str, help="Email Anda", location='json', required=True)
parser4Register.add_argument(
    'name', type=str, help="Nama Anda", location='json', required=True)
parser4Register.add_argument(
    'password', type=str, help="Password", location='json', required=True)

@app.route('/register', methods=["GET", "POST"])
def flutter_register():
    if request.method == "POST":
        email = request.form["email"]
        name = request.form["name"]
        password = request.form["password"]

        loguser = db.session.execute(db.select(User).filter_by(email=email)).first()

        if loguser is None:
            register = User(email=email, name=name, password=generate_password_hash(password))
            db.session.add(register)
            db.session.commit() 
            return jsonify(["Register success, Silahkan Login!"])
        else:
            return jsonify(["Email Telah digunakan!"])
        
################################ Login #####################################

SECRET_KEY      = "WhatEverYouWant"
ISSUER          = "myFlaskWebservice"
AUDIENCE_MOBILE = "myMobileApp"
        
parser4LogIn = reqparse.RequestParser()
parser4LogIn.add_argument('email', type=str, help='Email', location='json', required=True)
parser4LogIn.add_argument('password', type=str, help='Password', location='json', required=True)

@app.route('/login', methods=["GET", "POST"])
def flutter_login():
    if request.method == "POST":
        email       = request.form['email']
        password    = request.form['password']
        # END: Get request parameters.

        if not email or not password:
            return jsonify(["masukan email"])

        # BEGIN: Check email existance.
        user = db.session.execute(
            db.select(User).filter_by(email=email)).first()

        if not user:
            return {
                'message' : "Email / Password Salah"
            }, 400
        else:
            user = user[0] # Unpack the array.
        # END: Check email existance.

        # BEGIN: Check password hash.
        if check_password_hash(user.password, password):
            payload = {
                'user_id': user.id,
                'email': user.email,
                'aud': AUDIENCE_MOBILE, # AUDIENCE_WEB
                'iss': ISSUER,
                'iat': datetime.utcnow(),
                'exp': datetime.utcnow() + timedelta(hours = 2)
            }
            token = jwt.encode(payload, SECRET_KEY)
            return {'message' : "berhasil",
                'token' : token
            },200
        else:
            return {
            'message' : 'email/password salah'
            },400
        # END: Check password hash.

#########################
##### END: Sign In #####
#######################

################################ Model #####################################
# loading the Trained Model
model = keras.models.load_model('model/my_model.h5')

# Categories (Emotion category)
labels = ['neutral', 'calm', 'happy', 'sad', 'angry', 'fearful', 'disgust', 'surprised']

app.config['FOLDER_AUDIO'] = 'save/'
ALLOWED_EXTENSIONS = set(['wav','mp3'])

class Detek(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    Name_File = db.Column(db.Text(), nullable=False)
    Emosi = db.Column(db.Text(), nullable=False)
    Waktu = db.Column(db.DATETIME, nullable=False)

class EmosiSchema(ma.SQLAlchemyAutoSchema):
     class Meta:
        model = Detek
        load_instance = True

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def extract_mfcc(wav_file_name):
    y, sr = librosa.load(wav_file_name)
    mfccs = np.mean(librosa.feature.mfcc(y=y, sr=sr, n_mfcc=40).T,axis=0)
    
    return mfccs


# Home page rendering
@app.route("/home")
def home():
    return render_template("home.html")

@app.route('/plot')
def plot():
    return render_template('plot.html')

@app.route('/streamlit')
def streamlit():
    st.set_page_config(page_title="My Streamlit App")
    st.write("Hello, world!")

# This is used to handel prediction 
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="webservice"
)


    

# @app.route('/predict2', methods=['GET', 'POST'])
# def upload_file1():
#     if request.method == 'POST':
#         f = request.files['file']
#         print("filename", f.filename)
#         paths = [f.filename]
#         pred_df = pd.DataFrame({'my': paths})
#         pred_X_mfcc = pred_df['my'].apply(lambda x: extract_mfcc(x))
#         pred_X = [x for x in pred_X_mfcc]
#         pred_X = np.array(pred_X)
#         pred_X = np.expand_dims(pred_X, -1)
#         pred = labels[model.predict(pred_X)[0].argmax()]  

#         # save_prediction(pred, f.filename)

#         return render_template('reaction.html',mode=str(pred))

@app.route('/detect_emotion', methods=['POST'])
def detect_emotion():
    # Check if audio file is present in the request
    if 'audio' not in request.files:
        return jsonify({'error': 'No audio file provided'})

    if request.method == "POST":
        file = request.files['audio']
        
        print("Sedang memproses audio ...")
        
        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['FOLDER_AUDIO'], filename))
        
        Name_File = 'save/' + file.filename
        
        # Extract MFCC features
        mfccs = extract_mfcc(Name_File)
        mfccs = (mfccs - np.mean(mfccs)) / np.std(mfccs)
        
        # Reshape MFCC features
        mfccs = np.array(mfccs)
        mfccs = np.expand_dims(mfccs, -1)

        # Perform emotion detection
        pred = labels[model.predict(mfccs)[0].argmax()]
        
        # Save result to database
        add = Detek(Name_File=Name_File, Emosi=pred)
        db.session.add(add)
        db.session.commit()

        return jsonify({
            'message': 'Berhasil',
            'labels': pred,
        })

    return jsonify({'error': 'Invalid request'})


@app.route('/history', methods=['GET'])
def save_prediction(pred, filename):
    mycursor = mydb.cursor()
    sql = "SELECT * FROM detek (Name_File, Emosi, waktu) VALUES (%s, %s, %s)"
    val = (filename , pred)
    mycursor.execute(sql, val)
    mydb.commit()
    mycursor.close()
    return jsonify({'history': save_prediction})
            
        # if label:
        #     return jsonify({'label': label})
        
        # return jsonify(["Audio gagal dikirim"])
        
##################################
@app.route("/api/detek", methods=["GET"])
def getAllAudio():
    history = Detek.query.all()
    Emosi_Schema = EmosiSchema(many=True)
    output = Emosi_Schema.dump(history)
    return jsonify(output)
#swager
@api.route('/api/detek')
class EmosiAPI(Resource):
    def get(self):
        log_data = db.session.execute(
            db.select(Detek.id, Detek.Name_File, Detek.Emosi, Detek
                      .Waktu)).all()
        if (log_data is None):
            return f"Tidak Ada Data!"
        else:
            data = []
            for history in log_data:
                data.append({
                    'id': history.id,
                    'Name_File': history.Name_File,
                    'Emosi': history.Emosi,
                    'Waktu': history.Waktu,

                })
            return data
        
##################### Edit User ###########################
@app.route('/edit', methods=["GET", "POST"])
def edit():
    if request.method == "POST":
        email = request.form.get("email")
        token = request.form.get("token")
        current_name = request.form.get("current_name")
        new_name = request.form.get("new_name")

        if not email or not token or not current_name or not new_name:
            return jsonify(["Semua kolom harus diisi!"]), 400

        # Validasi token
        if base64.b64decode(token).decode() != email:
            return jsonify(["Token tidak valid!"]), 400

        # Cek apakah email valid
        user = User.query.filter_by(email=email).first()
        if not user:
            return jsonify([f'Email tidak ditemukan!']), 400

        # Lakukan validasi password lama
        if user.name != current_name:
            return jsonify(["Nama lama tidak cocok!"]), 400

        # Lakukan perubahan data sesuai kebutuhan
        user.name = new_name

        # Simpan perubahan ke database
        db.session.commit()

        return jsonify(["Edit Data Success!"]), 200
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

# ...

# Endpoint untuk mengirim token ke email pengguna
import base64

@app.route('/send_token', methods=["POST"])
def send_token():
    if request.method == "POST":
        email = request.form["email"]

        if not email:
            return jsonify(["Masukkan email!"])

        # Mengirim email dengan token
        send_email(email)

        return jsonify({
            'message': f"Token telah dikirim ke {email}!"
        })

# Fungsi untuk mengirim email dengan token
def send_email(email):
    # Konfigurasi SMTP server
    smtp_host = 'smtp.gmail.com'
    smtp_port = '587'
    smtp_username = 'cirengkering1@gmail.com'
    smtp_password = 'vznfququdiascahm'
    sender_email = 'cirengkering1@gmail.com'

    # Membuat token
    token = base64.b64encode(email.encode()).decode()

    print("Token:", token)

    # Membuat objek email
    msg = MIMEMultipart()
    msg['From'] = sender_email
    msg['To'] = email
    msg['Subject'] = 'Password Reset Token'
    body = f'Your token is: {token}'
    msg.attach(MIMEText(body, 'plain'))

    # Mengirim email menggunakan SMTP server
    with smtplib.SMTP(smtp_host, smtp_port) as server:
        server.starttls()
        server.login(smtp_username, smtp_password)
        server.send_message(msg)
        
#######################Edit Password###################
@app.route('/changepassword', methods=["POST"])
def change_password():
    if request.method == "POST":
        email = request.form["email"]
        token = request.form["token"]
        current_password = request.form["current_password"]
        new_password = request.form["new_password"]

        if not email or not token or not current_password or not new_password:
            return jsonify(["Masukkan email, token, password lama, dan password baru!"])

        # Validasi token
        if base64.b64decode(token).decode() != email:
            return jsonify(["Token tidak valid!"])

        # Validasi password lama
        user = db.session.execute(
            db.select(User).filter_by(email=email)).first()

        if not user:
            return jsonify(["Email tidak ditemukan!"])
        else:
            user = user[0]

        if check_password_hash(user.password, current_password):
            # Ubah password
            user.password = generate_password_hash(new_password)

            # Simpan perubahan pada database
            db.session.commit()

            return jsonify(
                {
                    'message': f"Password berhasil diubah!",
                    # 'token': token
                }
            )
        else:
            return jsonify(["Password lama tidak cocok!"])


    


if __name__ == "__main__":
    app.run(debug=True, host="192.168.56.40")