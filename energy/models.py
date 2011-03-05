from google.appengine.ext import db
import datetime
class Teacher(db.Model):
    full_name = db.StringProperty(required=True)
    school_name = db.StringProperty
    class_name = db.StringProperty
    
class Student(db.Model):
    teacher = db.ReferenceProperty(Teacher, collection_name='students')
    name = db.StringProperty(required=True)
    zip_code = db.IntegerProperty(required=True)
    square_footage = db.IntegerProperty(required=True)
    month_entries = db.IntegerProperty(required=True)
    residence_type = db.StringProperty(required=True)
    stories = db.IntegerProperty(required=True)
    electricity = db.StringProperty(required=True)
    
    
class Bill(db.Model):
    student = db.ReferenceProperty(Student, collection_name='bills')
    bill_month = db.DateProperty(required=True)
    energy = db.IntegerProperty(required=True)