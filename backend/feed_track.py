import db_ops as dbase
import datetime as dt

def add_feeding_entry(ptnid, stime, etime, duration, feedtype, bside, amount, unit, detils):
#2024-07-20 17:32:18.525578 <- Drt format
#receving format 2024-07-26 12:07

    stimeProc = _convert_date_time(stime)
    etimeProc = _convert_date_time(etime)
    
    data = {"pntid": ptnid, "stime": stimeProc, "etime": etimeProc, "duration": duration, "feedtype": feedtype, "bside": bside, "amount": amount, "unit": unit, "detils": detils}
    dbase.insert_doc_auto("feed_track", data)
    return "ok"


def _convert_date_time(dateandtimeinput):
    date_split = list(dateandtimeinput.split(" "))
    d = list(date_split[0].split("-"))
    t = list(date_split[1].split(":"))
    
    dateTimeObj = d[0] + "-" + d[1] +"-"+ d[2] +" "+ t[0] +":"+ d[1]
    return dateTimeObj


def get_feed_records(ptnid):
    content = dbase.query_field_list_orderby("feed_track", "pntid", ptnid, "stime")

    array_collector = []  
    i = 0 

    for x in content:
        first_index = list(x.keys())[0]
        y = x[first_index]
        y["recid"]=i
        i = i + 1
        array_collector.append(y)    

    return array_collector