from flask import Flask,render_template,request,redirect

from flask_mysqldb import MySQL

app = Flask(__name__)

app.config['MYSQL_HOST'] = "localhost"
app.config['MYSQL_USER'] = "root"
app.config['MYSQL_PASSWORD'] = ""
#DB dari DODO
#app.config['MYSQL_DB'] = "penjara"

#DB dari ozan
app.config['MYSQL_DB'] = "penjaralapasrev1"

mysql = MySQL(app) 

#Form Login (Halaman Utama)
@app.route('/',methods=['GET','POST'])
def login() :
        if request.method == 'POST' :
                username = request.form['username']
                password = request.form["password"]

                if (username=="Kepala Lapas" and password=="Kepala_Lapas"):
                        return redirect('/OpsiKP') #Masuk dulu dia mau input pegawai baru apa hapus tahanan
                elif (username=="Pegawai" and password=="Pegawai"):
                        return redirect('/napi')
                elif (username=="Pengunjung" and password==""):
                        return redirect('/kunjungan')
                else:
                        return render_template("login.html")
        return render_template('login.html')

#Input Pengunjung Jika mau berkunjung ke apas (melihat tahanan)
@app.route('/kunjungan',methods=['GET','POST'])
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

#input pegawai baru 
@app.route('/PegawaiBaru',methods=['GET','POST'])
def PegawaiBaru() :
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

#Input napi (tahanan baru)
@app.route('/napi',methods=['GET','POST'])
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

#Untuk meilhat list kunjungan
@app.route('/daftar_pengunjung')
def gaji():
        cur = mysql.connection.cursor()
        cur.execute('''SELECT no_ktp, nama_pengunjung, alamat_pengunjung, no_tahanan, waktu FROM kunjungan NATURAL JOIN pengunjung''')
        rv = cur.fetchall()
        return render_template("daftarpengunjung.html",value=rv)

@app.route('/OpsiKP',methods=['GET','POST'])
def OpsiKP():
        return render_template("OpsiKP.html")

#Untuk Hapus Tahanan
@app.route('/HapusTahanan')
def HapusTahanan():
        return render_template("HapusTahanan.html")

if __name__ == "__main__" :
    app.run(debug=True)
