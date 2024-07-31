from flask import Flask
import db_ops as dbase
import user_auth as uauth
import s as sch_engine
import json
import datetime
import feed_track as ft
import growth_track as gt

app = Flask(__name__)

dbase.db_init()

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

###=====================================Schedulig EdPoints=========================================

@app.route("/schedule/new_appointment/<mwfarea>")
def new_appointment(mwfarea):

    json_input = sch_engine.get_avail_dates_mwf(mwfarea)

    json_string = json.dumps(json_input)
    return json_string

    

        

    #return sch_engine.get_mwf_name_by_id("247463")

@app.route("/schedule/write")
def write():
    dbase.add_data()
    return "done"

def __check_confirmed_apps_per_pnt(pntid):
    
    content = dbase.get_a_doc("confirmed_pnt_schedules", pntid)
    
    return content


#End Point - Get Options for app - Requested by Parents

#End Point - Confirmt the app
#Use this in the schedule confimration by the parents, coming from the list confirmatoin
@app.route("/schedule/cofirm_app/<mwfid>/<day>/<slot>/<pid>")
def confirm_app(mwfid, day, slot, pid):
    output = dbase.get_a_doc("mwf_schedules", mwfid)
    day_entry = output[day]
    slot_list = list(day_entry.keys())

    new_data_confirm=0

    if(len(slot_list)==4):
        return "All slots gone"

    if slot in slot_list:
        for i in range(1,5,1):
            if str(i) in slot_list:
                pass
            else:
                new_data = {day : dict({str(i): pid})}
                new_data_confirm =  {"day" : day, "mwfid": mwfid, "slotid":i, "status": "Confirmed"}
                break
    else:
        new_data = {day : dict({slot: pid})}
        new_data_confirm =  {"day" : day, "mwfid": mwfid, "slotid":slot, "status": "Confirmed"}
        
    
    
    dbase.update("mwf_schedules", mwfid, new_data)
    dbase.update("confirmed_pnt_schedules", pid, new_data_confirm)

    return "Done"

#End point - confirmed Appointment

@app.route("/schedule/cofirmedapp/<pid>")
def cofirmed_app_by_pids(pid):
    output = sch_engine.get_confirmed_appointment_for_parent(pid)
    return json.dumps(output)

#End Point - MWf can enter the app directly

@app.route("/schedule/new_dir_app/<mwfid>/<day>/<slot>/<pid>")
def new_dir_app(mwfid, day, slot, pid):
    new_data = dict()
    new_data = {day : dict({slot: pid})}
    dbase.update("mwf_schedules", mwfid, new_data)
    return "Done"

#End Point - Get list of MWF in the given area
@app.route("/schedule/get_mwf_area/<mwfarea>")
def get_mwf_area(mwfarea):
    output = dbase.query_onefield('mwf_schedules','area', mwfarea)
    return json.dumps(output)


#End Point - List all apps (future) for P and MWF

#End Point - List all history apps for P and MWF

@app.route("/auth/uauth/<uname>/<password>")
def user_authenticatio(uname, password):
    response = uauth.authenticate_users(uname, password)
    return response

@app.route("/auth/register/<uname>/<email>/<password>")
def user_registration(uname, email, password):
    response = uauth.register_user(uname, email, password)
    return response

@app.route("/feeding/new_entry/<ptnid>/<stime>/<etime>/<dur>/<feedtype>/<bside>/<amount>/<unit>/<detils>")
def new_feeding_entry(ptnid, stime, etime, dur, feedtype, bside, amount, unit, detils):
    if(amount == 'NA'):
        amount = "0"
    response = ft.add_feeding_entry(ptnid, stime, etime, dur, feedtype, bside, amount, unit, detils)
    return response

@app.route("/growth/new_entry/<ptnid>/<stime>/<parameter>/<amount>/<unit>/<note>")
def new_growth_entry(ptnid, stime, parameter, amount, unit, note):
    response = gt.add_growth_entry(ptnid, stime, parameter, amount, unit, note)
    return response


@app.route("/feeding/get/<ptnid>")
def get_feed_records(ptnid):
    response = ft.get_feed_records(ptnid)
    
    return response

@app.route("/growth/get/<ptnid>/<paramid>")
def get_growth_records(ptnid, paramid):
    response = gt.get_growth_records(ptnid, paramid)
    
    return response


@app.route("/growth/delete/<docid>")
def delete_growth_record(docid):
    response = gt.delete_a_growth_record(docid)
    
    return response





