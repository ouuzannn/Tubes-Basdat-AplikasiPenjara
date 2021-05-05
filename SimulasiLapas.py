from flask import Flask,render_template,request,redirect

from flask_mysqldb import MySQL

app = Flask(__name__)

app.config['MYSQL_HOST'] = "localhost"
app.config['MYSQL_USER'] = "root"
app.config['MYSQL_PASSWORD'] = ""
app.config['MYSQL_DB'] = "penjara lapas"

mysql = MySQL(app) 

@app.route('/',methods=['GET','POST'])
def index() :
        if request.method == 'POST' :
                no_ktp = request.form['no_ktp']
                NamaPengunjung = request.form["namapengunjung"]
                alamat = request.form["alamat"]
                NoTahanan = request.form["NoTahanan"]
                waktu = request.form["waktu"]

                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO pengunjung (no_ktp,nama_pengunjung,alamat_pengunjung,no_tahanan) VALUES (%s,%s,%s,%s)",(no_ktp,NamaPengunjung,alamat,NoTahanan,waktu))

                mysql.connection.commit()

                cur.close()

                return render_template("menu.html")
        return render_template('index.html')


@app.route('/pengguna',methods=['GET','POST'])
def users():
        if request.method == "GET" :
                cur = mysql.connection.cursor()
                users = cur.execute("SELECT * FROM validasi")

                userDetails = cur.fetchall()
        return render_template('users.html',userDetailshtml=userDetails)



if __name__ == "__main__" :
    app.run(debug=True)