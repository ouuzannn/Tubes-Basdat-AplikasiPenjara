from flask import Flask,render_template,request,redirect

from flask_mysqldb import MySQL

app = Flask(__name__)

app.config['MYSQL_HOST'] = "localhost"
app.config['MYSQL_USER'] = "root"
app.config['MYSQL_PASSWORD'] = ""
# # #DB dari DODO
# app.config['MYSQL_DB'] = "penjara"

#DB dari ozan
app.config['MYSQL_DB'] = "penjara"

mysql = MySQL(app) 

#Form Login (Halaman Utama)
@app.route('/',methods=['GET','POST'])
def login() :
        if request.method == 'POST' :
                global username
                global password
                username = request.form['username']
                password = request.form["password"]

                if (username=="Kepala Lapas" and password=="Kepala_Lapas"): #DONE
                        return redirect('/OpsiKP') #Masuk dulu dia mau input pegawai baru apa hapus tahanan
                elif (username=="Pegawai" and password=="Pegawai"):#DONE
                        return redirect('/OpsiPegawai')
                elif (username=="Pengunjung" and password=="Pengunjung"):
                        return redirect('/OpsiPengunjung')
                else:
                        return render_template("login.html")
        return render_template('login.html')

@app.route('/OpsiPengunjung')
def OpsiPengunjung():
        return render_template('OpsiPengunjung.html')


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
                cur.execute("INSERT INTO kunjungan (no_ktp,nama_pengunjung,no_tahanan,waktu) VALUES (%s,%s,%s,%s)",(no_ktp,NamaPengunjung,NoTahanan,waktu))

                mysql.connection.commit()

                cur.close()

                return render_template("PengunjungBerhasil.html")
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

                return render_template("PegawaiBerhasil.html")
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

                try :
                        cur = mysql.connection.cursor()
                        cur.execute("INSERT INTO napi (no_tahanan,nama_tahanan,lama_penahanan,kasus,tahun_masuk,tahun_keluar,no_ruangan) VALUES (%s,%s,%s,%s,%s,%s,%s)",(no_tahanan,nama_tahanan,lama_penahanan,kasus,tahun_masuk,tahun_keluar,no_ruangan))

                        mysql.connection.commit()

                        cur.close()
                except :
                        return redirect('napi')

                return render_template("NapiBerhasil.html")
        return render_template('napi.html')

#Untuk meilhat list kunjungan
@app.route('/daftar_pengunjung')
def daftarpengunjung():
        cur = mysql.connection.cursor()
        cur.execute(f'SELECT pengunjung.no_ktp,pengunjung.nama_pengunjung,napi.no_tahanan,kunjungan.waktu,napi.no_ruangan FROM pengunjung INNER JOIN kunjungan ON kunjungan.no_ktp=pengunjung.no_ktp INNER JOIN napi ON napi.no_tahanan=pengunjung.no_tahanan') #3 TABEL
        #cur.execute(f'SELECT no_ktp,nama_pengunjung,alamat_pengunjung,no_tahanan,waktu,no_ruangan,kelas FROM kunjungan INNER JOIN pengunjung WHERE pengunjung.no_ktp=kunjungan.no_ktp INNER JOIN ruang_lapas where ruang_lapas.no_ruangan=pengunjung.no_tahanan IN (SELECT no_ruangan FROM napi WHERE napi.no_ruangan=kunjungan)')
        rv = cur.fetchall()
        return render_template("daftarpengunjung.html",value=rv)

@app.route('/OpsiKP',methods=['GET','POST'])
def OpsiKP():#DONE
        try : 
                if username == 'Kepala Lapas' :
                        return render_template("OpsiKP.html")
        except :
                return redirect('/')

#Untuk Hapus Tahanan
@app.route('/HapusTahanan',methods=['GET','POST'])
def HapusTahanan():
        if request.method== 'POST':
                IdNapi = request.form['id_napi']
                cur=mysql.connection.cursor()
                cur.execute(f"SELECT no_tahanan,nama_tahanan,lama_penahanan,kasus,no_ruangan,nama_lapas FROM napi NATURAL JOIN cabang_lapas where napi.no_tahanan='{IdNapi}'") #2 TABEL
                identitas_napi = cur.fetchall()
                return render_template('KonfirmasiHapus.html',identitas=identitas_napi,idnapi=IdNapi)
        return render_template("HapusTahanan.html")

