from pyramid.view import view_config
from pyramid.response import Response
from pyramid.httpexceptions import HTTPFound
from pyramid.url import route_url, urlencode

from dateutil.parser import parse
from datetime import datetime, date, timedelta

from google.appengine.ext import db
from google.appengine.api.datastore import Key

import models


def form1(request):
    # allow users to pick their teacher from dropdown menu
    teachers = models.Teacher.all()
    return dict(teachers = teachers)

def form2(request):
    # make sure they are arriving at this page after posting form
    try:
        date_1 = parse(request.params['date_1'])
    except KeyError, AttributeError:
        return HTTPFound(location = route_url('root', request))
    date_2 = parse(request.params['date_2'])
    # if they entered the beginning date as after the end go back.
    if date_1 > date_2:
        return HTTPFound(location = route_url('root', request))
    days = date_2 - date_1
    month_entries = int(round(int(days.days)/30))
    begin_day = date_1
    end_day = []
    params = request.params
    return dict (month_entries = month_entries, 
                 date_1 = date_1, date_2 = date_2, params=params)

def results(request):
    try:
        date_1 = parse(request.params['date_1'])
    except KeyError, AttributeError:
        return HTTPFound(location = route_url('root', request))
    params = request.params
    group = params['group']
    teacher_name = db.Key.from_path('Teacher', params['group'])
    new_student = models.Student(teacher = teacher_name, 
                                 name=params['name'], 
                                 zip_code=int(params['zip']), 
                                 month_entries = int(params['month_entries']), 
                                 residence_type=params['residence'],
                                 stories=int(params['stories']), 
                                 electricity=params['electricity'], 
                                 square_footage=int(params['sqfoot']),
                                 )
    new_student.put()
    date_range = parse(request.params['date_1'])
    billing = [31,28,31,30,31,30,31,31,30,31,30,31]
    month_name = (['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 
                  'Aug', 'Sep', 'Oct', 'Nov', 'Dec'])
    residence = request.params['residence']
    if residence == '1bdroomhouse' or residence == '2bdroomhouse' or residence == 'duplex' :
        energy = ([0.508425925925926,0.464537037037037, 0.526666666666667,
                  0.508148148148148, 0.549259259259259, 0.551759259259259,
                  0.63212962962963, 0.599166666666667, 0.517962962962963,
                  0.507962962962963, 0.495555555555556, 0.514166666666667])
        cooling = ([0,0,0.00231481481481481,0.0183333333333333,0.0911111111111111,
                    0.141574074074074,0.336759259259259,0.207222222222222,
                    0.0578703703703704,0,0,0])
        energy_total = 6.37556
    else:        
        energy = ([0.254125,0.2220625,0.2319375,0.211375,0.2086875,
                  0.2024375,0.2253125,0.213625,0.1944375,0.207125,
                  0.215375,0.246875])   
        cooling = ([0,0,0.0043125,0.0200625,0.096625,0.1564475,0.367375,
                   0.2230625,0.061875,0,0,0])
        energy_total = 2.633375
    energy_bill = []
    months = int(params['month_entries'])
    sqfoot = int(params['sqfoot'])
    m_count = 0
    date_delta = parse(request.params['date_1'])
    total = 0
    chart_useage = []
    chart_electricity = []
    chart_cooling = []
    chart_month = []
    for entries in range(1, months+1):
        m_count += 1
        bill = 'bill' + str(entries)        
        month = int(date_delta.month)
        year = int(date_delta.year)
        total += int(params[bill]) 
        student_useage = float(params[bill]) / sqfoot
        chart_month.append(month)
        chart_electricity.append(energy[month-1])
        chart_cooling.append((energy[month-1]+cooling[month-1]))
        chart_useage.append(student_useage)
        date_delta = date_delta + timedelta(days=31) 
        models.Bill(student=new_student, 
                    bill_month = date(year, month, 1), 
                    energy = int(params[bill])).put()
    average = total / months
    ny_average = int((energy_total * sqfoot) / 12)
    m_count = 0
    return dict(params = params, average = average, ny_average = ny_average,
                chart_useage = chart_useage, chart_electricity = chart_electricity,
                chart_cooling = chart_cooling, chart_month = chart_month)

