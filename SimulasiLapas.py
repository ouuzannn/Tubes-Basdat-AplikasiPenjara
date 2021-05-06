from flask import Flask,render_template,request,redirect

from flask_mysqldb import MySQL

app = Flask(__name__)

app.config['MYSQL_HOST'] = "localhost"
app.config['MYSQL_USER'] = "root"
app.config['MYSQL_PASSWORD'] = ""
app.config['MYSQL_DB'] = "penjaralapasrev1"

mysql = MySQL(app) 

@app.route('/',methods=['GET','POST']) #route awal
def login() :
        if request.method == 'POST' :
                username = request.form['username']
                password = request.form["password"]

                if (username=="Kepala Lapas" and password=="Kepala_Lapas"):
                        return redirect('/pegawai')
                elif (username=="Pegawai" and password=="Pegawai"):
                        return redirect('/napi')
                elif (username=="Pengunjung" and password==""):
                        return redirect('/kunjungan') #diarahkan ke route kunjungan
                else:
                        return render_template("login.html")
        return render_template('login.html')

@app.route('/kunjungan',methods=['GET','POST']) #route kunjungan
def kunjungan() :
        if request.method == 'POST' :
                no_ktp = request.form['no_ktp']
                NamaPengunjung = request.form["namaPengunjung"]
                alamat = request.form["alamat"]
                NoTahanan = request.form["NoTahanan"]
                waktu = request.form["waktu"]

                cur = mysql.connection.cursor()

                cur.execute("INSERT INTO pengunjung (no_ktp,nama_pengunjung,alamat_pengunjung,no_tahanan) VALUES (%s,%s,%s,%s)",(no_ktp,NamaPengunjung,alamat,NoTahanan))
                cur.execute("INSERT INTO kunjungan (no_ktp,no_tahanan,waktu) VALUES (%s,%s,%s)",(no_ktp,NoTahanan,waktu))


                mysql.connection.commit()

                cur.close()

                return render_template("menu.html")
        return render_template('kunjungan.html')


@app.route('/pegawai',methods=['GET','POST']) #route pegawai
def pegawai() :
        if request.method == 'POST' :
                ID_pegawai = request.form['ID_pegawai']
                nama_pegawai = request.form["nama_pegawai"]
                nama_lapas = request.form["nama_lapas"]

                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO pegawai (ID_pegawai,nama_pegawai,nama_lapas) VALUES (%s,%s,%s)",(ID_pegawai,nama_pegawai,nama_lapas))

                mysql.connection.commit()

                cur.close()

                return render_template("menu.html")
        return render_template('pegawai.html')


@app.route('/napi',methods=['GET','POST']) #route napi
def napi() :
        if request.method == 'POST' :
                no_tahanan = request.form['no_tahanan']
                nama_tahanan = request.form["nama_tahanan"]
                lama_penahanan = request.form["lama_penahanan"]
                kasus = request.form['kasus']
                tahun_masuk = request.form["tahun_masuk"]
                tahun_keluar = request.form["tahun_keluar"]
                no_ruangan = request.form['no_ruangan']

                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO napi (no_tahanan,nama_tahanan,lama_penahanan,kasus,tahun_masuk,tahun_keluar,no_ruangan) VALUES (%s,%s,%s,%s,%s,%s,%s)",(no_tahanan,nama_tahanan,lama_penahanan,kasus,tahun_masuk,tahun_keluar,no_ruangan))

                mysql.connection.commit()

                cur.close()

                return render_template("menu.html")
        return render_template('napi.html')

if __name__ == "__main__" :
    app.run(debug=True)