@app.route('/KerjaHapus/<int:id>',methods=['GET','POST'])
def KonfirmasiHapusTahanan(id) :
        cur=mysql.connection.cursor()
        cur.execute(f"DELETE FROM napi WHERE napi.no_tahanan={id}")
        cur.execute(f"DELETE FROM kunjungan WHERE kunjungan.no_tahanan={id}")
        mysql.connection.commit()

        cur.close()
        return render_template('KembaliOpsiKP.html')

@app.route('/UsulanRemisi',methods=['GET','POST'])
def UsulanRemisi() :
        
        if request.method == 'POST' :
                
                no_tahanan = request.form['no_tahanan']
                pengurangan = request.form["pengurangan"]
                tmasuk = request.form["tmasuk"]
                tkeluar = request.form["tkeluar"]
                alasan = request.form["alasan"]
                try :
                        cur = mysql.connection.cursor()
                        cur.execute(f'INSERT INTO usulanremisi VALUES("{no_tahanan}","{pengurangan}","{tmasuk}","{tkeluar}","{alasan}")')

                        mysql.connection.commit()

                        cur.close()
                        
                        
                        return redirect("/OpsiPegawai")
                except :
                        return render_template('UsulanRemisi.html')
        return render_template('UsulanRemisi.html')

@app.route('/OpsiPegawai',methods=['GET','POST'])
def OpsiPegawai():
        try : 
                if username == 'Pegawai' :
                        return render_template("OpsiPegawai.html")
        except :
                return redirect('/')

@app.route('/TampilTahanan',methods=['GET','POST'])
def TampilTahanan():
        if request.method == 'POST' :
                idnapi = request.form["NoTahanan"]
                cur = mysql.connection.cursor()
                cur.execute(f"SELECT no_tahanan,nama_tahanan,no_ruangan FROM napi where napi.no_tahanan='{idnapi}' AND no_ruangan IN (select no_ruangan from ruang_lapas)")
                infotahanan = cur.fetchall()
                return render_template('InfoTahanan.html',infotahanan=infotahanan)
        return render_template('CariInfoTahanan.html')

@app.route('/TampilUsulanRemisi')
def NotifUsulanRemisi():
        cur =  mysql.connection.cursor()
        cur.execute(f'SELECT napi.no_tahanan,nama_tahanan,Pengurangan_Masa,usulanremisi.Tahun_masuk,usulanremisi.Tahun_Keluar,alasan from usulanremisi inner join napi on usulanremisi.no_tahanan = napi.no_tahanan')
        InfoRemisi = cur.fetchall()
        return render_template('TampilRemisi.html',InfoRemisi=InfoRemisi)


@app.route('/SetujuRemisi/<id>/<idhapus>')
def SetujuRemisi(id,idhapus):
        cur = mysql.connection.cursor()
        cur.execute(f'DELETE FROM usulanremisi WHERE usulanremisi.no_tahanan="{id}"')
        cur.execute(f'UPDATE napi SET napi.tahun_keluar=(select tahun_keluar FROM napi WHERE napi.no_tahanan="{id}")-{idhapus} WHERE napi.no_tahanan="{id}"')
        mysql.connection.commit()

        cur.close()

        return redirect('/TampilUsulanRemisi')

@app.route('/NotRemisi/<int:id>',methods=['GET','POST'])
def NotRemisi(id):
        
        cur = mysql.connection.cursor()
        cur.execute(f'DELETE FROM usulanremisi WHERE usulanremisi.no_tahanan={id}')
        mysql.connection.commit()

        cur.close()

        return redirect('/TampilUsulanRemisi')

@app.route('/diagram')
def diagram():
        return render_template("diagram.html")

@app.route('/column')
def column():
        cur = mysql.connection.cursor()
        cur.execute(f'SELECT * from ruang_lapas')
        Infodiagram = cur.fetchall()
        return render_template("column.php",Infodiagram=Infodiagram)

@app.route('/line')
def line():
        cur = mysql.connection.cursor()
        cur.execute(f'SELECT * from ruang_lapas')
        Infodiagram = cur.fetchall()
        return render_template("line.php",Infodiagram=Infodiagram)

@app.route('/pie')
def pie():
        cur = mysql.connection.cursor()
        cur.execute(f'SELECT * from ruang_lapas')
        Infodiagram = cur.fetchall()
        return render_template("pie.php",Infodiagram=Infodiagram)

@app.route('/donat')
def donat():
        cur = mysql.connection.cursor()
        cur.execute(f'SELECT * from ruang_lapas')
        Infodiagram = cur.fetchall()
        return render_template("donat.php",Infodiagram=Infodiagram)
        
if __name__ == "__main__" :
    app.run(debug=True)
