from flask import Flask
from flask import render_template
from flask import request
from flask import redirect
import pymysql
pymysql.install_as_MySQLdb()
from flask_mysqldb import MySQL
import MySQLdb.cursors

app = Flask(__name__)

app.config["MYSQL_USER"] = "hospital_flask_user"
app.config["MYSQL_PASSWORD"] = "not_secure_pw_987"
app.config["MYSQL_DB"] = "hospital"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"
 
mysql = MySQL(app)

@app.route("/")
def index():
  return render_template("index.html")

# nurses
@app.route("/nurses")
def nurses():
  cur=mysql.connection.cursor()
  cur.execute("SELECT first_name, last_name, nurse_type, patient_section FROM nurse")
  resultset = cur.fetchall()
  return render_template("nurses.html", nurses=resultset)

# doctors
@app.route("/doctors")
def doctors():
  cur=mysql.connection.cursor()
  cur.execute("SELECT first_name, last_name, extension_number, specialization FROM doctor")
  resultset = cur.fetchall()
  return render_template("doctors.html", doctors=resultset)

# update/delete patient (convert from team to patient)
@app.route("/patient", methods=["GET", "POST"])
def add_patient():
  cur=mysql.connection.cursor()
  if request.method=="POST":
    patient_id = request.form["patientID"]
    doctor_id = request.form["doctorID"]
    nurse_id = request.form['nurseID']
    first_name = request.form["firstName"]
    last_name = request.form["lastName"]
    room_number = request.form["roomNumber"]
    date_admitted = request.form["dateAdmitted"]
    # insert form data
    add_query = "INSERT INTO Patient (patient_id, doctor_id, nurse_id, first_name, last_name, room_number, date_admitted) VALUES (%s, %s, %s, %s, %s, %s, %s)" # NULL? 
    cur.execute(add_query, (patient_id, doctor_id, nurse_id, first_name, last_name, room_number, date_admitted))
    mysql.connection.commit()
    # redirect to teams page
    return redirect("/patients")
  else: 
    return render_template("patient.html", patient="", action="patient")

# patients
@app.route("/patients")
def patients():
  cur=mysql.connection.cursor()
  cur.execute("SELECT * FROM patient")
  resultset=cur.fetchall()
  return render_template("patients.html", patients=resultset)  

# patient health
@app.route("/patient_health")
def patient_health():
  cur=mysql.connection.cursor()
  cur.execute("SELECT * FROM patienthealth")
  resultset=cur.fetchall()
  return render_template("patients_health.html", patients_health=resultset)  


# delete patient (convert from team to patient)
@app.route("/patient/delete/<int:patient_id>")
def delete_patient(patient_id):
  cur = mysql.connection.cursor()
  del_query = "DELETE FROM Patient WHERE patient_id = %s"
  try:
    cur.execute(del_query, (patient_id))
    mysql.connection.commit()
    return redirect("/patients")
  except:
    return "<h2>There was an issue deleting the patient's records.</h2>"
  
# update patient (convert from team to patient) (cont 4:53)
@app.route("/patient/<int:patient_id>", methods=["GET", "POST"])
def update_patient(patient_id):
  cur=mysql.connection.cursor()
  if request.method=="POST":
    first_name = request.form["firstName"] #firstName????
    last_name = request.form["lastName"]
    room_number = request.form["roomNumber"]
    date_admitted = request.form["dateAdmitted"]
    update_query = "UPDATE patient SET first_name=%s, last_name=%s, room_number=%s, date_admitted=%s WHERE patient_id = %s"
    try: 
      cur.execute(update_query, (first_name, last_name, room_number, date_admitted, patient_id))
      mysql.connection.commit()
      return redirect("/patients")
    except:
      return "<h2>There was an issue updating the patient's information.</h2>"
  else:
    cur.execute("SELECT * FROM Patient WHERE patient_id = %s",(patient_id))
    patient_to_update = cur.fetchone()
    return render_template("patient.html", patient=patient_to_update, action=f"/patient/{patient_id}")



if __name__ == "__main__":
  app.run(debug=True) # don't need to restart server everytime we make a change to file