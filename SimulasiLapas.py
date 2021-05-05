from flask import Flask,render_template,request

from flask_mysqldb import MySQL

app = Flask(__name__)

app.config['MYSQL_HOST'] = "localhost"
app.config['MYSQL_USER'] = "root"
app.config['MYSQL_PASSWORD'] = ""
app.config['MYSQL_DB'] = "contoh2"

mysql = MySQL(app) 

@app.route('/',methods=['GET','POST'])
def index() :
        if request.method == 'POST' :
                username = request.form['username']
                email = request.form["email"]

                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO validasi (username,email) VALUES (%s,%s)",(username,email))

                mysql.connection.commit()

                cur.close()
                return "success"
        return render_template('index.html')

@app.route('/users')
def users():
         cur = mysql.connection.cursor()
         users = cur.execute("SELECT * FROM validasi")

         if users > 0:
                 userDetails = cur.fetchall()

                 return render_template('user.html',userDetails=userDetails)



if __name__ == "__main__" :
    app.run(debug=True)