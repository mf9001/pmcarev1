import datetime
import db_ops as dbase


def get_avail_dates_mwf(mwfarea):
    output = dbase.query_field_list('mwf_schedules','area', mwfarea)
    json_input = {}
    j = 0

    for i in output:
        key_list = list(i.keys())
        id = key_list[0]
        row = i[id]
        op = _get_avail_dates_only(row, 2024, 7, 12, 14, 3)
        if(len(op) == 0):
            continue
        
        json_input.update({j : {"mwfid" : id, "dates": op}})
        j = j+1

    #json_input -->> {"0": {"mwfid": "247463", "dates": ["739082", "739085"]}, "1": {"mwfid": "247468", "dates": ["739083", "739085"]}}

    #array_output = dict()
    array_output = []
    post_id = 0

    for x in json_input:
        ext1 = json_input[x]

        mwfid = ext1["mwfid"]
        available_dates = ext1["dates"]
        mwf_name = get_mwf_name_by_id(mwfid)

        for y in available_dates:
            _date = str(datetime.date.fromordinal(int(y)))
            output = {"id": post_id, "mwfid": mwfid, "mwfname": mwf_name, "date": _date, "serialdate": str(y)}    
            post_id = post_id + 1
            #array_output[str(post_id)] = output
            array_output.append(output)

    return array_output

def _get_avail_dates_only(schedule_doc, y, m, d, horizon, no_of_max_options):

    NO_OF_SLOTS_PER_DAY = 4
    HORIZON_NO_OF_DAYS = horizon
    NO_OF_OPTIONS = no_of_max_options

    #Basedate 2024-01-01 => 738886
    date_time = datetime.datetime(y, m, d)
    serial_date_number = date_time.toordinal()
    week_day = date_time.date().weekday()
    #print('serial_date_number', serial_date_number)
    #print('week_day', week_day)

    roster_setup = list(schedule_doc["r"])
    adj_roster_setup = roster_setup[week_day+1:] + roster_setup[1:week_day+1] 
    adj_roster_setup = adj_roster_setup + adj_roster_setup

    #print('adj_roster_setup' , adj_roster_setup)

    next_days = [serial_date_number] * HORIZON_NO_OF_DAYS

    #print('next_days', next_days)

    for x in range(len(next_days)):
        next_days[x] = (next_days[x] * int(adj_roster_setup[x])) + (x * int(adj_roster_setup[x]))

    #print('next_days', next_days)

    avail_dates_five = []

    picked = 0

    for x in range(len(next_days)):
        no = next_days[x]
        if(no != 0):
            if(len(schedule_doc[str(no)]) < NO_OF_SLOTS_PER_DAY):

                avail_dates_five.append(str(no))

                #avail_dates_five.append(next_days[x])
                picked += 1

                if(picked == NO_OF_OPTIONS):
                    break

    #print('avail_dates_five', avail_dates_five)

    #print("avail_dates_five", avail_dates_five)

    return avail_dates_five    

def _get_avail_dates_mwf(schedule_doc, y, m, d, horizon, no_of_max_options):

    NO_OF_SLOTS_PER_DAY = 4
    HORIZON_NO_OF_DAYS = horizon
    NO_OF_OPTIONS = no_of_max_options

    #Basedate 2024-01-01 => 738886
    date_time = datetime.datetime(y, m, d)
    serial_date_number = date_time.toordinal()
    week_day = date_time.date().weekday()
    #print('serial_date_number', serial_date_number)
    #print('week_day', week_day)

    roster_setup = list(schedule_doc["r"])
    adj_roster_setup = roster_setup[week_day+1:] + roster_setup[1:week_day+1] 
    adj_roster_setup = adj_roster_setup + adj_roster_setup

    #print('adj_roster_setup' , adj_roster_setup)

    next_days = [serial_date_number] * HORIZON_NO_OF_DAYS

    #print('next_days', next_days)

    for x in range(len(next_days)):
        next_days[x] = (next_days[x] * int(adj_roster_setup[x])) + (x * int(adj_roster_setup[x]))

    #print('next_days', next_days)

    avail_dates_five = dict()

    picked = 0

    for x in range(len(next_days)):
        no = next_days[x]
        if(no != 0):
            if(len(schedule_doc[str(no)]) < NO_OF_SLOTS_PER_DAY):

                avail_dates_five[str(no)] = schedule_doc[str(no)]

                picked += 1

                if(picked == NO_OF_OPTIONS):
                    break

    return avail_dates_five



def get_mwf_name_by_id(mwf_id):
    doc = dbase.get_a_doc("mwf_profiles",mwf_id)
    return doc["mwf_name"]


def get_confirmed_appointment_for_parent(pid):
    oput = dict()
    oput = dbase.get_a_doc("confirmed_pnt_schedules", pid)
    if(oput != 0):
        timeslot = oput['slotid']
        time = ''
        match timeslot:
            case 1:
                time = '0900 hrs'
            case 2:
                time = '1030 hrs'
            case 3:
                time = '1400 hrs'
            case 4:
                time = '1530 hrs'

        oput['slotid'] = time

        oput['day']=str(datetime.date.fromordinal(int(oput['day'])))

        

        contacts = dbase.query_field_list("main_profiles", "uniqid", oput['mwfid'])
        keysList = list(contacts[0].keys())
        content = contacts[0]
        id = keysList[0]
        contact_details = content[id]
        for x in contact_details:
            oput.update({x: contact_details[x]})
        
        return oput