def results2(request):
    '''
    This page just gives info on how to cut your electricity bill
    '''
    try:
        average = request.params['average']
    except KeyError, AttributeError:
        average = 0        
    return dict(average = average)

def teacherAdd(request):    
    #Add teacher form 
    return {'project':'energy'}

def teacherAdd2(request):
    #Add teacher form results
    try:
        name = request.params['name'] 
        # if someone landed here by typing the url bounce them out
    except KeyError, AttributeError:
        return HTTPFound(location = route_url('root', request))
    teacher_given = models.Teacher(key_name = name, full_name = name)
    teacher_given.put()
    sam = models.Student(teacher=teacher_given,
            name = 'TestStudent',
            electricity = 'yes',
            zip_code =10025,
            residence_type = 'studio',
            stories = 10,
            month_entries = 1,
            square_footage = 200)
    sam.put()
    models.Bill(student=sam,
        bill_month = date(2011, 1, 1),
        energy = 500).put()
    return {'project':'energy'}

def test(request):
    '''
    Python's csv module is causing CPU spikes and app shutdown 
    on google app engine.
    This is a work around to quickly download all data
    '''
    results = models.Student.all().order('-month_entries')
    end_day = models.Bill.all().order('-bill_month').get()
    start_day = models.Bill.all().order('bill_month').get()    
    date_range = start_day.bill_month
    m_count = 1
    body_print = ''
    body_print2 = ''
    body_print2 += 'Name'.ljust(12)
    body_print2 += '\t'
    body_print2 += 'Electricity'
    body_print2 += '\t'
    body_print2 += 'Residence'
    body_print2 += '\t'
    body_print2 += 'Sq Foot'.ljust(10)
    body_print2 += '\t'
    body_print2 += 'Stories'.ljust(10)
    body_print2 += '\t'
    body_print2 += 'Zip'
    body_print2 += '\n'
    body_print += ' '.ljust(12)
    body_print +='\t'
    body_print += date_range.strftime("%m-%y")
    body_print += '\t'      
    while True:
        m_count += 1
        date_range += timedelta(days=31)
        body_print += date_range.strftime("%m-%y")
        body_print += '\t'      
        if (date_range.month == end_day.bill_month.month) & \
           (date_range.year == end_day.bill_month.year):
            break
    body_print += '\n'                 
    teacher_results = models.Teacher.all()
    for teacher in teacher_results:
        body_print += teacher.full_name
        body_print += '\n'
        body_print2 += teacher.full_name
        body_print2 += '\n'
        test_results = models.Teacher.all().filter("full_name =", 
                                                   teacher.full_name).get().students
        i = 0
        for student in test_results:
            if i == 0:
                month_columns = int(student.month_entries)
                i += 1    
            body_print += student.name.ljust(12)
            body_print2 += student.name.ljust(12)
            body_print2 += '\t'
            body_print2 += student.electricity.ljust(12)
            body_print2 += '\t'
            body_print2 += student.residence_type.ljust(12)
            body_print2 += '\t'
            body_print2 += str(student.square_footage).ljust(12)
            body_print2 += '\t'
            body_print2 += str(student.stories).ljust(12)
            body_print2 += '\t'
            body_print2 += str(student.zip_code).ljust(12)
            body_print2 += '\n'
            body_print += '\t'
            bills = models.Student.all().filter("name =", 
                                                student.name).get().bills.order('bill_month')
            j = 0
            date_range = start_day.bill_month
            first_bill = bills.fetch(1)
            for b in first_bill:                
                my_bill = b.bill_month
            while date_range.year < my_bill.year:
                body_print += '\t'
                date_range += timedelta(days=31)
            while date_range.month < my_bill.month:
                body_print += '\t'
                date_range += timedelta(days=31)
            # start with start day
            # increment by 30 days
            # if first bill is equal to this okay, start printing them
            # else keep tabbing
            for stubs in bills:                
                body_print += str(stubs.energy)
                body_print += '\t'
            body_print += '\n'
        body_print += '\n'
    body_print += '\n'
    body_print += '\n'
    body_print += body_print2
    return Response(body=body_print, content_type='text/plain', 
                    headers={'Content-disposition':'attachment; filename=test.txt'})


